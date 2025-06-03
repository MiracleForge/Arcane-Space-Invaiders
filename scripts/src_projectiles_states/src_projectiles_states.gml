///@description Constructor for follow state
///@param {Id.Instance} _entity Instance Id from owner instance
function state_projectile_follow(_entity) constructor {
    entity = _entity;
     
    start = function() {
        show_debug_message("Entrou no estado: projectile start");
        var nearest_enemy = instance_nearest(entity.x, entity.y, obj_enemy_pawn);
        entity.target = nearest_enemy;
    };
    
    run = function() {
        if (instance_exists(entity.target)) { 
     
            var desired_angle = point_direction(entity.x, entity.y, entity.target.x, entity.target.y);
            var angle_diff = angle_difference(desired_angle, entity.direction);
            
            if (abs(angle_diff) < ANGLE_TOLERANCE) {
                entity.direction = desired_angle;
            } else {
                var turn_factor = clamp(abs(angle_diff) / ANGLE_TURN_DIVISOR, MIN_TURN_FACTOR, MAX_TURN_FACTOR);
                entity.direction += angle_diff * turn_factor;
            }
        
            var dx = lengthdir_x(entity.speed, entity.direction);
            var dy = lengthdir_y(entity.speed, entity.direction);
        
            entity.x += dx;
            entity.y += dy;
        
            entity.image_angle = entity.direction;
    }; 
        
    stop = function() {
        show_debug_message("Saindo do estado: projectile_missil");
    };
 }
}