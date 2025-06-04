if (!show_debug_info) exit;

var _margin = 10;
var _y_offset = _margin;
draw_set_color(c_white);
draw_set_halign(fa_left);

for (var _i = 0; _i < array_length(debug_text); _i++) {
    draw_text(_margin, _y_offset, debug_text[_i]);
    _y_offset += 14;
}
