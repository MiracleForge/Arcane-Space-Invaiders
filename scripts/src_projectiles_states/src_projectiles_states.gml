function state_projectile_state(_entity) constructor {
    entity = _entity;
     
    start = function() {
        show_debug_message("Entrou no estado: projectile start");
        var nearest_enemy = instance_nearest(entity.x, entity.y, obj_enemy_pawn);
        entity.target = nearest_enemy;
    };
    
    run = function() {
        if (instance_exists(entity.target)) { 
     
        show_debug_message("entro no run")
            var desired_angle = point_direction(entity.x, entity.y, entity.target.x, entity.target.y);
            var angle_diff = angle_difference(desired_angle, entity.direction);
            
            if (abs(angle_diff) < 5) {
                entity.direction = desired_angle;
            } else {
                var turn_factor = clamp(abs(angle_diff) / 90, 0.05, 0.3);
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