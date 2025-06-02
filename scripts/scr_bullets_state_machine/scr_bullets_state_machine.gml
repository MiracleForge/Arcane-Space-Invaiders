function scr_missile_lock_in(_entity) constructor {
    entity = _entity;

    start = function() {
        show_debug_message("Missile Lock-In iniciado.");
        if (!variable_instance_exists(entity, "direction")) {
            entity.direction = entity.image_angle;
        }
    };

    run = function() {
        if (!instance_exists(entity.target)) return;
        show_debug_message("Run function inicialized.");
        var target = entity.target;

        var desired_angle = point_direction(entity.x, entity.y, target.x, target.y);
        var angle_diff = angle_difference(desired_angle, entity.direction);

        // Curva suavizada
        if (abs(angle_diff) < 5) {
            entity.direction = desired_angle;
        } else {
            var turn_factor = clamp(abs(angle_diff) / 90, 0.05, 0.3);
            entity.direction += angle_diff * turn_factor;
        }

        // Movimento na direção
        var dx = lengthdir_x(entity.speed, entity.direction);
        var dy = lengthdir_y(entity.speed, entity.direction);

        entity.x += dx;
        entity.y += dy;

        entity.image_angle = entity.direction;
    };

    stop = function() {
        show_debug_message("Missile Lock-In finalizado.");
    };
}
