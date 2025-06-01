///@description Constructor for Player Basic Ship
///@param {Id.Instance} _owner Instance Id from the owner object
function uss_cerulean_create(_owner) constructor {
    shield           = 150;        ///@type real
    shieldCapacity   = 150;        ///@type real
    metalicBelt      = 100;        ///@type real
    overheatStatus   = 0;          ///@type real
    overheatCapacity = 150;        ///@type real
    mov_speed        = 0.8;        ///@type real
    mass             = 0.5;        ///@type real
    acceleration     = 2.5;        ///@type real
    shootOn          = false;      ///@type bool
    shotCountdown    = 20;         ///@type real

    owner = _owner;                       // guarda a instância (objeto) que possui essa struct
    state_movement = new state_player_movement(self); // passa a struct inteira pro estado

    ///@description Restore an amount quantity of shield energy.
    ///@param {real} amount Quantity of shield restored.
    restoreShield = method(self, function(amount) {
        shield = clamp(shield + amount, 0, shieldCapacity);
    });

    ///@description Rise an amount quantity of heat from arm system.
    ///@param {real} amount Quantity of heat increased.
    increaseHeat = method(self, function(amount) {
        overheatStatus = clamp(overheatStatus + amount, 0, overheatCapacity);
    });

    ///@description Fire a bullet from the emissor.
    ///@param {struct} [constructor_] Bullet Data. Default: `new bullet_create()`.
    ///@return {Id.Instance} Referece of instance.
    fireBullet = method(self, function(constructor_ = new bullet_create()) {
        var _h = owner.sprite_height / 2;    ///@type real
        instance_create_layer(owner.x, owner.y - _h, "bullets", obj_father_bullet, constructor_);
    });
}

///@description Constructor for Player Heavy Ship
///@param {Id.Instance} _owner Instance Id from the owner object
function uss_indigo_create(_owner) : uss_cerulean_create(_owner) constructor {
    shield           = 300;        ///@type real
    shieldCapacity   = 300;        ///@type real
    metalicBelt      = 200;        ///@type real
    overheatStatus   = 0;          ///@type real
    overheatCapacity = 200;        ///@type real
    mov_speed        = 0.5;        ///@type real
    mass             = 0.7;        ///@type real
    acceleration     = 1.2;        ///@type real
    shootOn          = false;      ///@type bool
    shotCountdown    = 40;         ///@type real

    owner = _owner;
    state_movement = new state_player_movement(self);

    restoreShield = method(self, function(amount) {
        shield = clamp(shield + amount, 0, shieldCapacity);
    });

    increaseHeat = method(self, function(amount) {
        overheatStatus = clamp(overheatStatus + amount, 0, overheatCapacity);
    });

    fireBullet = method(self, function(constructor_ = new bullet_create()) {
        var _h = owner.sprite_height / 2;    ///@type real
        var _w = owner.sprite_width / 2;     ///@type real
        
        instance_create_layer(owner.x + _w, owner.y - _h, "bullets", obj_father_bullet, constructor_);
        instance_create_layer(owner.x - _w, owner.y - _h, "bullets", obj_father_bullet, constructor_);
    });
}




