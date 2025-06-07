///@description Constructor for Player Basic Ship
///@param {Id.Instance} _owner Instance Id from the owner object
function ShipCeruleanCreate(_owner) constructor {
    //===[ Owner ]===\\
    owner = _owner; ///@type Id.Instance

    //===[ Core Stats ]===\\
    shield = 3;
    shield_capacity = 3;
    metalic_belt = 2;
    metalic_belt_capacity = 2;
    is_damaged = false;

    //===[ Heat System ]===\\
    overheat_status = 0;
    overheat_capacity = 15;

    //===[ Movement Params ]===\\
    static max_speed = 2;
    static acceleration = 2;
    static glide_factor = 0.90;

    //===[ Weapon & Firing ]===\\
    shoot_on = false;
    shot_countdown = 18;

    //===[ Flame Visuals ]===\\
    flare_frame = 0;
    flare_scale = 1;
    //flash_strength = 1;

    //===[ Tilting ]===\\
    static tilt = 2;

    state_movement = new StatePlayerMovement();
    state_movement.entity = self;

    ///@description Method that allows player to shoot based on some params
    shoot_projectile = method(self, function () {
        var _is_overheated = (overheat_status >= overheat_capacity);

        if (!_is_overheated && owner.alarm[0] == -1 && INPUT_SHOOT) {
            fire_bullet();
            increase_heat(1);
            owner.alarm[0] = shot_countdown;
             } else if (_is_overheated) {
            state_movement = new StatePlayerOverHeatIt()
        }
    });

    ///@description Restore an amount of shield energy.
    ///@param {real} _amount Quantity of shield restored.
    restore_shield = method(self, function(_amount) {
        shield = clamp(shield + _amount, 0, shield_capacity);
    });

    ///@description Restore an amount of life
    ///@param {real} _amount_ Quantity of life restored.
    restore_metalic_belt = method(self, function(_amount_ = 1) {
        metalic_belt = clamp(metalic_belt + _amount_, 0, metalic_belt_capacity);
    });

    ///@description Rise an amount of heat from arm system.
    ///@param {real} _amount Quantity of heat increased.
    increase_heat = method(self, function(_amount) {
        overheat_status = clamp(overheat_status + _amount, 0, overheat_capacity);
    });

    ///@description Fire a bullet from the emissor.
    ///@param {struct} [_constructor_] Bullet Data. Default: `new BulletCreate()`.
    ///@return {Id.Instance} Reference of instance.
    fire_bullet = method(self, function(_constructor_ = new ScrProjectileCreate()) {
        var _h = owner.sprite_height;
        var _inst = instance_create_layer(owner.x, owner.y - _h, "bullets", obj_projectile_father, _constructor_);
    });
    
    take_hit = method(self, function(_damage) {
        if (is_damaged) exit;
    
        is_damaged = true;
        owner.alarm[1] = INVUNERABILITY_TIME;
        flash_strength = 1;
    
        metalic_belt = clamp(metalic_belt - _damage, 0, metalic_belt_capacity);
    
        if (IS_PLAYER_DEAD) {
            owner.sprite_index = spr_explosion_default;
            exit;
       }
    
        if !audio_is_playing(snd_explosion_medium) then audio_play_sound(snd_explosion_medium, 1, false);
    });

    
    ///@description FlashBang baby, variable is_damaged controls the appers of the flash
    flash_hit = method(self, function() {
        if (!is_damaged) exit; 
            layer_set_visible("Effect_1", true);
        show_debug_message("flash_hit")
        var _t = current_time * 0.01;
        flash_strength = abs(sin(_t));
    
        shader_set(sh_flash_blink);
        var _u_flash = shader_get_uniform(sh_flash_blink, "u_flash_strength");
        shader_set_uniform_f(_u_flash, flash_strength);
        draw_sprite(owner.sprite_index, -1, owner.x, owner.y);
        shader_reset();
        });

    ///@description Destroy and animate the destroction of spaceship. Uses message broadcast from explosion sprites
    destroy = method(self, function(_instance_ = owner.id) {
        if event_data[? "event_type"] == "sprite event"
        {
            switch (event_data[? "message"])
            { 
                case "destroy":
                    state_movement.stop();
                    audio_play_sound(snd_explosion_medium, 1, false);
                    if owner.image_number = 10 then  instance_destroy(_instance_);
                        layer_set_visible("Effect_1", false);
                break;
            };
        };
    });
    

    ///@description Draw methods for rocket flame logic.
    draw_rocket_flame = method(self, function() {
         IF_PLAYER_DEAD_RETURN;
        var _time = current_time * 0.005;
        
        var _y_offset = sprite_get_yoffset(owner.sprite_index);
        var _rocket_y_offset = owner.y - ((_y_offset - owner.sprite_height) div (_y_offset / 2));
        var _rocket_x_offset = owner.x - 0.5;
        
        shader_set(sh_engine_flare); 
        shader_set_uniform_f(shader_get_uniform(sh_engine_flare, "u_time"), _time);
        shader_set_uniform_f(shader_get_uniform(sh_engine_flare, "u_flameColor"), 0.7, 0.2, 1.0);
        
        draw_sprite_ext(spr_rockets_red, flare_frame, _rocket_x_offset, _rocket_y_offset, 1, 1, owner.image_angle, c_white, 1);
        shader_reset();
    });
};