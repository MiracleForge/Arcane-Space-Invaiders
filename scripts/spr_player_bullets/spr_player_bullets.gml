function bullet_create () constructor {
     vspeed = -3;
     sprite_index = spr_bullet_basic;
     cooldown = 3;
}

function bullet_heat_create (): bullet_create() constructor {
    vspeed = -2;
    sprite_index = spr_bullet_heat;
    cooldown = 1; 
}

function bullet_missile_create (): bullet_create() constructor {
     vspeed = -2;
     sprite_index = spr_missile_basic;
     cooldown = 6;
}