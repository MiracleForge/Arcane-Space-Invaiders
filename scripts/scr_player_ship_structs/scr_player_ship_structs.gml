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

    // ⚠️ IMPORTANTE: ISSO AQUI
    owner = _owner;                       // guarda a instância (objeto) que possui essa struct
    state_movement = new state_player_movement(self); // passa a struct inteira pro estado

    restoreShield = function(amount) {
        shield = clamp(shield + amount, 0, shieldCapacity);
    };

    increaseHeat = function(amount) {
        overheatStatus = clamp(overheatStatus + amount, 0, overheatCapacity);
    };

    fireBullet = function(_x, _y, _sprite_height, _entity, constructor_ = new bullet_create()) {
        instance_create_layer(_x, _y - _sprite_height, "bullets", obj_father_bullet, constructor_);
    };
}


