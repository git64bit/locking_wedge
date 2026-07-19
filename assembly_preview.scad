/*
  Locking Wedge — seven-position assembly preview
  Batch 003

  This file is for inspection, not a combined printable part.
*/

use <lib/wedge.scad>
use <lib/registers.scad>
use <lib/components.scad>

// ---------- Assembly ----------

height_position = 0; // [-3:1:3]
exploded_gap = 0;    // [0:0.5:15]
show_garden_stake = true;

wedge_length = 200;
wedge_width = 60;
nominal_height = 20;
total_height_range = 6;
height_step = 1.0;

// ---------- Mounting ----------

mounting_choice = "two_dovetails"; // [none:No mounting sockets,single_dovetail:One female dovetail,two_dovetails:Two female dovetails]
dovetail_bridge_width = 5.0;
dovetail_neck_width = 3.2;
dovetail_depth = 2.8;
dovetail_entry_length = 3.0;
dovetail_entry_relief = 0.35;

// ---------- Stake registers ----------

lower_register_center_x = 95;
lower_register_pitch = 9.5;
register_center_depth = 3.0;
wire_diameter = 3.0;
diamond_clearance = 0.30;
diamond_entry_length = 3.0;
diamond_entry_relief = 0.30;
stake_handle_offset = 10;
stake_tip_overhang = 8;
include_label_recess = true;
label_recess_depth = 1.0;

epsilon = 0.02;
diamond_square_side = wire_diameter + diamond_clearance;
assembly_shift = lock_shift(
    height_position,
    wedge_length,
    total_height_range,
    height_step
);
assembled_height = lock_height(
    height_position,
    nominal_height,
    height_step
);
lower_x = lower_register_x(
    height_position,
    lower_register_center_x,
    lower_register_pitch
);
upper_local_x = upper_register_local_x(
    height_position,
    wedge_length,
    total_height_range,
    height_step,
    lower_register_center_x,
    lower_register_pitch,
    register_center_depth,
    nominal_height
);
upper_global_x = upper_register_global_x(
    height_position,
    wedge_length,
    total_height_range,
    height_step,
    upper_local_x
);
lower_z = register_center_depth;
upper_z = assembled_height - register_center_depth + exploded_gap;
lock_dx = upper_global_x - lower_x;
lock_dz = upper_z - lower_z - exploded_gap;
lock_angle = atan(lock_dz / lock_dx);
lock_leg_spacing = sqrt(lock_dx * lock_dx + lock_dz * lock_dz);

assert(height_position >= -3 && height_position <= 3,
    "height_position must be an integer from -3 to +3");
assert(height_position == floor(height_position),
    "height_position must be an integer");
assert(abs(lock_dx - nominal_lock_dx(
    nominal_height,
    register_center_depth
)) < 0.001,
    "The selected lower and upper holes do not preserve the designed X offset");

color([0.22, 0.45, 0.75])
    lower_base_model(
        wedge_length,
        wedge_width,
        nominal_height,
        total_height_range,
        mounting_choice,
        dovetail_bridge_width,
        dovetail_neck_width,
        dovetail_depth,
        dovetail_entry_length,
        dovetail_entry_relief,
        true,
        lower_register_center_x,
        lower_register_pitch,
        register_center_depth,
        diamond_square_side,
        diamond_entry_length,
        diamond_entry_relief,
        include_label_recess,
        label_recess_depth,
        epsilon
    );

color([0.72, 0.72, 0.75])
    translate([
        wedge_length + assembly_shift,
        0,
        assembled_height + exploded_gap
    ])
        rotate([0, 180, 0])
            upper_slide_model(
                wedge_length,
                wedge_width,
                nominal_height,
                total_height_range,
                height_step,
                mounting_choice,
                dovetail_bridge_width,
                dovetail_neck_width,
                dovetail_depth,
                dovetail_entry_length,
                dovetail_entry_relief,
                true,
                lower_register_center_x,
                lower_register_pitch,
                register_center_depth,
                diamond_square_side,
                diamond_entry_length,
                diamond_entry_relief,
                include_label_recess,
                label_recess_depth,
                epsilon
            );

if (show_garden_stake)
    color([0.65, 0.65, 0.68])
        garden_stake_preview(
            lower_x,
            lower_z,
            upper_global_x,
            upper_z,
            wedge_width,
            wire_diameter,
            stake_handle_offset,
            stake_tip_overhang
        );

echo(str("Height position: ", height_position));
echo(str("Assembled height: ", assembled_height, " mm"));
echo(str("Relative shift: ", assembly_shift, " mm"));
echo(str("Lower register X: ", lower_x, " mm"));
echo(str("Upper register local X: ", upper_local_x, " mm"));
echo(str("Upper register global X: ", upper_global_x, " mm"));
echo(str("Stake center delta X: ", lock_dx, " mm"));
echo(str("Stake center delta Z: ", lock_dz, " mm"));
echo(str("Stake side-view angle: ", lock_angle, " degrees"));
echo(str("Required leg-center spacing: ", lock_leg_spacing, " mm"));
