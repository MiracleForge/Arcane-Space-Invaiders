function state_player_movement(_entity) constructor {
    entity = _entity;

    start = function() {
        show_debug_message("Entrou no estado: Movimento");
    };

    run = function() {
        // Alias para facilitar o código
        var acc = entity.acceleration;
        var glide = entity.glideFactor;
        var spd = entity.max_speed;
        var csx = entity.current_speed_x;
        var csy = entity.current_speed_y;
        var inst = entity.owner;
    
        entity.shootProjectile();
    
        var dx = 0;
        var dy = 0;
    
        if (INPUT_RIGHT) dx += 1;
        if (INPUT_LEFT)  dx -= 1;
        if (INPUT_UP)    dy -= 1;
        if (INPUT_DOWN)  dy += 1;
    
        if (dx != 0 || dy != 0) {
            var dir = point_direction(0, 0, dx, dy);
            csx += lengthdir_x(acc, dir);
            csy += lengthdir_y(acc, dir);
        } else {
            csx *= glide;
            csy *= glide;
        }
    
        var vel = point_distance(0, 0, csx, csy);
        if (vel > spd) {
            var limit_dir = point_direction(0, 0, csx, csy);
            csx = lengthdir_x(spd, limit_dir);
            csy = lengthdir_y(spd, limit_dir);
        }
    
        entity.current_speed_x = csx;
        entity.current_speed_y = csy;
    
      with (inst) {
        static rw = room_width;
        static rh = room_height;
        static border_offset_y = rh * 0.05;
    
        var half_w = sprite_width div 2;
        var half_h = sprite_height div 2;
    
        x += csx;
        y += csy;
    
        x = clamp(x, half_w, rw - half_w);
        y = clamp(y, half_h, rh - (half_h + border_offset_y));
    }


    };


    stop = function() {
        show_debug_message("Saindo do estado: Movimento");
    };
 }

