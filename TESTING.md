# Batch 003 Test Procedure

## Reconciliation

Base commit: `e129df5`

Batch 003 supersedes the uncommitted original Batch 002 and Batch 002 Revised archives.

## 1. Coupon render

Open `coupons.scad` and render `coupon_family = "all"` with F6.

Confirm:

- three female dovetail coupons are present;
- each female coupon has visible enlargement at both Y entries;
- three matching male test rails are separate;
- three diamond-wire coupons are separate;
- seven stake-spacing coupons are separate;
- each diamond tunnel has entry relief at both Y faces.

## 2. Coupon print

Dovetail tests:

| Female bridge | Male clearance per side |
|---:|---:|
| 4 mm | 0.15 mm |
| 5 mm | 0.20 mm |
| 6 mm | 0.25 mm |

Confirm the male rail starts without interference from elephant foot and moves through the complete coupon.

Diamond tests use 3.1, 3.3, and 3.5 mm square sides for nominal 3 mm wire. Choose the smallest tunnel that accepts the actual coated wire without forcing or splitting the coupon.

The seven stake-spacing coupons are identified by one through seven edge notches for positions -3 through +3. Confirm the U-shaped stake can accommodate every required center spacing.

## 3. Full-part renders

Render `lower_base.scad` and `upper_slide.scad` with F6.

Confirm:

- both models render without warnings or geometry errors;
- each model is rotated onto its side;
- each rounded label recess faces upward;
- the recess contains no text;
- the lower recess is on the opposite design-side face from the upper recess;
- both dovetail sockets show entry relief at both ends;
- all seven diamond tunnels remain open.

The upper-slide dovetail centers should report approximately 55.25 and 150.583 mm in the console. Both should appear centered between their neighboring register holes.

## 4. Assembly preview

Open `assembly_preview.scad` and inspect every integer `height_position` from -3 through +3.

At every position confirm:

- broad mating surfaces remain in contact;
- exactly one intended lower/upper register pair receives the displayed stake;
- lower stake leg is left of the upper leg;
- no dovetail intersects a diamond tunnel;
- label recesses remain at the tall ends on opposite sides;
- no wedge or stake feature intersects unexpectedly.

## 5. First full print

Print one lower base and one upper slide in PLA+ before duplicating the parts.

Recommended observations:

- side-print stability and bed adhesion over the 200 mm length;
- label-pocket floor quality at 1.0 mm depth;
- dovetail fit using the selected coupon clearance;
- actual garden-stake insertion force;
- sliding behavior under a representative load;
- stake removal after slightly advancing the slide toward the higher position.
