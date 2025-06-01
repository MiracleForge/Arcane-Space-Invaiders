debug = false;
_x = 6;
var _newWidth = surface_get_width(application_surface) * _x;
var _newHeight = surface_get_height(application_surface) * _x;

surface_resize(application_surface,_newWidth,_newHeight);