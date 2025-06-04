if (keyboard_check_pressed(vk_f1)) {
    show_debug_info = !show_debug_info;
}

if (show_debug_info) {
    show_debug_overlay(true)
    debug_text = [];
    array_push(debug_text, "FPS: " + string(fps));
    array_push(debug_text, "Mouse X/Y: " + string(mouse_x) + " / " + string(mouse_y));
    
      if (instance_exists(obj_uss_father)) {
        with (obj_uss_father) {
            array_push(other.debug_text, "x velocit: " + string(hspeed));
            array_push(other.debug_text, "y velocit: " + string(vspeed));
            array_push(other.debug_text, "Angle: " + string(image_angle));
            array_push(other.debug_text, "SubImage: " + string(image_number));
            draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
        }
    }
    
    // Spawn USS Cerulean (tecla 1)
    if (keyboard_check_pressed(ord("1"))) {
        scr_spawn_player_ship("cerulean");
    }
    
    // Spawn Ember Strike (tecla 2)
    if (keyboard_check_pressed(ord("2"))) {
        scr_spawn_player_ship("ember_strike");
    }
}