draw_self()
shader_set(sh_rocket_flame);

// Pega o local da variável no shader
var _u_time_loc = shader_get_uniform(sh_rocket_flame, "u_time");
if (_u_time_loc != -1) {
    shader_set_uniform_f(_u_time_loc, current_time * 0.001);
} else {
    show_debug_message("❌ u_time não encontrado no shader!");
}

draw_sprite(spr_rockets_red_variant_1, 0, x, y);

shader_reset();


