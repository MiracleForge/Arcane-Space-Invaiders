function src_player_moviment() {
 
    var dx = 0;
    var dy = 0;
    
    if (INPUT_RIGHT) dx += 1;
    if (INPUT_LEFT)  dx -= 1;
    if (INPUT_UP)    dy -= 1;
    if (INPUT_DOWN)  dy += 1;
        

    // normalazing diagonal speed
    if (dx != 0 || dy != 0) {
        var dir = point_direction(0, 0, dx, dy);
        
        var mov_x = lengthdir_x(data.mov_speed, dir);
        var mov_y = lengthdir_y(data.mov_speed, dir);


        x += mov_x * data.acceleration;
        y += mov_y * data.acceleration;
        
        x = clamp(x, sprite_width div 2, room_width - sprite_width div 2);
        y = clamp(y, sprite_height div 2, room_height - sprite_height div 2);
    
     }
}
