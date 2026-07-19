# Design Record — Batch 001

## Purpose

Establish a simple and correct parametric wedge pair before introducing any locking mechanism.

## Geometry

Each wedge is 200 mm long. Its thickness changes linearly from 7 mm to 13 mm, producing a total taper of 6 mm.

The second wedge is identical. It is rotated 180 degrees about the Y axis and translated so that its sloped face remains coincident with the sloped face of the lower wedge throughout the overlap.

For a relative horizontal shift `s` in millimeters:

```text
assembled height = 20 + (6 / 200) × s
```

Therefore:

| Shift | Height | Overlap | Footprint |
|---:|---:|---:|---:|
| -100 mm | 17 mm | 100 mm | 300 mm |
| 0 mm | 20 mm | 200 mm | 200 mm |
| +100 mm | 23 mm | 100 mm | 300 mm |

The wedge angle is:

```text
atan(6 / 200) = 1.718358 degrees
```

## Configuration

The primary user parameter is `wedge_width`. Length, nominal height, and height range are also exposed so later configurations can be derived from the same model.

## Explicitly deferred

This batch does not include:

- locking teeth or registers;
- disengagement mechanism;
- guide rails;
- stops;
- grout cavities;
- TPU parts;
- attachment points;
- chamfers or fillets.

Those features must not be allowed to obscure testing of the base geometry.
