#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

# Pixel-stable drift check: PNG/ICO file bytes can change (tIME chunks) while
# pixels stay identical. Fail only when decoded pixels differ from HEAD.
python3 <<'PY'
from pathlib import Path
import subprocess
import sys
import tempfile

IM = "magick" if subprocess.call(
    ["bash", "-lc", "command -v magick"],
    stdout=subprocess.DEVNULL,
    stderr=subprocess.DEVNULL,
) == 0 else "convert"

roots = [
    Path("brand/helpwave/png"),
    Path("brand/helpwave/ico"),
    Path("brand/app-zum-doc/png"),
    Path("brand/app-zum-doc/ico"),
]


def pixel_sig(data: bytes, suffix: str) -> bytes:
    with tempfile.NamedTemporaryFile(suffix=suffix, delete=False) as handle:
        handle.write(data)
        path = handle.name
    try:
        return subprocess.check_output(
            [IM, path, "-depth", "8", "rgba:-"],
            stderr=subprocess.DEVNULL,
        )
    finally:
        Path(path).unlink(missing_ok=True)


changed: list[str] = []
missing_trees: list[str] = []

for root in roots:
    if not root.exists():
        missing_trees.append(str(root))
        continue
    files = sorted(
        p
        for p in root.rglob("*")
        if p.is_file() and p.suffix.lower() in {".png", ".ico"}
    )
    if not files:
        missing_trees.append(str(root))
        continue
    for path in files:
        tracked = subprocess.run(
            ["git", "ls-files", "--error-unmatch", "--", str(path)],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        if tracked.returncode != 0:
            changed.append(f"{path} (untracked)")
            continue
        if subprocess.call(["git", "diff", "--quiet", "--", str(path)]) == 0:
            continue
        old = subprocess.check_output(["git", "show", f"HEAD:{path}"])
        new = path.read_bytes()
        try:
            if pixel_sig(old, path.suffix.lower()) != pixel_sig(new, path.suffix.lower()):
                changed.append(str(path))
        except subprocess.CalledProcessError:
            changed.append(str(path))

if missing_trees:
    print("missing export trees:", file=sys.stderr)
    for item in missing_trees:
        print(f"  - {item}", file=sys.stderr)
    sys.exit(1)

if changed:
    print(
        "Committed PNG/ICO exports are out of date. "
        "Run ./scripts/export-brand-assets.sh and commit the updates."
    )
    for item in changed:
        print(f"  - {item}")
    sys.exit(1)

print("PNG and ICO exports match SVG sources (pixel-stable).")
PY
