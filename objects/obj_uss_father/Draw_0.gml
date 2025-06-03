
var y_offset = sprite_get_yoffset(sprite_index);

var rocketY_offset = y - ((y_offset - sprite_height) div (y_offset / 2) + 1);
if (sprite_index != spr_uss_ember_strike) {
     draw_sprite_ext(
        spr_rockets_red, -1,
        x, rocketY_offset,
        image_xscale, image_yscale,
        image_angle,
        c_white, 1
    );

}
draw_self();





