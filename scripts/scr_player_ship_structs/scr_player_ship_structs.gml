///@description Constructor for Player Basic Ship
///@param {Asset.GMObject} _owner Instance Id from the owner object
function space_ship_create(_owner) constructor {
    shield           = 0;
    shieldCapacity   = 300;
    metalicBelt      = 200;
    overheatStatus   = 0;
    overheatCapacity = 200;
    mov_speed        = 0.7;
    mass             = 0.5;
    acceleration     = 2;
    shootOn          = false;
    shotCountdown    = 40;
    sprite_index     = spr_USS_Cerulean;

    owner = _owner;                       // guarda a instância (objeto) que possui essa struct
    state_movement = new state_player_movement(self); // passa a struct inteira pro estado

    ///@description Restore an amount quantity of shield energy.
    ///@param {real} amount Quantity of shield restored.
    restoreShield = function(amount) {
        shield = clamp(shield + amount, 0, shieldCapacity);
    };

    ///@description Rise an amount quantity of heat from arm system.
    ///@param {real} amount Quantity of heat increased.
    increaseHeat = function(amount) {
        overheatStatus = clamp(overheatStatus + amount, 0, overheatCapacity);
    };

    ///@description Fire a bullet from the emissor.
    ///@param {struct} [constructor_] Bullet Data. Default: `new bullet_create()`.
    ///@return {Id.Instance} Referece of instance.
    fireBullet = function(constructor_ = new bullet_create()) {
        var _h = owner.sprite_height;
        instance_create_layer(owner.x, owner.y - _h, "bullets", obj_father_bullet, constructor_);
    };

}


