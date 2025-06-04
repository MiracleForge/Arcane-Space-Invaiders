view_enabled = true;
view_visible[0] = true;


var _w = global.res_width;
var _h = global.res_height;
var _cam = camera_create_view(0, 0, _w, _h);


camera_set_view_border(_cam, _w / 2, _h / 2);

view_camera[0] = _cam;

_scale = 6;
var _new_width = surface_get_width(application_surface) * _scale;
var _new_height = surface_get_height(application_surface) * _scale;

surface_resize(application_surface,_new_width,_new_height);
