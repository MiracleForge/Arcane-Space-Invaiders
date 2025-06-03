function scr_bullet_create () constructor {
     vspeed = -3;
     sprite_index = spr_bullet_basic;
     cooldown = 3;
}

function src_bullet_heat_create (): scr_bullet_create() constructor {
    vspeed = -2;
    sprite_index = spr_bullet_heat;
    cooldown = 1; 
}

function src_bullet_missile_create (): scr_bullet_create() constructor {
     sprite_index = spr_missile_basic;
     cooldown = 6;
     speed = 0.5;
}

	
