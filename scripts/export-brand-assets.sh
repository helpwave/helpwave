#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# Logo PNGs are square. Banner PNGs use this value as the shorter side.
# SIZES is the default ladder. PNG_SIZES and ICO_SIZES override it.
DEFAULT_SIZES=(16 32 48 64 128 180 192 256 512 1024)
SIZES=(${SIZES:-${DEFAULT_SIZES[*]}})
PNG_SIZES=(${PNG_SIZES:-${SIZES[*]}})
ICO_SIZES=(${ICO_SIZES:-${SIZES[*]}})

BACKEND=""
if command -v rsvg-convert >/dev/null 2>&1; then
  BACKEND="rsvg-convert"
elif command -v inkscape >/dev/null 2>&1; then
  BACKEND="inkscape"
else
  echo "Need rsvg-convert (preferred, matches CI) or inkscape to export PNGs" >&2
  exit 1
fi

IM=""
if command -v magick >/dev/null 2>&1; then
  IM="magick"
elif command -v convert >/dev/null 2>&1; then
  IM="convert"
else
  echo 'Need ImageMagick (magick or convert) to composite PNGs and build ICOs' >&2
  exit 1
fi

echo "using ${BACKEND} + ${IM}"
echo "sizes: ${SIZES[*]}"
echo "png sizes: ${PNG_SIZES[*]}"
echo "ico sizes: ${ICO_SIZES[*]}"

viewbox_size() {
  local src="$1"
  python3 - "$src" <<'PY'
import re, sys
text = open(sys.argv[1], encoding="utf-8").read()
m = re.search(
    r'viewBox="([0-9.+-eE]+)\s+([0-9.+-eE]+)\s+([0-9.+-eE]+)\s+([0-9.+-eE]+)"',
    text,
)
if m:
    print(float(m.group(3)), float(m.group(4)))
    raise SystemExit(0)
m = re.search(r'width="([0-9.]+)"[^>]*height="([0-9.]+)"', text)
if not m:
    raise SystemExit(f"cannot read size from {sys.argv[1]}")
print(float(m.group(1)), float(m.group(2)))
PY
}

background_for() {
  local base="$1"
  if [[ "$base" == *-on-white* || "$base" == *-badge-on-white* ]]; then
    echo "white"
  elif [[ "$base" == *-on-black* || "$base" == *-white-on-black* ]]; then
    echo "black"
  elif [[ "$base" == *-on-teal* ]]; then
    echo "#095763"
  else
    echo "none"
  fi
}

is_quadratic() {
  local vw="$1"
  local vh="$2"
  python3 - "$vw" "$vh" <<'PY'
import sys
vw, vh = map(float, sys.argv[1:3])
limit = max(vw, vh) * 1e-4
sys.exit(0 if abs(vw - vh) <= limit else 1)
PY
}

export_png() {
  local src="$1"
  local dest="$2"
  local size="$3"
  local bg="$4"
  local square="$5"
  local dims
  dims="$(viewbox_size "$src")"
  local vw="${dims%% *}"
  local vh="${dims##* }"

  mkdir -p "$(dirname "$dest")"

  python3 - "$src" "$dest" "$size" "$vw" "$vh" "$bg" "$BACKEND" "$IM" "$square" <<'PY'
import subprocess
import sys
from pathlib import Path

src, dest, size_s, vw_s, vh_s, bg, backend, im, kind = sys.argv[1:10]
size = int(size_s)
vw, vh = float(vw_s), float(vh_s)
square = kind == "logo"
edge = max(vw, vh) if square else min(vw, vh)
scale = size / edge
rw = max(1, int(round(vw * scale)))
rh = max(1, int(round(vh * scale)))
tmp = Path(dest).with_suffix(".tmp.png")

if backend == "rsvg-convert":
    subprocess.check_call(
        ["rsvg-convert", "-f", "png", "-w", str(rw), "-h", str(rh), "-o", str(tmp), src]
    )
else:
    subprocess.check_call(
        [
            "inkscape",
            src,
            "--export-type=png",
            f"--export-filename={tmp}",
            "-w",
            str(rw),
            "-h",
            str(rh),
        ],
        stdout=subprocess.DEVNULL,
    )

# -strip drops volatile PNG tIME/metadata so CI byte-diff stays stable.
if square:
    canvas = f"xc:{bg}" if bg != "none" else "xc:none"
    subprocess.check_call(
        [
            im,
            "-size",
            f"{size}x{size}",
            canvas,
            str(tmp),
            "-gravity",
            "center",
            "-compose",
            "over",
            "-composite",
            "-strip",
            str(dest),
        ]
    )
elif bg != "none":
    subprocess.check_call(
        [
            im,
            "-size",
            f"{rw}x{rh}",
            f"xc:{bg}",
            str(tmp),
            "-gravity",
            "center",
            "-compose",
            "over",
            "-composite",
            "-strip",
            str(dest),
        ]
    )
else:
    subprocess.check_call([im, str(tmp), "-strip", str(dest)])

tmp.unlink(missing_ok=True)
PY
}

export_ico() {
  local src_png="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  python3 - "$src_png" "$dest" <<'PY'
import struct
import sys
from pathlib import Path

src, dest = sys.argv[1:]
png = Path(src).read_bytes()
if not png.startswith(b"\x89PNG\r\n\x1a\n") or png[12:16] != b"IHDR":
    raise SystemExit(f"{src} is not a PNG")
width = int.from_bytes(png[16:20], "big")
height = int.from_bytes(png[20:24], "big")
entry_width = 0 if width >= 256 else width
entry_height = 0 if height >= 256 else height
header = struct.pack("<HHH", 0, 1, 1)
entry = struct.pack("<BBBBHHII", entry_width, entry_height, 0, 0, 1, 32, len(png), 22)
Path(dest).write_bytes(header + entry + png)
PY
}

export_group() {
  local brand_dir="$1"
  local kind="$2"
  local svg_dir="${brand_dir}/${kind}/svg"
  local png_dir="${brand_dir}/${kind}/png"
  local ico_dir="${brand_dir}/${kind}/ico"
  local count_svg=0
  local count_png=0
  local count_ico=0
  local -A png_size_set=()
  local size
  for size in "${PNG_SIZES[@]}"; do
    png_size_set["$size"]=1
  done

  rm -rf "$png_dir"
  if [[ "$kind" == "logo" ]]; then
    rm -rf "$ico_dir"
  elif [[ -d "$ico_dir" ]]; then
    echo "${kind} assets do not get ICOs: ${ico_dir}" >&2
    exit 1
  fi

  while IFS= read -r -d '' src; do
    local base
    base="$(basename "$src" .svg)"
    local bg
    bg="$(background_for "$base")"
    local dims
    dims="$(viewbox_size "$src")"
    local vw="${dims%% *}"
    local vh="${dims##* }"
    if [[ "$kind" == "logo" ]] && ! is_quadratic "$vw" "$vh"; then
      echo "${src}: logo SVG must be quadratic (viewBox ${vw}x${vh})" >&2
      exit 1
    fi
    local size

    for size in "${PNG_SIZES[@]}"; do
      export_png "$src" "${png_dir}/${size}/${base}.png" "$size" "$bg" "$kind"
      count_png=$((count_png + 1))
    done

    if [[ "$kind" == "logo" ]]; then
      for size in "${ICO_SIZES[@]}"; do
        local png_src="${png_dir}/${size}/${base}.png"
        local cleanup=""
        if [[ -z "${png_size_set[$size]:-}" ]]; then
          cleanup="$(mktemp --suffix=.png)"
          export_png "$src" "$cleanup" "$size" "$bg" "logo"
          png_src="$cleanup"
        fi
        export_ico "$png_src" "${ico_dir}/${size}/${base}.ico"
        if [[ -n "$cleanup" ]]; then
          rm -f "$cleanup"
        fi
        count_ico=$((count_ico + 1))
      done
      echo "exported ${kind}/${base} (${#PNG_SIZES[@]} png + ${#ICO_SIZES[@]} ico)"
    else
      echo "exported ${kind}/${base} (${#PNG_SIZES[@]} png, shorter side)"
    fi
    count_svg=$((count_svg + 1))
  done < <(find "$svg_dir" -type f -name '*.svg' -print0 | sort -z)

  echo "brand ${brand_dir}/${kind}: ${count_svg} svg → ${count_png} png, ${count_ico} ico"
}

if [[ $# -gt 0 ]]; then
  brand_dirs=()
  for name in "$@"; do
    if [[ "$name" == brand/* ]]; then
      brand_dirs+=("${name%/}")
    else
      brand_dirs+=("brand/${name%/}")
    fi
  done
else
  shopt -s nullglob
  brand_dirs=(brand/*/)
  shopt -u nullglob
fi

if [[ ${#brand_dirs[@]} -eq 0 ]]; then
  echo "No brand directories under brand/" >&2
  exit 1
fi

exported_any=0
for brand_dir in "${brand_dirs[@]}"; do
  brand_dir="${brand_dir%/}"
  kind_found=0
  for kind in logo banner; do
    svg_dir="${brand_dir}/${kind}/svg"
    if [[ ! -d "$svg_dir" ]]; then
      continue
    fi
    if ! find "$svg_dir" -type f -name '*.svg' -print -quit | grep -q .; then
      continue
    fi
    export_group "$brand_dir" "$kind"
    kind_found=1
    exported_any=1
  done
  if [[ "$kind_found" -ne 1 ]]; then
    echo "skip ${brand_dir}: no logo/svg or banner/svg" >&2
  fi
done

if [[ "$exported_any" -ne 1 ]]; then
  echo "No SVG sources found under brand/*/logo/svg or brand/*/banner/svg" >&2
  exit 1
fi

echo "done"
