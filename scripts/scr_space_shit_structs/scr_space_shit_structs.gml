function space_ship_create() constructor {
    shield = 0;
    shieldCapacity = 200;
    metalicBelt = 200;
    mov_speed = 5;
    overheatStatus = 0;
    overheatCapacity = 200;
    shootOn = false;

    rechargeShield = function(amount) {
        shield = clamp(shield + amount, 0, shieldCapacity);
    };

    takeHeat = function(amount) {
        overheatStatus = clamp(overheatStatus + amount, 0, overheatCapacity);
    };
    
    sprite_index = spr_USS_Cerulean;
}
