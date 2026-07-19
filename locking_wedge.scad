/*
  Locking Wedge — geometric baseline
  Batch 001

  Two identical wedges are used in opposite directions.
  The smooth mating faces remain in full contact throughout the overlap.
  Locking features are intentionally deferred until the base geometry is tested.
*/

// ---------- OpenSCAD Customizer ----------

part = "assembly"; // [assembly:Assembly,single_wedge:Single wedge,print_pair:Two-wedge print layout,range_preview:Low / nominal / high preview]

wedge_length = 200;       // [100:1:200]
wedge_width = 60;         // [20:1:180]
nominal_height = 20;      // [10:0.5:50]
total_height_range = 6;   // [2:0.5:20]

// -100 = low height, 0 = nominal height, +100 = high height.
assembly_position = 0;    // [-100:1:100]

// Visual separation only. Leave at 0 for the true assembly.
exploded_gap = 0;         // [0:0.5:20]

// Gap between identical wedges in the print layout.
print_gap = 5;            // [2:1:20]

// ---------- Derived dimensions ----------

thin_end = (nominal_height - total_height_range) / 2;
thick_end = (nominal_height + total_height_range) / 2;
wedge_taper = thick_end - thin_end;
wedge_slope = wedge_taper / wedge_length;
wedge_angle = atan(wedge_slope);
max_shift = wedge_length / 2;
assembly_shift = max_shift * assembly_position / 100;
assembled_height = nominal_height + assembly_shift * wedge_slope;
overlap_length = wedge_length - abs(assembly_shift);
footprint_length = wedge_length + abs(assembly_shift);
low_height = nominal_height - total_height_range / 2;
high_height = nominal_height + total_height_range / 2;

// ---------- Validation ----------

module validated_model() {
    assert(wedge_length > 0, "wedge_length must be greater than zero");
    assert(wedge_width > 0, "wedge_width must be greater than zero");
    assert(total_height_range > 0, "total_height_range must be greater than zero");
    assert(nominal_height > total_height_range,
        "nominal_height must be greater than total_height_range");
    assert(thin_end > 0, "The derived thin end must be greater than zero");
    assert(assembly_position >= -100 && assembly_position <= 100,
        "assembly_position must remain between -100 and +100");
    assert(overlap_length >= wedge_length / 2,
        "The configured travel must preserve at least half-length overlap");
    children();
}

// ---------- Geometry ----------

module wedge_body() {
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
            [0, 3, 2, 1], // bottom
            [0, 1, 5, 4], // front
            [1, 2, 6, 5], // thick end
            [2, 3, 7, 6], // back
            [3, 0, 4, 7], // thin end
            [4, 5, 6, 7]  // sloped face
        ],
        convexity = 10
    );
}

module lower_wedge() {
    color([0.22, 0.45, 0.75])
        wedge_body();
}

module upper_wedge(position = assembly_position) {
    shift = max_shift * position / 100;
    height = nominal_height + shift * wedge_slope;

    color([0.72, 0.72, 0.75])
        translate([wedge_length + shift, 0, height + exploded_gap])
            rotate([0, 180, 0])
                wedge_body();
}

module wedge_assembly(position = assembly_position) {
    lower_wedge();
    upper_wedge(position);
}

module single_wedge() {
    wedge_body();
}

module print_pair() {
    wedge_body();
    translate([0, wedge_width + print_gap, 0])
        wedge_body();
}

module range_preview() {
    preview_spacing = wedge_length + max_shift + 30;

    translate([0, 0, 0])
        wedge_assembly(-100);

    translate([preview_spacing, 0, 0])
        wedge_assembly(0);

    translate([2 * preview_spacing, 0, 0])
        wedge_assembly(100);
}

module dispatch() {
    if (part == "assembly") {
        wedge_assembly();
    } else if (part == "single_wedge") {
        single_wedge();
    } else if (part == "print_pair") {
        print_pair();
    } else if (part == "range_preview") {
        range_preview();
    } else {
        assert(false, str("Unknown part selection: ", part));
    }
}

// ---------- Console report ----------

echo(str("Wedge length: ", wedge_length, " mm"));
echo(str("Wedge width: ", wedge_width, " mm"));
echo(str("Thin end: ", thin_end, " mm"));
echo(str("Thick end: ", thick_end, " mm"));
echo(str("Wedge angle: ", wedge_angle, " degrees"));
echo(str("Assembly shift: ", assembly_shift, " mm"));
echo(str("Assembled height: ", assembled_height, " mm"));
echo(str("Overlap length: ", overlap_length, " mm"));
echo(str("Overall footprint: ", footprint_length, " mm"));
echo(str("Height range: ", low_height, " to ", high_height, " mm"));

validated_model()
    dispatch();
