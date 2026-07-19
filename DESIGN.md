# Design Record — Batch 003

## Baseline

Batch 003 is built from accepted commit `e129df5` and supersedes the two uncommitted Batch 002 archives.

The underlying kinematics remain unchanged:

```text
wedge slope = 6 mm / 200 mm = 0.03
horizontal travel per 1 mm height = 1 / 0.03 = 33.333 mm
```

The seven positions use relative shifts of:

```text
-100.000, -66.667, -33.333, 0,
+33.333, +66.667, +100.000 mm
```

These produce assembled heights of 17 through 23 mm in 1 mm increments.

## Distinct lower and upper wedges

The solid wedge body is shared, but the register rows are role-specific:

- the lower base uses a compact row centered near X = 95 mm;
- the upper slide uses a wider calculated row;
- reversing and shifting the upper slide brings one intended pair into the locking relationship at each height.

This is simpler and more flexible than forcing one self-matching hole pattern onto identical parts.

## Register calculations

Default lower register location:

```text
lower_x(position) = 95 + 9.5 × position
```

Default upper local register location:

```text
upper_local_x(position)
  = wedge_length
  + assembly_shift(position)
  - lower_x(position)
  - centered_lock_dx
```

The centered lock X offset is derived from the nominal assembled height and equal register depths:

```text
centered_lock_dx = 20 - 2 × 3 = 14 mm
```

At position 0:

- lower center Z = 3 mm;
- upper center Z = 17 mm;
- delta X = 14 mm;
- delta Z = 14 mm;
- side-view angle = 45 degrees.

The angle changes moderately at the other six heights because the vertical separation changes while the X offset remains fixed. The soft 3 mm garden-stake legs accommodate the resulting spacing variation without transferring significant bending load into the PLA+.

## Diamond tunnels

The default tunnel is a 3.3 mm square rotated 45 degrees:

- 3.0 mm nominal wire;
- 0.30 mm clearance across the square faces;
- 3.0 mm center depth from the flat external face;
- approximately 0.67 mm outer skin at the nearest diamond point;
- more than 2 mm of material remains toward the sloped mating face at the thinnest register location.

The diamond prints without support because every ceiling segment is at 45 degrees. Both Y openings use a short enlarged transition to guide the wire.

## Dovetail placement

The lower base retains socket centers at 50 and 150 mm because both are well clear of its compact register row.

The upper slide uses register-aware placement:

```text
first socket = midpoint(upper register -2, upper register -1)
             = 55.25 mm

second socket = midpoint(upper register +2, upper register +3)
              = 150.583 mm
```

With the default dimensions, each upper dovetail has approximately 7.08 mm of edge-to-edge clearance from its nearest diamond tunnel. The position is derived rather than manually tuned, so it follows the calculated register geometry.

## Dovetail entry relief

The female socket cut is canonical. The wedge sockets and female coupons call the same module, so the coupon reproduces:

- bridge width;
- neck width;
- cavity depth;
- entry length;
- entry enlargement;
- two-ended insertion geometry.

## Adhesive-label recess

Each wedge has a 26 × 7 mm rounded rectangle recessed into a side face near the tall end.

- depth defaults to 1.0 mm and is constrained to 0.8–1.2 mm;
- corner radius is 1.5 mm;
- no text is modeled;
- the limiting upper-slide register still has more than 5 mm of X clearance to the recess;
- the lower and upper recesses are on opposite side faces.

The printable lower and upper launchers rotate the parts onto opposite sides so the label pocket faces upward. The assembly preview retains the design orientation.

## Smooth mating surfaces

No serrations are present. The steel stake supplies the positive lock while the broad sloped surfaces remain continuously adjustable under load. To remove a loaded stake, move the upper slide slightly toward the higher position, withdraw the stake, and then adjust the slide.

## Project structure

Dedicated launchers keep the Customizer focused. Shared modules live under `lib/`, including the new rounded-label-recess module.
