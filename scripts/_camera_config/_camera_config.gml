global.res_width = 480;
global.res_height = 270;

var _ratio = global.res_width / global.res_height;
var _display_ratio = display_get_width() / display_get_height();

if (_display_ratio < _ratio){
    global.res_height = 270; // Optional

    global.res_width = global.res_height * _display_ratio;
}