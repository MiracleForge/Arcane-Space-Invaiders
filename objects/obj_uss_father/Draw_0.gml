var _is_ember_strike = (sprite_index == spr_uss_ember_strike);

if !_is_ember_strike data.draw_rocket_flame(); // draw below the sprite

draw_self(); // always draw the sprite
data.flash_hit(); // always draw the flash on top

if _is_ember_strike data.draw_rocket_flame(); // draw the flame again, on top of the sprite and flash