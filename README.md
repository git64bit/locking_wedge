# Locking Wedge

A simple, configurable two-wedge assembly modeled in OpenSCAD.

Batch 001 establishes only the base wedge geometry. Locking teeth, guides, attachments, grout cavities, and release features are intentionally excluded until the smooth wedge pair has been rendered and physically evaluated.

## Default geometry

- Two identical wedges
- Wedge length: 200 mm
- Configurable width: 60 mm default
- Thin end: 7 mm
- Thick end: 13 mm
- Taper: 6 mm over 200 mm
- Wedge angle: approximately 1.71836 degrees
- Nominal aligned assembly height: 20 mm
- Low assembly height: 17 mm
- High assembly height: 23 mm
- Relative travel: -100 mm to +100 mm
- Minimum overlap at either extreme: 100 mm
- Maximum footprint at either extreme: 300 mm

## OpenSCAD use

1. Open `locking_wedge.scad`.
2. Leave `part = "assembly"` to inspect the pair.
3. Set `assembly_position` to:
   - `-100` for 17 mm assembled height
   - `0` for 20 mm assembled height
   - `100` for 23 mm assembled height
4. Change `wedge_width` as required.
5. Press **F5** for Preview and **F6** for Render.
6. Select `part = "single_wedge"` to export one STL. Print two identical copies.
7. Select `part = "print_pair"` only when the configured width allows both wedges to fit the build plate side by side.

The single wedge is already oriented with its flat face on the build plate and requires no support geometry.

## Part selections

- `assembly` — working two-wedge assembly
- `single_wedge` — one printable wedge
- `print_pair` — two identical wedges placed side by side
- `range_preview` — low, nominal, and high assemblies shown together

## Adjustment convention

`assembly_position` is a percentage of the permitted travel:

- `-100` moves the upper wedge 100 mm left
- `0` aligns both 200 mm wedges
- `100` moves the upper wedge 100 mm right

The upper wedge is the same geometry as the lower wedge, rotated into opposition. Its upper face remains horizontal at every position.

## GitHub browser upload

1. Extract the ZIP archive.
2. Open the `locking_wedge` folder inside it.
3. In the GitHub repository, choose **Add file → Upload files**.
4. Drag all files from the extracted `locking_wedge` folder into the upload area.
5. Commit the upload.
6. Record the resulting commit SHA for reconciliation before the next batch.
