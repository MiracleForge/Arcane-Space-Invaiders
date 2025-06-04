///@description Constructor for Player Basic Ship
///@param {Id.Instance} _owner Instance Id from the objowner object
function UssCeruleanCreate(_owner) constructor {
    //===[ objowner ]===
    objowner = _owner; ///@type Id.Instance
    
    //===[ Core Stats ]===
    objshield                    = 3;
    objshield_capacity           = 3;
    objmetalic_belt              = 1;
    objmetalic_belt_capacity     = 1;
    
    //===[ Heat System ]===
objover_heat_status              = 0;
    objover_heat_capacity        = 15;
    
    //===[ Movement Params ]===
    static objmax_speed          = 2;
    static objacceleration       = 2;
    static objglide_factor       = 0.90;
    
    //===[ Weapon & Firing ]===
    objshoot_on                  = false;
    objshot_countdown            = 18;
    
    //===[ Flame Visuals ]===
    objflare_frame               = 0;
    objflare_scale               = 1;
    
    //===[ Tilting ]===
    objtilt                     = 2;

    objstate_movement = new StatePlayerMovement();
    objstate_movement.objentity = self;

    
    ///@description Methods that allow player to shoot based in some params
    shoot_projectile = method(self, function () {
        var _is_over_heated = (objover_heat_status >= objover_heat_capacity);

        if (!_is_over_heated && objowner.alarm[0] == -1 && INPUT_SHOOT) {
            fire_projectile();
            increase_heat(1);
          
            objowner.alarm[0] = objshot_countdown;
   
            show_debug_message( objshot_countdown)
        }
        else if (_is_over_heated) {
            show_debug_message("OVERHEAT!");
        }
    })

    ///@description Restore an amount quantity of objshield energy.
    ///@param {real} _amount Quantity of objshield restored.
    restore_objshield = method(self, function(_amount) {
        objshield = clamp(objshield + _amount, 0, objshield_capacity);
    });
    
    ///@description Restore an amount quantity of hp 
    ///@param {real} _amount_ Quantity of life restored.
    restore_metalic_belt = method(self, function(_amount_ = 1) {
        objmetalic_belt = clamp(objmetalic_belt + _amount_, 0, objmetalic_belt_capacity);
    })

    ///@description Rise an amount quantity of heat from arm system.
    ///@param {real} _amount Quantity of heat increased.
    increase_heat = method(self, function(_amount) {
        obj_over_heat_status = clamp(objover_heat_status + _amount, 0, objover_heat_capacity);
    });

    ///@description Fire a bullet from the emissor.
    ///@param {struct} [_constructor_] Bullet Data. Default: `new bullet_create()`.
    ///@return {Id.Instance} Referece of instance.
    fire_projectile = method(self, function(_constructor_ = new ScrBulletCreate()) {
        var _h = objowner.sprite_height / 2;
        var _inst = instance_create_layer(objowner.x, objowner.y - _h, "bullets", obj_projectile_father, _constructor_); 
    });
    
    
    //// Draw Methods
    ///@description Draw methods for drow engine flame and logic.
    draw_turbine_flame = method(self, function() {
        var _y_offset = sprite_get_yoffset(objowner.sprite_index);
        var _rocket_y_offset = objowner.y - ((_y_offset - objowner.sprite_height) div (_y_offset / 2));
        var _rocket_x_offset = objowner.x - 0.5;
    
        var _time = current_time * 0.005;
        var _pulse = sin(_time) * 0.1 + 1;
        objflare_scale = lerp(objflare_scale, _pulse + random_range(0.0, 0.5), 0.5);
    
        var _alpha = 0.6 + 0.2 * sin(_time * 2);
    
        gpu_set_blendmode(bm_add);
    
        draw_sprite_ext(
            spr_rockets_red, objflare_frame,
            _rocket_x_offset, _rocket_y_offset + random_range(-0.5, 0.5),
            objflare_scae * 1.2, objflare_scae * 1.2,
            objowner.image_angle,
            make_color_rgb(80, 160, 255),
            _alpha
        );
    
        draw_sprite_ext(
            spr_rockets_red, objflare_frame,
            _rocket_x_offset, _rocket_y_offset,
            objflare_scae, objflare_scae,
            objowner.image_angle,
            c_white,
            1
        );
        gpu_set_blendmode(bm_normal);
});

};

/////////////////////// EMBER STRIKE /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

///@description Constructor for Player USS_EmberStrike.
///@param {Id.Instance} _owner Instance Id from the objowner object.
function UssEmberStrikeCreate(_owner) : UssCeruleanCreate(_owner) constructor {
    objshield                      = 5;          ///@type real
    static objshield_capacity      = 5 ;         ///@type real
    static objoverheat_capacity    = 3;          ///@type real
    static obj_max_speed           = 1;          ///@type real
    static objglide_factor         = 0.95;       ///@type float take more time to ship stop
    static objacceleration         = 2;          ///@type real
    objshot_countdown              = 40;         ///@type real

    ///@description Fire a bullet from the emissor.
    ///@param {struct} [_constructor_] Bullet Data. Default: `ScrBulletCreate()`.
    ///@return {Id.Instance} Referece of instance.
    fire_projectile = method(self, function(_constructor_ = new ScrBulletCreate ()) {
         var _half_h = objowner.sprite_height * 0.5; 
         var _half_w = objowner.sprite_width * 0.5;
    
         static objmissile_timer = 0;
    
         var _instance_data = _constructor_;
         instance_create_layer(objowner.x + _half_w, objowner.y - _half_h, "bullets", obj_projectile_father, _instance_data);
         instance_create_layer(objowner.x - _half_w, objowner.y - _half_h, "bullets", obj_projectile_father, _instance_data);
    
        if (--objmissile_timer <= 0) {
            var _missile = new src_bullet_missile_create(); var _inst =instance_create_layer(objowner.x, objowner.y -_half_h, "bullets", obj_projectile_missil, _missile); 
            objmissile_timer = _missile.objcooldown;
        }
    });
};