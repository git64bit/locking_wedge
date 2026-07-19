# Locking Wedge

A configurable OpenSCAD pair consisting of a dedicated lower base and upper slide.

Batch 003 preserves the smooth 200 mm wedge geometry and seven positive locking positions for a 3 mm steel U-shaped garden stake. The two printable wedges now have role-specific dovetail placement and recessed adhesive-label pockets at their tall ends.

## Geometry

- Lower base length: 200 mm
- Upper slide length: 200 mm
- Configurable width: 60 mm default
- Each part: 7 mm thin end to 13 mm thick end
- Wedge slope: 6 / 200 = 0.03
- Nominal aligned height: 20 mm
- Seven assembled heights: 17, 18, 19, 20, 21, 22, and 23 mm
- Relative shift per 1 mm height change: 33.333 mm
- Minimum overlap at either extreme: 100 mm
- Mating surfaces remain smooth for adjustment under load

## Garden-stake lock

The lower base and upper slide have different diamond-hole patterns.

- Hole tunnels run across Y.
- The seven hole locations run along X.
- The lower stake leg is left of the upper leg.
- At the centered 20 mm position, the line between the selected hole centers is 45 degrees in side view.
- At every selected height, exactly one intended lower/upper pair preserves the designed X offset.
- The 3 mm wire is secured by a support-free diamond cross-section.
- Both Y entries have a short relief flare.

The default diamond is a 3.3 mm square rotated 45 degrees. Print the diamond coupons before committing to the full wedges because garden-stake wire diameter and coating vary.

## Mounting sockets

Both wedges provide the same mounting choices:

- `none`
- `single_dovetail`
- `two_dovetails`

The lower-base socket centers remain at 50 and 150 mm. The upper-slide socket centers are calculated from its register pattern:

- 55.25 mm, centered between the adjacent -2 and -1 register holes;
- 150.583 mm, centered between the adjacent +2 and +3 register holes.

This removes the close register/dovetail spacing visible in the first Batch 003 render. The sloped mating surfaces are never cut.

Every production socket and female coupon uses the same two-ended entry relief. The relief widens the first 3 mm of insertion and removes practical interference caused by elephant foot.

## Polyester-label recesses

Each wedge has a rounded rectangular recess at its tall end for an adhesive printed polyester part-number label.

- Recess size: 26 × 7 mm
- Default depth: 1.0 mm
- Adjustable depth: 0.8–1.2 mm
- Corner radius: 1.5 mm
- No modeled or embossed text

The upper-slide recess is on the side facing the viewer in the assembly preview. The lower-base recess is on the opposite side. The two printable launchers rotate the parts onto opposite sides so each recess faces upward during printing.

## OpenSCAD files

- `lower_base.scad` — printable lower wedge, side-oriented with label recess upward
- `upper_slide.scad` — printable upper wedge, side-oriented with label recess upward
- `coupons.scad` — dovetail, diamond-wire, and seven stake-spacing fit coupons
- `assembly_preview.scad` — inspect positions -3 through +3 with garden-stake visualization
- `locking_wedge.scad` — compatibility entry that opens the assembly preview
- `lib/` — shared geometry and calculations

Each launcher exposes only the parameters relevant to that part.

## First print sequence

1. Open `coupons.scad`.
2. Render with `coupon_family = "all"`.
3. Confirm the dovetail entry flare appears at both ends of each female coupon.
4. Test the three diamond sizes with the actual 3 mm garden stake.
5. Test the seven stake-spacing coupons.
6. Open `lower_base.scad` and `upper_slide.scad` and render each with F6.
7. Confirm each part is standing on its side and the rounded label recess faces upward.
8. Open `assembly_preview.scad` and inspect positions -3 through +3.
9. Print one lower base and one upper slide before making duplicates.

## GitHub browser upload

1. Extract the ZIP archive.
2. Open the enclosed `locking_wedge` folder.
3. In the repository, choose **Add file → Upload files**.
4. Drag every file and the `lib` folder into the upload area.
5. Commit the upload.
6. Provide the resulting commit SHA before the next batch.
