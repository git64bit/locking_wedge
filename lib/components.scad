/* Role-specific wedge components assembled from shared geometry. */

use <wedge.scad>
use <dovetail.scad>
use <registers.scad>
use <label.scad>

function midpoint(a, b) = (a + b) / 2;

function upper_mount_x_1(
    wedge_length,
    nominal_height,
    total_height_range,
    height_step,
    lower_register_center_x,
    lower_register_pitch,
    register_center_depth
) = midpoint(
    upper_register_local_x(
        -2,
        wedge_length,
        total_height_range,
        height_step,
        lower_register_center_x,
        lower_register_pitch,
        register_center_depth,
        nominal_height
    ),
    upper_register_local_x(
        -1,
        wedge_length,
        total_height_range,
        height_step,
        lower_register_center_x,
        lower_register_pitch,
        register_center_depth,
        nominal_height
    )
);

function upper_mount_x_2(
    wedge_length,
    nominal_height,
    total_height_range,
    height_step,
    lower_register_center_x,
    lower_register_pitch,
    register_center_depth
) = midpoint(
    upper_register_local_x(
        2,
        wedge_length,
        total_height_range,
        height_step,
        lower_register_center_x,
        lower_register_pitch,
        register_center_depth,
        nominal_height
    ),
    upper_register_local_x(
        3,
        wedge_length,
        total_height_range,
        height_step,
        lower_register_center_x,
        lower_register_pitch,
        register_center_depth,
        nominal_height
    )
);

function label_recess_length(wedge_length) = min(26, wedge_length * 0.18);
function label_recess_height() = 7;
function label_recess_end_margin() = 4;
function label_recess_top_margin() = 1;
function label_recess_corner_radius() = 1.5;

function label_recess_left_x(wedge_length) =
    wedge_length - label_recess_end_margin() - label_recess_length(wedge_length);

function label_recess_center_x(wedge_length) =
    label_recess_left_x(wedge_length) + label_recess_length(wedge_length) / 2;

function label_recess_center_z(
    wedge_length,
    nominal_height,
    total_height_range
) = wedge_height_at(
        label_recess_left_x(wedge_length),
        wedge_length,
        nominal_height,
        total_height_range
    )
    - label_recess_top_margin()
    - label_recess_height() / 2;

module mounting_socket_cuts(
    mounting_choice,
    wedge_width,
    x_1,
    x_2,
    dovetail_bridge_width,
    dovetail_neck_width,
    dovetail_depth,
    dovetail_entry_length,
    dovetail_entry_relief,
    epsilon = 0.02
) {
    if (mounting_choice == "single_dovetail"
        || mounting_choice == "two_dovetails")
        dovetail_socket_cut(
            x_1,
            wedge_width,
            dovetail_bridge_width,
            dovetail_neck_width,
            dovetail_depth,
            dovetail_entry_length,
            dovetail_entry_relief,
            epsilon
        );

    if (mounting_choice == "two_dovetails")
        dovetail_socket_cut(
            x_2,
            wedge_width,
            dovetail_bridge_width,
            dovetail_neck_width,
            dovetail_depth,
            dovetail_entry_length,
            dovetail_entry_relief,
            epsilon
        );
}

module lower_base_model(
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
    epsilon = 0.02
) {
    lower_mount_x_1 = wedge_length * 0.25;
    lower_mount_x_2 = wedge_length * 0.75;

    difference() {
        smooth_wedge(
            wedge_length,
            wedge_width,
            nominal_height,
            total_height_range
        );

        mounting_socket_cuts(
            mounting_choice,
            wedge_width,
            lower_mount_x_1,
            lower_mount_x_2,
            dovetail_bridge_width,
            dovetail_neck_width,
            dovetail_depth,
            dovetail_entry_length,
            dovetail_entry_relief,
            epsilon
        );

        if (include_registers)
            lower_register_row(
                wedge_width,
                lower_register_center_x,
                lower_register_pitch,
                register_center_depth,
                diamond_square_side,
                diamond_entry_length,
                diamond_entry_relief,
                epsilon
            );

        if (include_label_recess)
            side_label_recess_cut(
                "back",
                wedge_width,
                label_recess_center_x(wedge_length),
                label_recess_center_z(
                    wedge_length,
                    nominal_height,
                    total_height_range
                ),
                label_recess_length(wedge_length),
                label_recess_height(),
                label_recess_corner_radius(),
                label_recess_depth,
                epsilon
            );
    }
}

module upper_slide_model(
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
    include_registers,
    lower_register_center_x,
    lower_register_pitch,
    register_center_depth,
    diamond_square_side,
    diamond_entry_length,
    diamond_entry_relief,
    include_label_recess,
    label_recess_depth,
    epsilon = 0.02
) {
    upper_mount_1 = upper_mount_x_1(
        wedge_length,
        nominal_height,
        total_height_range,
        height_step,
        lower_register_center_x,
        lower_register_pitch,
        register_center_depth
    );
    upper_mount_2 = upper_mount_x_2(
        wedge_length,
        nominal_height,
        total_height_range,
        height_step,
        lower_register_center_x,
        lower_register_pitch,
        register_center_depth
    );

    difference() {
        smooth_wedge(
            wedge_length,
            wedge_width,
            nominal_height,
            total_height_range
        );

        mounting_socket_cuts(
            mounting_choice,
            wedge_width,
            upper_mount_1,
            upper_mount_2,
            dovetail_bridge_width,
            dovetail_neck_width,
            dovetail_depth,
            dovetail_entry_length,
            dovetail_entry_relief,
            epsilon
        );

        if (include_registers)
            upper_register_row(
                wedge_length,
                wedge_width,
                nominal_height,
                total_height_range,
                height_step,
                lower_register_center_x,
                lower_register_pitch,
                register_center_depth,
                diamond_square_side,
                diamond_entry_length,
                diamond_entry_relief,
                epsilon
            );

        if (include_label_recess)
            side_label_recess_cut(
                "front",
                wedge_width,
                label_recess_center_x(wedge_length),
                label_recess_center_z(
                    wedge_length,
                    nominal_height,
                    total_height_range
                ),
                label_recess_length(wedge_length),
                label_recess_height(),
                label_recess_corner_radius(),
                label_recess_depth,
                epsilon
            );
    }
}
