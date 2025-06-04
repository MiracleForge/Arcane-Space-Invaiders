run_state();
show_debug_message("data: " + string(data));

show_debug_message("alarm no step " + string(alarm[0]))
// Updating global Player value
global.player_data = data;

show_debug_message("speed =" + string(data.current_speed_y))
show_debug_message("speed =" + string(data.current_speed_x))
if (hspeed == 0 && vspeed == 0) {
    // parado, subimages 0 a 3
    flare_frame = (floor(current_time / 100) mod 4);
} else {
    // andando, subimages 4 e 5
    flare_frame = 4 + (floor(current_time / 100) mod 2);
}



