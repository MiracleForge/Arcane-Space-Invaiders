if (sprite_index == spr_uss_ember_strike) {
    draw_self();
};

data.draw_rocket_flame();

if (sprite_index != spr_uss_ember_strike) {
    draw_self();
};

data.flash_hit();