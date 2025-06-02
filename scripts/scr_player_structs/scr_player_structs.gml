///@description Constructor for Player Basic Ship
///@param {Id.Instance} _owner Instance Id from the owner object
function uss_cerulean_create(_owner) constructor {
    shield                     = 150;        ///@type real
    static shieldCapacity      = 150;        ///@type real
    metalicBelt                = 1;          ///@type real
    static metalicBeltCapacity = 1;          ///@type real
    overheatStatus             = 0;          ///@type real
    static overheatCapacity    = 150;        ///@type real
    mov_speed                  = 0.8;        ///@type real
    mass                       = 0.5;        ///@type real
    acceleration               = 2.5;        ///@type real
    static shootOn             = false;      ///@type bool
    static shotCountdown       = 20;         ///@type real

    owner = _owner; // Keep the instance that own this struct.
    state_movement = new state_player_movement(self); // Start machineState

    ///@description Restore an amount quantity of shield energy.
    ///@param {real} amount Quantity of shield restored.
    restoreShield = method(self, function(amount) {
        shield = clamp(shield + amount, 0, shieldCapacity);
    });
    
    ///@description Restore an amount quantity of hp 
    ///@param {real} amount_ Quantity of life restored.
    restoreMetalicBelt = method(self, function(amount_ = 1) {
        metalicBelt = clamp(metalicBelt + amount_, 0, metalicBeltCapacity);
    })

    ///@description Rise an amount quantity of heat from arm system.
    ///@param {real} amount Quantity of heat increased.
    increaseHeat = method(self, function(amount) {
        overheatStatus = clamp(overheatStatus + amount, 0, overheatCapacity);
    });

    ///@description Fire a bullet from the emissor.
    ///@param {struct} [constructor_] Bullet Data. Default: `new bullet_create()`.
    ///@return {Id.Instance} Referece of instance.
    fireBullet = method(self, function(constructor_ = new bullet_create()) {
        var _h = owner.sprite_height / 2;
        instance_create_layer(owner.x, owner.y - _h, "bullets", obj_father_bullet, constructor_);
    });
};


///@description Constructor for Player USS_EmberStrike.
///@param {Id.Instance} _owner Instance Id from the owner object.
function uss_ember_strike_create(_owner) : uss_cerulean_create(_owner) constructor {
    shield                     = 300;        ///@type real
    static shieldCapacity      = 300;        ///@type real
    static overheatCapacity    = 200;        ///@type real
    mov_speed                  = 0.5;        ///@type real
    static mass                = 0.7;        ///@type real
    acceleration               = 1.2;        ///@type real
    shotCountdown              = 40;         ///@type real

    ///@description Fire a bullet from the emissor.
    ///@param {struct} [constructor_] Bullet Data. Default: `new bullet_create()`.
    ///@return {Id.Instance} Referece of instance.
    fireBullet = method(self, function(constructor_ = new bullet_heat_create()) {
        var _h = owner.sprite_height * 0.5;
        var _w = owner.sprite_width * 0.5;
    
        static missile_timer = 0;

        instance_create_layer(owner.x + _w, owner.y - _h, "bullets", obj_father_bullet, constructor_);
        instance_create_layer(owner.x - _w, owner.y - _h, "bullets", obj_father_bullet, constructor_);
    
        if (--missile_timer <= 0) {
            var missile = new bullet_missile_create();
            instance_create_layer(owner.x, owner.y - _h, "bullets", obj_father_bullet, missile);
            missile_timer = missile.cooldown;
        }
});
};