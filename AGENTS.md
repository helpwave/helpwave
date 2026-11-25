# Brand logos and banners

SVG files are the source. PNG and ICO files are generated. Do not draw or hand-edit those exports.

```text
brand/<kit>/logo/svg/<name>.svg
brand/<kit>/logo/png/<size>/<name>.png
brand/<kit>/logo/ico/<size>/<name>.ico
brand/<kit>/banner/svg/<name>.svg
brand/<kit>/banner/png/<size>/<name>.png
```

Logos are quadratic: the viewBox width equals the height. Banners are wider or taller and do not get an ICO.

## Add a file

1. Put a quadratic cutout in `brand/<kit>/logo/svg/<name>.svg`, or a wide/tall cutout in `brand/<kit>/banner/svg/<name>.svg`.
2. Keep the viewBox tight. Padding on any side above 4% of the canvas fails `./scripts/check-brand-svgs.sh`. A non-zero origin is fine. Set `width` and `height` to the viewBox width and height.
3. A quadratic SVG in `banner/` fails the check. A non-quadratic SVG in `logo/` fails the check.

Background plates come from the file name. The SVG stays a cutout and the export composites the plate:

| Stem contains | Plate |
|---------------|--------|
| `-on-white`, `-badge-on-white` | white |
| `-on-black`, `-white-on-black` | black |
| `-on-teal` | `#095763` |
| anything else | transparent |

helpwave logos need `logo`, `logo-white`, `logo-on-white`, and `logo-white-on-black` under `logo/svg/`. The same background suffixes apply to `banner` and `banner-horizontal`. PNG and ICO files whose stem has no SVG are leftovers: delete them. `./scripts/check-brand-svgs.sh` fails when one remains.

## Export

Needs `rsvg-convert` (librsvg, same tool as GitHub Actions) and ImageMagick (`magick` or `convert`). Inkscape is only a fallback and will not match CI pixels.

```bash
./scripts/export-brand-assets.sh
./scripts/export-brand-assets.sh helpwave app-zum-doc
SIZES="32 128 1024" ./scripts/export-brand-assets.sh helpwave
PNG_SIZES="1024" ICO_SIZES="16 32 48" ./scripts/export-brand-assets.sh helpwave
```

With no arguments the script exports every kit. Arguments are kit names or `brand/<kit>` paths.

`SIZES` defaults to `16 32 48 64 128 180 192 256 512 1024` and is the ladder for both PNG and ICO. `PNG_SIZES` overrides it for PNGs. `ICO_SIZES` overrides it for ICOs.

- Logo PNG: `png/<size>/<name>.png`. Square canvas. `size` is the edge.
- Logo ICO: `ico/<size>/<name>.ico`. One file per size, same edge as that PNG.
- Banner PNG: natural aspect. `size` is the shorter side. No ICO.

## Check before committing

```bash
./scripts/check-brand-svgs.sh
./scripts/check-brand-export-drift.sh
```

The first check requires a minimal cutout, a quadratic logo viewBox, a PNG at every PNG size, and one square ICO file for every ICO size. The drift check fails when committed PNG or ICO pixels differ from `HEAD`, including new untracked exports. Commit the SVG together with the generated `png/` and `ico/` trees.

Layout and trademark notes: [`brand/README.md`](brand/README.md).
