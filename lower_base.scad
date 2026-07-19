/*
  Locking Wedge — lower base
  Batch 003

  Default output is rotated onto the side opposite the label recess,
  leaving the rounded label pocket facing upward for support-free printing.
*/

use <lib/wedge.scad>
use <lib/registers.scad>
use <lib/components.scad>

// ---------- Wedge ----------

wedge_length = 200;       // [100:1:200]
wedge_width = 60;         // [20:1:180]
nominal_height = 20;      // [10:0.5:50]
total_height_range = 6;   // [2:0.5:20]
print_on_side = true;

// ---------- Transverse mounting sockets ----------

mounting_choice = "two_dovetails"; // [none:No mounting sockets,single_dovetail:One female dovetail,two_dovetails:Two female dovetails]
dovetail_bridge_width = 5.0; // [4:0.1:6]
dovetail_neck_width = 3.2;   // [2.4:0.1:5]
dovetail_depth = 2.8;        // [1.5:0.1:4]
dovetail_entry_length = 3.0; // [1:0.5:8]
dovetail_entry_relief = 0.35;// [0.1:0.05:1]

// ---------- Garden-stake registers ----------

include_registers = true;
height_step = 1.0;            // [0.5:0.5:2]
lower_register_center_x = 95; // [70:0.5:130]
lower_register_pitch = 9.5;   // [7:0.5:15]
register_center_depth = 3.0;  // [2.5:0.1:5]
wire_diameter = 3.0;          // [2:0.1:5]
diamond_clearance = 0.30;     // [0.1:0.05:0.8]
diamond_entry_length = 3.0;   // [1:0.5:8]
diamond_entry_relief = 0.30;  // [0.1:0.05:0.8]

// ---------- Adhesive label recess ----------

include_label_recess = true;
label_recess_depth = 1.0; // [0.8:0.1:1.2]

epsilon = 0.02;
diamond_square_side = wire_diameter + diamond_clearance;

// ---------- Validation ----------

thin_end = wedge_thin_end(nominal_height, total_height_range);
thick_end = wedge_thick_end(nominal_height, total_height_range);
half_diagonal = diamond_half_diagonal(diamond_square_side);
minimum_lower_x = lower_register_x(-3, lower_register_center_x, lower_register_pitch);
maximum_lower_x = lower_register_x(3, lower_register_center_x, lower_register_pitch);
minimum_register_roof = wedge_height_at(
    minimum_lower_x,
    wedge_length,
    nominal_height,
    total_height_range
) - register_center_depth - half_diagonal;
label_left = label_recess_left_x(wedge_length);
label_bottom = label_recess_center_z(
    wedge_length,
    nominal_height,
    total_height_range
) - label_recess_height() / 2;

assert(wedge_length > 0 && wedge_width > 0,
    "Wedge dimensions must be positive");
assert(nominal_height > total_height_range,
    "nominal_height must exceed total_height_range");
assert(thin_end > 0, "Derived thin end must be positive");
assert(dovetail_neck_width < dovetail_bridge_width,
    "Dovetail neck must be narrower than bridge width");
assert(dovetail_bridge_width <= 6,
    "Flat-print dovetail bridge should remain at or below 6 mm");
assert(register_center_depth > half_diagonal + 0.4,
    "Diamond tunnel needs at least 0.4 mm outer skin");
assert(minimum_lower_x > half_diagonal,
    "First lower register is outside the wedge");
assert(maximum_lower_x < wedge_length - half_diagonal,
    "Last lower register is outside the wedge");
assert(minimum_register_roof > 2,
    "Lower register row leaves less than 2 mm to the mating face");
assert(label_recess_depth >= 0.8 && label_recess_depth <= 1.2,
    "Label recess depth must remain between 0.8 and 1.2 mm");
assert(label_left > maximum_lower_x + half_diagonal + 4,
    "Label recess is too close to the nearest lower register");
assert(label_bottom > 0.8,
    "Label recess is too close to the flat external face");

// ---------- Output ----------

module lower_output() {
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
        include_registers,
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
}

if (print_on_side)
    translate([0, thick_end, 0])
        rotate([90, 0, 0])
            lower_output();
else
    lower_output();

// ---------- Console report ----------

echo(str("Part: lower base"));
echo(str("Wedge: ", wedge_length, " x ", wedge_width, " mm"));
echo(str("End thicknesses: ", thin_end, " to ", thick_end, " mm"));
echo(str("Wedge angle: ",
    wedge_angle(wedge_length, total_height_range), " degrees"));
echo(str("Lower register X range: ", minimum_lower_x,
    " to ", maximum_lower_x, " mm"));
echo(str("Diamond square side: ", diamond_square_side, " mm"));
echo(str("Outer skin below diamond: ",
    register_center_depth - half_diagonal, " mm"));
echo(str("Label recess: ", label_recess_length(wedge_length),
    " x ", label_recess_height(), " x ", label_recess_depth, " mm"));
