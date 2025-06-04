///@param {Struct.uss_cerulean_create} entity_ description
function state_player_movement(entity_ = undefined) constructor {
    entity = entity_;

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
         
            var tilt_target = clamp(dx * 8, -10, 10); // change the ship angle on x 
            entity.tilt = lerp(entity.tilt, tilt_target, 0.2);
            inst.image_angle = entity.tilt;

            entity.flareFrame = 2 + (floor(current_time / 100) mod 2);
        } else {
            inst.hspeed *= glide;
            inst.vspeed *= glide;
            entity.flareFrame = (floor(current_time / 100) mod 2);
            inst.image_angle = 0;
        }
        
        var vel = point_distance(0, 0, inst.hspeed, inst.vspeed);
        if (vel > spd) {
            var limit_dir = point_direction(0, 0, inst.hspeed, inst.vspeed);
            inst.hspeed = lengthdir_x(spd, limit_dir);
            inst.vspeed = lengthdir_y(spd, limit_dir);
        }

        var half_w = inst.sprite_width div 2;
        var half_h = inst.sprite_height div 2;

        inst.x = clamp(inst.x, half_w + BORDER_BOUND_HORIZONTAL, room_width - half_w - BORDER_BOUND_HORIZONTAL);
        inst.y = clamp(inst.y, half_h + BORDER_BOUND_TOP, room_height - half_h - BORDER_BOUND_BOTTOM);
        
    };
    
    stop = function() {
        show_debug_message("Saindo do estado: Movimento");
    };
};