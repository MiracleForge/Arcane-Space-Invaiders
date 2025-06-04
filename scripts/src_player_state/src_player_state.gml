function state_player_movement(_entity) constructor {
    entity = _entity;

    start = function() {
        show_debug_message("Entrou no estado: Movimento");
    };

    run = function() {
        var acc = entity.acceleration;
        var glide = entity.glideFactor;
        var spd = entity.max_speed;
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
            inst.hspeed += lengthdir_x(acc, dir);
            inst.vspeed += lengthdir_y(acc, dir);
            entity.flareFrame = 2 + (floor(current_time / 100) mod 2);
        } else {
            inst.hspeed *= glide;
            inst.vspeed *= glide;
            entity.flareFrame = (floor(current_time / 100) mod 2);
        }
        
        var vel = point_distance(0, 0, inst.hspeed, inst.vspeed);
        if (vel > spd) {
            var limit_dir = point_direction(0, 0, inst.hspeed, inst.vspeed);
            inst.hspeed = lengthdir_x(spd, limit_dir);
            inst.vspeed = lengthdir_y(spd, limit_dir);
        }

        var half_w = inst.sprite_width div 2;
        var half_h = inst.sprite_height div 2;
        var rw = room_width;
        var rh = room_height;
        var border_offset_y = rh * 0.05;
    
        inst.x = clamp(inst.x, half_w, rw - half_w);
        inst.y = clamp(inst.y, half_h, rh - (half_h + border_offset_y));
    };
    
    stop = function() {
        show_debug_message("Saindo do estado: Movimento");
    };
};