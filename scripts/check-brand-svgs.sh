#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python3 <<'PY'
from pathlib import Path
import re
import sys
import subprocess
import tempfile

SVG_PAD_TOL = 0.04
PNG_SIZE_TOL = 1
PNG_SIZES = [16, 32, 48, 64, 128, 180, 192, 256, 512, 1024]
ICO_SIZES = [16, 32, 48, 64, 128, 256]
SQUARE_RATIO_TOL = 0.08


def resolve_im() -> str:
    for name in ('magick', 'convert'):
        if (
            subprocess.call(
                ['bash', '-lc', f'command -v {name}'],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            == 0
        ):
            return name
    raise SystemExit('Need ImageMagick (magick or convert)')


IM = resolve_im()


def render_svg(svg: Path, png: Path) -> None:
    if subprocess.call(
        ['bash', '-lc', 'command -v rsvg-convert'],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    ) == 0:
        subprocess.check_call(
            ['rsvg-convert', '-f', 'png', '-o', str(png), str(svg)],
            stdout=subprocess.DEVNULL,
        )
        return
    subprocess.check_call(
        ['nix-shell', '-p', 'librsvg', '--run', f'rsvg-convert -f png -o {png} {svg}'],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def viewbox(svg: Path) -> tuple[float, float]:
    text = svg.read_text(encoding='utf-8')
    vb = re.search(
        r'viewBox="([0-9.+-eE]+)\s+([0-9.+-eE]+)\s+([0-9.+-eE]+)\s+([0-9.+-eE]+)"',
        text,
    )
    if not vb:
        raise ValueError('missing viewBox')
    return float(vb.group(3)), float(vb.group(4))


def is_square_export(base: str, vw: float, vh: float) -> bool:
    if base.startswith('circle') or base.startswith('icon'):
        return True
    return max(vw, vh) / min(vw, vh) <= 1.0 + SQUARE_RATIO_TOL


def expected_png_size(vw: float, vh: float, size: int, square: bool) -> tuple[int, int]:
    if square:
        return size, size
    scale = size / max(vw, vh)
    return max(1, int(round(vw * scale))), max(1, int(round(vh * scale)))


def svg_padding(svg: Path):
    vw, vh = viewbox(svg)
    with tempfile.TemporaryDirectory() as td:
        png = Path(td) / 'a.png'
        render_svg(svg, png)
        geom = subprocess.check_output(['identify', '-format', '%w %h', str(png)], text=True)
        fw, fh = map(int, geom.split())
        box = subprocess.check_output(
            [
                IM,
                str(png),
                '(',
                '+clone',
                '-alpha',
                'extract',
                '-threshold',
                '2%',
                ')',
                '-alpha',
                'off',
                '-compose',
                'CopyOpacity',
                '-composite',
                '-trim',
                '-format',
                '%wx%h%X%Y',
                'info:',
            ],
            text=True,
        ).strip()
        if not box or box.startswith('0x0'):
            parts = subprocess.check_output(
                [
                    IM,
                    str(png),
                    '-bordercolor',
                    'none',
                    '-border',
                    '1',
                    '-trim',
                    '-format',
                    '%w %h %X %Y',
                    'info:',
                ],
                text=True,
            ).split()
            cw, ch, cx, cy = map(int, parts)
            cx -= 1
            cy -= 1
        else:
            m = re.match(r'(\d+)x(\d+)([+-]\d+)([+-]\d+)', box)
            if not m:
                box = subprocess.check_output(
                    [
                        IM,
                        str(png),
                        '-fuzz',
                        '2%',
                        '-trim',
                        '-format',
                        '%wx%h%X%Y',
                        'info:',
                    ],
                    text=True,
                ).strip()
                m = re.match(r'(\d+)x(\d+)([+-]\d+)([+-]\d+)', box)
            if not m:
                raise ValueError(f'cannot trim {svg}: {box!r}')
            cw, ch = int(m.group(1)), int(m.group(2))
            cx, cy = int(m.group(3)), int(m.group(4))
        pad_l = cx / fw
        pad_t = cy / fh
        pad_r = (fw - cx - cw) / fw
        pad_b = (fh - cy - ch) / fh
        return (vw, vh), (pad_l, pad_t, pad_r, pad_b)


failures = []
checked_svg = 0
assets: list[tuple[str, str, float, float, bool]] = []

for svg in sorted(Path('brand').rglob('svg/*.svg')):
    checked_svg += 1
    brand = svg.parts[1]
    base = svg.stem
    try:
        (vw, vh), pads = svg_padding(svg)
    except Exception as exc:
        failures.append(f'{svg}: {exc}')
        continue
    if max(pads) > SVG_PAD_TOL:
        failures.append(
            f'{svg}: not a minimal cutout '
            f'(padding LTRB={[f"{p:.1%}" for p in pads]}, viewBox={vw:.0f}x{vh:.0f})'
        )
    square = is_square_export(base, vw, vh)
    assets.append((brand, base, vw, vh, square))

checked_png = 0
for brand, base, vw, vh, square in assets:
    for size in PNG_SIZES:
        png = Path('brand') / brand / 'png' / str(size) / f'{base}.png'
        checked_png += 1
        if not png.exists():
            failures.append(f'{png}: missing PNG export')
            continue
        geom = subprocess.check_output(['identify', '-format', '%w %h', str(png)], text=True)
        w, h = map(int, geom.split())
        ew, eh = expected_png_size(vw, vh, size, square)
        if abs(w - ew) > PNG_SIZE_TOL or abs(h - eh) > PNG_SIZE_TOL:
            mode = 'square' if square else 'natural'
            failures.append(
                f'{png}: expected {mode} {ew}x{eh}, got {w}x{h}'
            )

checked_ico = 0
for brand, base, vw, vh, square in assets:
    ico = Path('brand') / brand / 'ico' / f'{base}.ico'
    if not square:
        if ico.exists():
            failures.append(f'{ico}: unexpected ICO for natural-aspect asset')
        continue
    checked_ico += 1
    if not ico.exists():
        failures.append(f'{ico}: missing ICO export')
        continue
    info = subprocess.check_output(['identify', str(ico)], text=True)
    found = set()
    for line in info.splitlines():
        m = re.search(r'\s(\d+)x(\d+)\s', line)
        if m and m.group(1) == m.group(2):
            found.add(int(m.group(1)))
    missing = [s for s in ICO_SIZES if s not in found]
    if missing:
        failures.append(f'{ico}: missing embedded sizes {missing} (found {sorted(found)})')

for loose in Path('brand').glob('*/png/*.png'):
    failures.append(f'{loose}: unexpected flat PNG; use png/<size>/')

# helpwave mark must ship transparent, on-white, and inverted on-black.
required_helpwave = {'mark', 'mark-on-white', 'mark-on-black', 'mark-white'}
helpwave_bases = {base for brand, base, *_ in assets if brand == 'helpwave'}
missing_hw = sorted(required_helpwave - helpwave_bases)
if missing_hw:
    failures.append(f'helpwave: missing required logo variants {missing_hw}')

if failures:
    print(
        f'brand check failed ({len(failures)} issues; '
        f'{checked_svg} svgs, {checked_png} pngs, {checked_ico} icos):'
    )
    for item in failures:
        print(f'  - {item}')
    sys.exit(1)

print(
    f'brand check passed: {checked_svg} SVG cutouts, '
    f'{checked_png} PNGs (square + natural), {checked_ico} square ICOs'
)
PY
