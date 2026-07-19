/* Rounded side recess for an adhesive polyester part-number label. */

module rounded_rectangle_2d(length_x, height_z, corner_radius) {
    assert(length_x > 2 * corner_radius,
        "Label recess length must exceed twice the corner radius");
    assert(height_z > 2 * corner_radius,
        "Label recess height must exceed twice the corner radius");

    hull()
        for (x_sign = [-1, 1], z_sign = [-1, 1])
            translate([
                x_sign * (length_x / 2 - corner_radius),
                z_sign * (height_z / 2 - corner_radius)
            ])
                circle(r = corner_radius, $fn = 24);
}

module side_label_recess_cut(
    side,
    wedge_width,
    center_x,
    center_z,
    length_x,
    height_z,
    corner_radius,
    depth,
    epsilon = 0.02
) {
    assert(side == "front" || side == "back",
        "Label side must be front or back");
    assert(depth > 0 && depth < wedge_width,
        "Label recess depth must be positive and less than wedge width");

    if (side == "front")
        translate([center_x, -epsilon, center_z])
            rotate([-90, 0, 0])
                linear_extrude(height = depth + epsilon, convexity = 10)
                    rounded_rectangle_2d(
                        length_x,
                        height_z,
                        corner_radius
                    );
    else
        translate([center_x, wedge_width + epsilon, center_z])
            rotate([90, 0, 0])
                linear_extrude(height = depth + epsilon, convexity = 10)
                    rounded_rectangle_2d(
                        length_x,
                        height_z,
                        corner_radius
                    );
}
