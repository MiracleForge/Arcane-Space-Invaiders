global.player_data = new space_ship_create();
var inst = instance_create_layer(MIDDLE_WIDTH_ROOM, MIDDLE_HEIGHT_ROOM, "instances_test", obj_space_ship, global.player_data);
inst.data = new space_ship_create();
inst.alarm[0] = global.player_data.shotCountdown;
camera_set_view_target(view_camera[0], inst);