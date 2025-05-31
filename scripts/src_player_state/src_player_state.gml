function src_player_moviment() {
 
    var dx = 0;
    var dy = 0;

    if (INPUT_RIGHT) dx += 1;
    if (INPUT_LEFT)  dx -= 1;
    if (INPUT_UP)    dy -= 1;
    if (INPUT_DOWN)  dy += 1;

    // Normaliza a velocidade para diagonais
    if (dx != 0 || dy != 0) {
        var dir = point_direction(0, 0, dx, dy);
        var mov_x = lengthdir_x(data.mov_speed, dir);
        var mov_y = lengthdir_y(data.mov_speed, dir);

        x += mov_x;
        y += mov_y;
    }
}
