///@param {Struct.ShipCeruleanCreate} _entity Description
function StatePlayerMovement(_entity = undefined) constructor {
    entity = _entity;

    start = function() {
        show_debug_message("Entrou no estado: Movimento");
    };

    run = function() {
        var _acceleration = entity.acceleration;
        var _glide_factor = entity.glide_factor;
        var _max_speed = entity.max_speed;
        var _inst = entity.owner;

        entity.shoot_projectile();

        var _dx = 0;
        var _dy = 0;

        if (INPUT_RIGHT) _dx += 1;
        if (INPUT_LEFT)  _dx -= 1;
        if (INPUT_UP)    _dy -= 1;
        if (INPUT_DOWN)  _dy += 1;

        if (_dx != 0 || _dy != 0) {
            var _dir = point_direction(0, 0, _dx, _dy);
            _inst.hspeed += lengthdir_x(_acceleration, _dir);
            _inst.vspeed += lengthdir_y(_acceleration, _dir);

            var _tilt_target = clamp(-_dx * 8, -10, 10);
            entity.tilt = lerp(entity.tilt, _tilt_target, 0.2);
            _inst.image_angle = entity.tilt;
            show_debug_message(_inst.image_angle);

            entity.flare_frame = 2 + (floor(current_time / 100) mod 2);
        } else {
            _inst.hspeed *= _glide_factor;
            _inst.vspeed *= _glide_factor;
            entity.flare_frame = (floor(current_time / 100) mod 2);
            _inst.image_angle = 0;
        }

        var _vel = point_distance(0, 0, _inst.hspeed, _inst.vspeed);
        if (_vel > _max_speed) {
            var _limit_dir = point_direction(0, 0, _inst.hspeed, _inst.vspeed);
            _inst.hspeed = lengthdir_x(_max_speed, _limit_dir);
            _inst.vspeed = lengthdir_y(_max_speed, _limit_dir);
        }

        var _half_w = _inst.sprite_width div 2;
        var _half_h = _inst.sprite_height div 2;

        _inst.x = clamp(_inst.x, _half_w + BORDER_BOUND_HORIZONTAL, room_width - _half_w - BORDER_BOUND_HORIZONTAL);
        _inst.y = clamp(_inst.y, _half_h + BORDER_BOUND_TOP, room_height - _half_h - BORDER_BOUND_BOTTOM);
    };

    stop = function() {
        show_debug_message("Saindo do estado: Movimento");
    };
};
