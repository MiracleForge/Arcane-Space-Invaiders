function ScrProjectileCreate () constructor {
     vspeed = -3;
     sprite_index = spr_bullet_basic;
     cooldown = 3;
}

function SrcProjectileHeatCreate (): ScrProjectileCreate() constructor {
    vspeed = -2;
    sprite_index = spr_bullet_heat;
    cooldown = 1; 
}

function SrcProjectileMissileCreate (): ScrProjectileCreate() constructor {
     sprite_index = spr_missile_basic;
     cooldown = 6;
     speed = 0.5;
}

	
