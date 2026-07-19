/* Transverse dovetail geometry with canonical two-ended entry relief. */

function female_dovetail_points(
    center_x,
    head_width,
    neck_width,
    depth,
    epsilon = 0.02
) = [
    [center_x - neck_width / 2, -epsilon],
    [center_x + neck_width / 2, -epsilon],
    [center_x + head_width / 2, depth],
    [center_x - head_width / 2, depth]
];

function male_dovetail_points(center_x, head_width, neck_width, depth) = [
    [center_x - neck_width / 2, 0],
    [center_x + neck_width / 2, 0],
    [center_x + head_width / 2, depth],
    [center_x - head_width / 2, depth]
];

module prism_along_y(points, y_start, length) {
    translate([0, y_start + length, 0])
        rotate([90, 0, 0])
            linear_extrude(height = length, convexity = 10)
                polygon(points = points);
}

module section_at_y(points, y_position, thickness = 0.04) {
    prism_along_y(points, y_position, thickness);
}

module dovetail_socket_cut(
    center_x,
    span_y,
    head_width,
    neck_width,
    depth,
    entry_length,
    entry_relief,
    epsilon = 0.02
) {
    nominal = female_dovetail_points(
        center_x,
        head_width,
        neck_width,
        depth,
        epsilon
    );
    relieved = female_dovetail_points(
        center_x,
        head_width + 2 * entry_relief,
        neck_width + 2 * entry_relief,
        depth,
        epsilon
    );

    prism_along_y(nominal, -epsilon, span_y + 2 * epsilon);

    if (entry_length > 0 && entry_relief > 0) {
        hull() {
            section_at_y(relieved, -epsilon);
            section_at_y(nominal, entry_length);
        }
        hull() {
            section_at_y(nominal, span_y - entry_length);
            section_at_y(relieved, span_y + epsilon);
        }
    }
}

module male_dovetail_rail(
    span_y,
    head_width,
    neck_width,
    depth
) {
    prism_along_y(
        male_dovetail_points(0, head_width, neck_width, depth),
        0,
        span_y
    );
}
