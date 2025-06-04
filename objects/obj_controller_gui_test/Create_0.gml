debug = false;
_x = 6;
var _new_width = surface_get_width(application_surface) * _x;
var _new_height = surface_get_height(application_surface) * _x;

surface_resize(application_surface,_new_width,_new_height);