#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# Longest-side (natural) or square canvas size ladder.
PNG_SIZES=(${PNG_SIZES:-16 32 48 64 128 180 192 256 512 1024})
# Embedded sizes for square favicon ICOs only.
ICO_SIZES=(${ICO_SIZES:-16 32 48 64 128 256})
SQUARE_RATIO_TOL="${SQUARE_RATIO_TOL:-0.08}"

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
echo "png sizes: ${PNG_SIZES[*]}"
echo "ico sizes: ${ICO_SIZES[*]}"

viewbox_size() {
  local src="$1"
  python3 - "$src" <<'PY'
import re, sys
text = open(sys.argv[1], encoding="utf-8").read()
m = re.search(r'viewBox="0 0 ([0-9.]+) ([0-9.]+)"', text)
if not m:
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

# Square canvas for near-square artwork (circles, icons, AZD logos).
# Natural aspect for wide marks / banners — size is the longer side.
is_square_export() {
  local base="$1"
  local vw="$2"
  local vh="$3"
  if [[ "$base" == circle* || "$base" == icon* ]]; then
    return 0
  fi
  python3 - "$vw" "$vh" "$SQUARE_RATIO_TOL" <<'PY'
import sys
vw, vh, tol = map(float, sys.argv[1:4])
ratio = max(vw, vh) / min(vw, vh)
sys.exit(0 if ratio <= 1.0 + tol else 1)
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

src, dest, size_s, vw_s, vh_s, bg, backend, im, square_s = sys.argv[1:10]
size = int(size_s)
vw, vh = float(vw_s), float(vh_s)
square = square_s == "1"
scale = size / max(vw, vh)
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
            str(dest),
        ]
    )
else:
    subprocess.check_call([im, str(tmp), str(dest)])

tmp.unlink(missing_ok=True)
PY
}

export_ico() {
  local png_root="$1"
  local ico_path="$2"
  local base="$3"
  shift 3
  local sizes=("$@")

  mkdir -p "$(dirname "$ico_path")"

  local inputs=()
  local size
  for size in "${sizes[@]}"; do
    inputs+=("${png_root}/${size}/${base}.png")
  done

  "$IM" "${inputs[@]}" "$ico_path"
}

export_brand() {
  local brand_dir="$1"
  local svg_dir="${brand_dir}/svg"
  local png_dir="${brand_dir}/png"
  local ico_dir="${brand_dir}/ico"
  local count_svg=0
  local count_png=0
  local count_ico=0

  find "$png_dir" -maxdepth 1 -type f -name '*.png' -delete 2>/dev/null || true
  mkdir -p "$ico_dir"
  find "$ico_dir" -maxdepth 1 -type f -name '*.ico' -delete 2>/dev/null || true

  while IFS= read -r -d '' src; do
    local base
    base="$(basename "$src" .svg)"
    local bg
    bg="$(background_for "$base")"
    local dims
    dims="$(viewbox_size "$src")"
    local vw="${dims%% *}"
    local vh="${dims##* }"
    local square=0
    local mode="natural"
    if is_square_export "$base" "$vw" "$vh"; then
      square=1
      mode="square"
    fi
    local size

    for size in "${PNG_SIZES[@]}"; do
      export_png "$src" "${png_dir}/${size}/${base}.png" "$size" "$bg" "$square"
      count_png=$((count_png + 1))
    done

    if [[ "$square" -eq 1 ]]; then
      export_ico "$png_dir" "${ico_dir}/${base}.ico" "$base" "${ICO_SIZES[@]}"
      count_ico=$((count_ico + 1))
      echo "exported ${base} (${#PNG_SIZES[@]} png ${mode} + ico)"
    else
      echo "exported ${base} (${#PNG_SIZES[@]} png ${mode})"
    fi
    count_svg=$((count_svg + 1))
  done < <(find "$svg_dir" -type f -name '*.svg' -print0 | sort -z)

  echo "brand ${brand_dir}: ${count_svg} svg → ${count_png} png, ${count_ico} ico"
}

export_brand "brand/helpwave"
export_brand "brand/app-zum-doc"

echo "done"
