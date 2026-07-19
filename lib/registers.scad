/* Diamond garden-stake registers and seven-position kinematics. */

function lock_positions() = [-3, -2, -1, 0, 1, 2, 3];

function travel_per_height_step(
    wedge_length,
    total_height_range,
    height_step
) = height_step / (total_height_range / wedge_length);

function lock_shift(
    position,
    wedge_length,
    total_height_range,
    height_step
) = position * travel_per_height_step(
    wedge_length,
    total_height_range,
    height_step
);

function lock_height(position, nominal_height, height_step) =
    nominal_height + position * height_step;

function lower_register_x(position, center_x, pitch) =
    center_x + position * pitch;

function nominal_lock_dx(nominal_height, register_center_depth) =
    nominal_height - 2 * register_center_depth;

function upper_register_local_x(
    position,
    wedge_length,
    total_height_range,
    height_step,
    lower_center_x,
    lower_pitch,
    register_center_depth,
    nominal_height
) =
    wedge_length
    + lock_shift(position, wedge_length, total_height_range, height_step)
    - lower_register_x(position, lower_center_x, lower_pitch)
    - nominal_lock_dx(nominal_height, register_center_depth);

function upper_register_global_x(
    position,
    wedge_length,
    total_height_range,
    height_step,
    upper_local_x
) =
    wedge_length
    + lock_shift(position, wedge_length, total_height_range, height_step)
    - upper_local_x;

function diamond_half_diagonal(square_side) = square_side / sqrt(2);

function diamond_points(center_x, center_z, square_side) = [
    [center_x, center_z - diamond_half_diagonal(square_side)],
    [center_x + diamond_half_diagonal(square_side), center_z],
    [center_x, center_z + diamond_half_diagonal(square_side)],
    [center_x - diamond_half_diagonal(square_side), center_z]
];

module register_prism_along_y(points, y_start, length) {
    translate([0, y_start + length, 0])
        rotate([90, 0, 0])
            linear_extrude(height = length, convexity = 10)
                polygon(points = points);
}

module register_section_at_y(points, y_position, thickness = 0.04) {
    register_prism_along_y(points, y_position, thickness);
}

module diamond_tunnel_cut(
    center_x,
    center_z,
    span_y,
    square_side,
    entry_length,
    entry_relief,
    epsilon = 0.02
) {
    nominal = diamond_points(center_x, center_z, square_side);
    relieved = diamond_points(
        center_x,
        center_z,
        square_side + 2 * entry_relief
    );

    register_prism_along_y(
        nominal,
        -epsilon,
        span_y + 2 * epsilon
    );

    if (entry_length > 0 && entry_relief > 0) {
        hull() {
            register_section_at_y(relieved, -epsilon);
            register_section_at_y(nominal, entry_length);
        }
        hull() {
            register_section_at_y(nominal, span_y - entry_length);
            register_section_at_y(relieved, span_y + epsilon);
        }
    }
}

module lower_register_row(
    wedge_width,
    center_x,
    pitch,
    center_z,
    square_side,
    entry_length,
    entry_relief,
    epsilon = 0.02
) {
    for (position = lock_positions())
        diamond_tunnel_cut(
            lower_register_x(position, center_x, pitch),
            center_z,
            wedge_width,
            square_side,
            entry_length,
            entry_relief,
            epsilon
        );
}

module upper_register_row(
    wedge_length,
    wedge_width,
    nominal_height,
    total_height_range,
    height_step,
    lower_center_x,
    lower_pitch,
    center_z,
    square_side,
    entry_length,
    entry_relief,
    epsilon = 0.02
) {
    for (position = lock_positions())
        diamond_tunnel_cut(
            upper_register_local_x(
                position,
                wedge_length,
                total_height_range,
                height_step,
                lower_center_x,
                lower_pitch,
                center_z,
                nominal_height
            ),
            center_z,
            wedge_width,
            square_side,
            entry_length,
            entry_relief,
            epsilon
        );
}

module rod_along_y(x, y_start, z, length, radius, facets = 32) {
    translate([x, y_start, z])
        rotate([-90, 0, 0])
            cylinder(h = length, r = radius, $fn = facets);
}

module garden_stake_preview(
    lower_x,
    lower_z,
    upper_x,
    upper_z,
    wedge_width,
    wire_diameter,
    handle_offset = 10,
    tip_overhang = 8
) {
    radius = wire_diameter / 2;
    y_start = -handle_offset;
    leg_length = wedge_width + handle_offset + tip_overhang;

    rod_along_y(lower_x, y_start, lower_z, leg_length, radius);
    rod_along_y(upper_x, y_start, upper_z, leg_length, radius);

    hull() {
        translate([lower_x, y_start, lower_z]) sphere(r = radius, $fn = 24);
        translate([upper_x, y_start, upper_z]) sphere(r = radius, $fn = 24);
    }
}
