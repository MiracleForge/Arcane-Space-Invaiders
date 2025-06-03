if (ship == undefined) {
    if (keyboard_check_pressed(ord("C"))) {
        ship = obj_uss_cerulean;
    } else if (keyboard_check_pressed(ord("E"))) {
        ship = obj_uss_ember_strike;
    };

    if (ship != undefined && !created) {
        var inst = instance_create_layer(MIDDLE_WIDTH_ROOM, MIDDLE_HEIGHT_ROOM, "instances_test", ship);
        camera_set_view_target(view_camera[0], inst);
        created = true;
    };
}
