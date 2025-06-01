function state_player_movement(_entity) constructor {
    entity = _entity;

    start = function() {
        show_debug_message("Entrou no estado: Movimento");
    };
    
    run = function() {
        var dx = 0;
        var dy = 0;
    
        if (INPUT_RIGHT) dx += 1;
        if (INPUT_LEFT)  dx -= 1;
        if (INPUT_UP)    dy -= 1;
        if (INPUT_DOWN)  dy += 1;
    
        if (dx != 0 || dy != 0) {
            var dir = point_direction(0, 0, dx, dy);
            var spd = entity.mov_speed;
            var acc = entity.acceleration;
            var mov_x = lengthdir_x(spd, dir);
            var mov_y = lengthdir_y(spd, dir);
    
            // Salva referência ao owner antes do with
            var inst = entity.owner;
    
            with (inst) {
                x += mov_x * acc;
                y += mov_y * acc;
    
                x = clamp(x, sprite_width div 2, room_width - sprite_width div 2);
                y = clamp(y, sprite_height div 2, room_height - sprite_height div 2);
            }
        }
    };

    stop = function() {
        show_debug_message("Saindo do estado: Movimento");
    };
}


