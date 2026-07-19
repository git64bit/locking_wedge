# Batch 003 Validation Record

Static validation was performed against the default parameters. OpenSCAD F6 rendering remains the required user test.

## Seven calculated positions

| Position | Shift (mm) | Height (mm) | Lower X (mm) | Upper local X (mm) | Upper global X (mm) | ΔX (mm) | ΔZ (mm) | Angle | Leg centers (mm) |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| -3 | -100.000 | 17 | 66.500 | 19.500 | 80.500 | 14 | 11 | 38.157° | 17.804 |
| -2 | -66.667 | 18 | 76.000 | 43.333 | 90.000 | 14 | 12 | 40.601° | 18.439 |
| -1 | -33.333 | 19 | 85.500 | 67.167 | 99.500 | 14 | 13 | 42.879° | 19.105 |
| 0 | 0.000 | 20 | 95.000 | 91.000 | 109.000 | 14 | 14 | 45.000° | 19.799 |
| +1 | +33.333 | 21 | 104.500 | 114.833 | 118.500 | 14 | 15 | 46.975° | 20.518 |
| +2 | +66.667 | 22 | 114.000 | 138.667 | 128.000 | 14 | 16 | 48.814° | 21.260 |
| +3 | +100.000 | 23 | 123.500 | 162.500 | 137.500 | 14 | 17 | 50.528° | 22.023 |

## Dovetail placement

| Part | First center X | Second center X | Placement rule |
|---|---:|---:|---|
| Lower base | 50.000 mm | 150.000 mm | 25% and 75% of length |
| Upper slide | 55.250 mm | 150.583 mm | midpoints between adjacent register pairs |

The default upper-slide edge-to-edge clearance between each dovetail and its nearest diamond is approximately 7.08 mm.

## Label recess

- Length: 26 mm
- Height: 7 mm
- Depth: 1.0 mm default; validated range 0.8–1.2 mm
- Corner radius: 1.5 mm
- X range: 170–196 mm
- Z range: approximately 4.1–11.1 mm
- Nearest upper diamond edge to label edge: approximately 5.17 mm
- Upper recess side: Y = 0 face
- Lower recess side: Y = wedge width face

## Checks passed

- Every intended stake pair preserves the calculated 14 mm X offset.
- At each assembly position, no other lower/upper pair has that exact X offset.
- All register centers remain inside their respective 200 mm wedges.
- The default 3.3 mm diamond leaves approximately 0.667 mm of outer skin.
- More than 2 mm remains between every diamond and the sloped mating surface.
- Upper dovetail centers are derived from register midpoints.
- Dovetail and diamond entry-relief modules are shared by coupons and production parts.
- Label recesses clear the closest register and remain below the sloped mating face.
- Printable launchers orient each label recess upward.
- All SCAD include/use paths resolve.
- Braces, brackets, and parentheses are balanced.
- Every SCAD file remains below 500 lines.
