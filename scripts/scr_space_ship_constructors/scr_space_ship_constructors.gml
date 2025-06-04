///@description Constructor for Player Basic Ship
///@param {Id.Instance} _owner Instance Id from the owner object
function ShipCeruleanCreate(_owner) constructor {
    //===[ Owner ]===
    owner = _owner; ///@type Id.Instance

    //===[ Core Stats ]===
    shield = 3;
    shield_capacity = 3;
    metalic_belt = 1;
    metalic_belt_capacity = 1;

    //===[ Heat System ]===
    overheat_status = 0;
    overheat_capacity = 15;

    //===[ Movement Params ]===
    static max_speed = 2;
    static acceleration = 2;
    static glide_factor = 0.90;

    //===[ Weapon & Firing ]===
    shoot_on = false;
    shot_countdown = 18;

    //===[ Flame Visuals ]===
    flare_frame = 0;
    flare_scale = 1;

    //===[ Tilting ]===
    tilt = 2;

    state_movement = new StatePlayerMovement();
    state_movement.entity = self;

    ///@description Method that allows player to shoot based on some params
    shoot_projectile = method(self, function () {
        var _is_overheated = (overheat_status >= overheat_capacity);

        if (!_is_overheated && owner.alarm[0] == -1 && INPUT_SHOOT) {
            fire_bullet();
            increase_heat(1);
            owner.alarm[0] = shot_countdown;
            show_debug_message(shot_countdown);
        } else if (_is_overheated) {
            show_debug_message("OVERHEAT!");
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
        var _h = owner.sprite_height / 2;
        var _inst = instance_create_layer(owner.x, owner.y - _h, "bullets", obj_projectile_father, _constructor_);
    });

    ///@description Draw methods for rocket flame logic.
    draw_rocket_flame = method(self, function() {
        var _y_offset = sprite_get_yoffset(owner.sprite_index);
        var _rocket_y_offset = owner.y - ((_y_offset - owner.sprite_height) div (_y_offset / 2));
        var _rocket_x_offset = owner.x - 0.5;

        var _time = current_time * 0.005;
        var _pulse = sin(_time) * 0.1 + 1;
        flare_scale = lerp(flare_scale, _pulse + random_range(0.0, 0.5), 0.5);

        var _alpha = 0.6 + 0.2 * sin(_time * 2);

        gpu_set_blendmode(bm_add);

        draw_sprite_ext(spr_rockets_red, flare_frame, _rocket_x_offset, _rocket_y_offset + random_range(-0.5, 0.5), flare_scale * 1.2, flare_scale * 1.2, owner.image_angle, make_color_rgb(80, 160, 255), _alpha);

        draw_sprite_ext(spr_rockets_red, flare_frame, _rocket_x_offset, _rocket_y_offset, flare_scale, flare_scale, owner.image_angle, c_white, 1);

        gpu_set_blendmode(bm_normal);
    });
};

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
        }
    });
};
