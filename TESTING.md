# Batch 001 Test Procedure

## OpenSCAD render test

1. Open `locking_wedge.scad`.
2. Render `part = "assembly"` at `assembly_position = 0`.
3. Confirm the upper and lower outer faces are horizontal and the assembled height is 20 mm.
4. Render at `assembly_position = -100`.
5. Confirm the console reports 17 mm height, 100 mm overlap, and 300 mm footprint.
6. Render at `assembly_position = 100`.
7. Confirm the console reports 23 mm height, 100 mm overlap, and 300 mm footprint.
8. Render `part = "single_wedge"` and confirm there are no manifold or geometry errors.
9. Render `part = "print_pair"` and verify both wedges lie flat on the build plane.

## First physical test

Print two identical wedges from `single_wedge`.

Check:

- both parts sit flat without rocking;
- the sloped faces mate continuously;
- the assembly measures approximately 20 mm when aligned;
- sliding 100 mm toward the low position produces approximately 17 mm;
- sliding 100 mm toward the high position produces approximately 23 mm;
- at both extremes, the remaining 100 mm overlap feels mechanically stable.

Do not add locking features until these observations are recorded.
