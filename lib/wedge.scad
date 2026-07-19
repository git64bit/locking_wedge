/* Shared smooth wedge geometry. */

function wedge_thin_end(nominal_height, total_height_range) =
    (nominal_height - total_height_range) / 2;

function wedge_thick_end(nominal_height, total_height_range) =
    (nominal_height + total_height_range) / 2;

function wedge_slope(wedge_length, total_height_range) =
    total_height_range / wedge_length;

function wedge_angle(wedge_length, total_height_range) =
    atan(wedge_slope(wedge_length, total_height_range));

function wedge_height_at(
    x,
    wedge_length,
    nominal_height,
    total_height_range
) =
    wedge_thin_end(nominal_height, total_height_range)
    + wedge_slope(wedge_length, total_height_range) * x;

module smooth_wedge(
    wedge_length,
    wedge_width,
    nominal_height,
    total_height_range
) {
    thin_end = wedge_thin_end(nominal_height, total_height_range);
    thick_end = wedge_thick_end(nominal_height, total_height_range);

    polyhedron(
        points = [
            [0,            0,           0],
            [wedge_length, 0,           0],
            [wedge_length, wedge_width, 0],
            [0,            wedge_width, 0],
            [0,            0,           thin_end],
            [wedge_length, 0,           thick_end],
            [wedge_length, wedge_width, thick_end],
            [0,            wedge_width, thin_end]
        ],
        faces = [
            [0, 3, 2, 1],
            [0, 1, 5, 4],
            [1, 2, 6, 5],
            [2, 3, 7, 6],
            [3, 0, 4, 7],
            [4, 5, 6, 7]
        ],
        convexity = 10
    );
}
