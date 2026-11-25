#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python3 <<'PY'
from pathlib import Path
import os
import re
import sys

DEFAULT_SIZES = [16, 32, 48, 64, 128, 180, 192, 256, 512, 1024]


def size_list(name: str, fallback: list[int]) -> list[int]:
    raw = os.environ.get(name, '').strip()
    if not raw:
        return list(fallback)
    return [int(part) for part in raw.split()]


SIZES = size_list('SIZES', DEFAULT_SIZES)
PNG_SIZES = size_list('PNG_SIZES', SIZES)
ICO_SIZES = size_list('ICO_SIZES', SIZES)

def viewbox_size(svg: Path) -> tuple[float, float]:
    text = svg.read_text(encoding='utf-8')
    match = re.search(
        r'viewBox="([0-9.+-eE]+)\s+([0-9.+-eE]+)\s+([0-9.+-eE]+)\s+([0-9.+-eE]+)"',
        text,
    )
    if not match:
        raise ValueError('missing viewBox')
    return float(match.group(3)), float(match.group(4))


def is_quadratic(width: float, height: float) -> bool:
    return abs(width - height) <= max(width, height) * 1e-4


failures: list[str] = []
checked_svg = 0
checked_png = 0
checked_ico = 0

for kind_dir in sorted(Path('brand').glob('*/*')):
    if not kind_dir.is_dir() or kind_dir.name not in {'logo', 'banner'}:
        continue
    svg_dir = kind_dir / 'svg'
    stems = {svg.stem for svg in svg_dir.glob('*.svg')} if svg_dir.is_dir() else set()
    for svg in sorted(svg_dir.glob('*.svg')) if svg_dir.is_dir() else []:
        checked_svg += 1
        if kind_dir.name == 'logo':
            try:
                width, height = viewbox_size(svg)
            except ValueError as exc:
                failures.append(f'{svg}: {exc}')
            else:
                if not is_quadratic(width, height):
                    failures.append(
                        f'{svg}: logo SVG must be quadratic (viewBox={width:.2f}x{height:.2f})'
                    )
        for size in PNG_SIZES:
            png = kind_dir / 'png' / str(size) / f'{svg.stem}.png'
            checked_png += 1
            if not png.exists():
                failures.append(f'{png}: missing PNG export')
        if kind_dir.name == 'logo':
            for size in ICO_SIZES:
                ico = kind_dir / 'ico' / str(size) / f'{svg.stem}.ico'
                checked_ico += 1
                if not ico.exists():
                    failures.append(f'{ico}: missing ICO export')
    for exported in sorted(kind_dir.rglob('*')):
        if not exported.is_file() or exported.suffix.lower() not in {'.png', '.ico'}:
            continue
        if exported.stem not in stems:
            failures.append(f'{exported}: no SVG source')

if failures:
    print(
        f'brand check failed ({len(failures)} issues; '
        f'{checked_svg} svgs, {checked_png} pngs, {checked_ico} icos):'
    )
    for item in failures:
        print(f'  - {item}')
    sys.exit(1)

print(
    f'brand check passed: {checked_svg} SVGs, '
    f'{checked_png} PNGs, {checked_ico} ICOs'
)
PY
