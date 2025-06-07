///@description Constructor for Player Ember Strike Ship
///@param {Id.Instance} _owner Instance Id from the owner object.
function ShipEmberStrikeCreate(_owner) : ShipCeruleanCreate(_owner) constructor {
    shield = 5; ///@type real
    static shield_capacity = 5; ///@type real
    static overheat_capacity = 3; ///@type real
    static max_speed = 1; ///@type real
    static glide_factor = 0.95; ///@type float
    static acceleration = 2; ///@type real
    shot_countdown = 40; ///@type real

    ///@description Fire a bullet from the emissor.
    ///@param {struct} [_constructor_] Bullet Data. Default: `ScrProjectileCreate()`.
    ///@return {Id.Instance} Reference of instance.
    fire_bullet = method(self, function(_constructor_ = new ScrProjectileCreate()) {
        var _half_h = owner.sprite_height * 0.5;
        var _half_w = owner.sprite_width * 0.5;

        static _missile_timer = 0;

        var _bullet_data = _constructor_;
        instance_create_layer(owner.x + _half_w, owner.y - _half_h, "bullets", obj_projectile_father, _bullet_data);
        instance_create_layer(owner.x - _half_w, owner.y - _half_h, "bullets", obj_projectile_father, _bullet_data);

        if (--_missile_timer <= 0) {
            var _missile = new SrcProjectileMissileCreate();
            var _inst = instance_create_layer(owner.x, owner.y - _half_h, "bullets", obj_projectile_missil, _missile);
            _missile_timer = _missile.cooldown;
          };
    });
    
    
    ///@description Draw methods for rocket flame logic.
      draw_rocket_flame = method(self, function() {
        IF_PLAYER_DEAD_RETURN;
        var _spr_index = owner.sprite_index;
        var _spr_width = owner.sprite_width;
        var _spr_height = owner.sprite_height;
        var _y_offset = sprite_get_yoffset(_spr_index);
    
        var _x = owner.x + 0.5;
        var _y = owner.y;
        var _angle = owner.image_angle;
    
        var _rocket_y = _y - ((_y_offset - _spr_height) div (_y_offset / 2));
        var _rocket_x_left  = _x - _spr_width / 3;
        var _rocket_x_right = _x + _spr_width / 4;
        var _scale_x = (owner.hspeed < 0) ? -1 : 1;
        
        var _time = current_time * 0.005;
      
        shader_set(sh_engine_flare); 
        shader_set_uniform_f(shader_get_uniform(sh_engine_flare, "u_time"), _time);
        shader_set_uniform_f(shader_get_uniform(sh_engine_flare, "u_flameColor"), 0.7, 0.2, 1.0);

        draw_sprite_ext(spr_rockets_red_variant_1, flare_frame, _rocket_x_left, _rocket_y , _scale_x,1, _angle, c_white, 1);
        draw_sprite_ext(spr_rockets_red_variant_1, flare_frame,  _rocket_x_right, _rocket_y, _scale_x,1, _angle, c_white,1);
        
        shader_reset();
    });
};