/*
  Locking Wedge — dovetail and garden-stake fit coupons
  Batch 003

  Every female dovetail coupon uses the same entry relief as the wedges.
*/

use <lib/dovetail.scad>
use <lib/registers.scad>

coupon_family = "all"; // [all:All coupons,dovetail:Dovetail coupons,diamond:Diamond wire coupons,stake_spacing:Garden-stake spacing coupons]

// ---------- Dovetail coupons ----------

dovetail_depth = 2.8;        // [1.5:0.1:4]
dovetail_entry_length = 3.0; // [1:0.5:8]
dovetail_entry_relief = 0.35;// [0.1:0.05:1]

// ---------- Diamond wire and stake-spacing coupons ----------

nominal_height = 20;
height_step = 1.0;
register_center_depth = 3.0;
wire_diameter = 3.0;          // [2:0.1:5]
diamond_entry_length = 3.0;   // [1:0.5:8]
diamond_entry_relief = 0.30;  // [0.1:0.05:0.8]

female_coupon_x = 20;
female_coupon_y = 18;
female_coupon_z = dovetail_depth + 4;
diamond_coupon_x = 16;
diamond_coupon_y = 18;
diamond_coupon_z = 8;
coupon_gap = 8;
row_gap = 28;
stake_coupon_x = 32;
stake_coupon_y = 18;
stake_coupon_z = 8;
epsilon = 0.02;

module female_dovetail_coupon(head_width) {
    neck_width = max(2.4, head_width - 1.8);

    difference() {
        cube([female_coupon_x, female_coupon_y, female_coupon_z]);
        dovetail_socket_cut(
            female_coupon_x / 2,
            female_coupon_y,
            head_width,
            neck_width,
            dovetail_depth,
            dovetail_entry_length,
            dovetail_entry_relief,
            epsilon
        );
    }
}

module male_dovetail_coupon(head_width, clearance) {
    neck_width = max(2.4, head_width - 1.8);
    male_head = head_width - 2 * clearance;
    male_neck = neck_width - 2 * clearance;
    male_depth = dovetail_depth - clearance;

    translate([0, male_depth, 0])
        rotate([90, 0, 0])
            male_dovetail_rail(
                female_coupon_y,
                male_head,
                male_neck,
                male_depth
            );
}

module dovetail_coupon_set() {
    widths = [4, 5, 6];
    clearances = [0.15, 0.20, 0.25];

    for (i = [0 : 2]) {
        translate([i * (female_coupon_x + coupon_gap), 0, 0])
            female_dovetail_coupon(widths[i]);

        translate([
            i * (female_coupon_x + coupon_gap) + female_coupon_x / 2,
            row_gap,
            0
        ])
            male_dovetail_coupon(widths[i], clearances[i]);
    }
}

module diamond_wire_coupon(square_side) {
    difference() {
        cube([diamond_coupon_x, diamond_coupon_y, diamond_coupon_z]);
        diamond_tunnel_cut(
            diamond_coupon_x / 2,
            diamond_coupon_z / 2,
            diamond_coupon_y,
            square_side,
            diamond_entry_length,
            diamond_entry_relief,
            epsilon
        );
    }
}

module diamond_coupon_set() {
    clearances = [0.10, 0.30, 0.50];

    for (i = [0 : 2])
        translate([i * (diamond_coupon_x + coupon_gap), 0, 0])
            diamond_wire_coupon(wire_diameter + clearances[i]);
}


module stake_spacing_coupon(position) {
    lock_dx = nominal_height - 2 * register_center_depth;
    lock_dz = nominal_height + position * height_step
        - 2 * register_center_depth;
    spacing = sqrt(lock_dx * lock_dx + lock_dz * lock_dz);
    left_x = (stake_coupon_x - spacing) / 2;
    right_x = left_x + spacing;
    square_side = wire_diameter + 0.30;

    difference() {
        cube([stake_coupon_x, stake_coupon_y, stake_coupon_z]);
        diamond_tunnel_cut(
            left_x,
            stake_coupon_z / 2,
            stake_coupon_y,
            square_side,
            diamond_entry_length,
            diamond_entry_relief,
            epsilon
        );
        diamond_tunnel_cut(
            right_x,
            stake_coupon_z / 2,
            stake_coupon_y,
            square_side,
            diamond_entry_length,
            diamond_entry_relief,
            epsilon
        );

        // One through seven edge notches identify positions -3 through +3.
        for (marker = [0 : position + 3])
            translate([2 + marker * 2.2, -epsilon, stake_coupon_z - 1.2])
                cube([1.0, 2.2, 1.4]);
    }
}

module stake_spacing_coupon_set() {
    positions = [-3, -2, -1, 0, 1, 2, 3];

    for (i = [0 : 6]) {
        column = i % 4;
        row = floor(i / 4);
        translate([
            column * (stake_coupon_x + coupon_gap),
            row * (stake_coupon_y + coupon_gap),
            0
        ])
            stake_spacing_coupon(positions[i]);
    }
}

if (coupon_family == "all") {
    dovetail_coupon_set();
    translate([0, 70, 0]) diamond_coupon_set();
    translate([0, 115, 0]) stake_spacing_coupon_set();
} else if (coupon_family == "dovetail") {
    dovetail_coupon_set();
} else if (coupon_family == "diamond") {
    diamond_coupon_set();
} else if (coupon_family == "stake_spacing") {
    stake_spacing_coupon_set();
} else {
    assert(false, str("Unknown coupon_family: ", coupon_family));
}

echo(str("Dovetail female entry length: ",
    dovetail_entry_length, " mm"));
echo(str("Dovetail female entry relief: ",
    dovetail_entry_relief, " mm per side"));
echo(str("Diamond wire test sides: ",
    wire_diameter + 0.10, ", ",
    wire_diameter + 0.30, ", ",
    wire_diameter + 0.50, " mm"));
for (position = [-3, -2, -1, 0, 1, 2, 3]) {
    dx = nominal_height - 2 * register_center_depth;
    dz = nominal_height + position * height_step
        - 2 * register_center_depth;
    echo(str("Stake spacing coupon position ", position,
        ": ", sqrt(dx * dx + dz * dz), " mm"));
}
