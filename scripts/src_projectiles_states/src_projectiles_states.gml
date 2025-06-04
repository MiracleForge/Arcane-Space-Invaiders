///@description Constructor for follow state
///@param {Id.Instance} _entity Instance Id from owner instance
function StateProjectileFollow(_entity) constructor {
    entity = _entity;

    start = function() {
        show_debug_message("Entrou no estado: projectile start");
        var _nearest_enemy = instance_nearest(entity.x, entity.y, obj_enemy_pawn);
        entity.target = _nearest_enemy;
    };

    run = function() {
        if (instance_exists(entity.target)) {
            var _desired_angle = point_direction(entity.x, entity.y, entity.target.x, entity.target.y);
            var _angle_diff = angle_difference(_desired_angle, entity.direction);

            if (abs(_angle_diff) < ANGLE_TOLERANCE) {
                entity.direction = _desired_angle;
            } else {
                var _turn_factor = clamp(abs(_angle_diff) / ANGLE_TURN_DIVISOR, MIN_TURN_FACTOR, MAX_TURN_FACTOR);
                entity.direction += _angle_diff * _turn_factor;
            }

            var _dx = lengthdir_x(entity.speed, entity.direction);
            var _dy = lengthdir_y(entity.speed, entity.direction);

            entity.x += _dx;
            entity.y += _dy;

            entity.image_angle = entity.direction;
        }
    };

    stop = function() {
        show_debug_message("Saindo do estado: projectile_missil");
    };
};
