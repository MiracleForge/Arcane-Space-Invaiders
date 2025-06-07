function ScrProjectileCreate () constructor {
     vspeed = -3;
     sprite_index = spr_bullet_basic;
     cooldown = 3;
}

function SrcProjectileHeatCreate (): ScrProjectileCreate() constructor {
    vspeed = -2;
    sprite_index = spr_bullet_heat;
    cooldown = 1; 
}

function SrcProjectileMissileCreate (): ScrProjectileCreate() constructor {
     sprite_index = spr_missile_basic;
     cooldown = 6;
     speed = 0.5;
    
     ///@description Draw methods for rocket flame logic.
    ///@param {Id.Instance} _owner Instance Id from the owner object
     draw_rocket_flame = method(self, function(_owner) {
        var _time = current_time * 0.005;
    
        var _sprite_scale = 0.7;
        var _flame_offset = -1;
    
        var _rocket_x_offset = _owner.x + lengthdir_x(_flame_offset, _owner.image_angle);
        var _rocket_y_offset = _owner.y + lengthdir_y(_flame_offset, _owner.image_angle);
    
        var _angle_offset = _owner.image_angle - 90;
    
        shader_set(sh_engine_flare); 
        shader_set_uniform_f(shader_get_uniform(sh_engine_flare, "u_time"), _time);
        shader_set_uniform_f(shader_get_uniform(sh_engine_flare, "u_flameColor"), 0.7, 0.2, 1.0);
    
        draw_sprite_ext(spr_rockets_red, -1, _rocket_x_offset, _rocket_y_offset, _sprite_scale, _sprite_scale, _angle_offset, c_white, 1);
    
        shader_reset();
});

}

	
