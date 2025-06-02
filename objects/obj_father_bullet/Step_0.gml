 if (instance_exists(target) && sprite_index == spr_missile_basic) {
    if (!variable_instance_exists(id, "direction")) direction = image_angle;

    var desired_angle = point_direction(x, y, target.x, target.y);
    var angle_diff = angle_difference(desired_angle, direction);

    
    if (abs(angle_diff) < 5) {
        direction = desired_angle;
    } else {
        var turn_factor = clamp(abs(angle_diff) / 90, 0.05, 0.3);
        direction += angle_diff * turn_factor;
    }

    var dx = lengthdir_x(speed, direction);
    var dy = lengthdir_y(speed, direction);

    x += dx;
    y += dy;

    image_angle = direction;
};