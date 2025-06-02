function bullet_create (owner_ = noone) constructor {
     vspeed = -3;
     sprite_index = spr_bullet_basic;
     cooldown = 3;
     target = noone;
     owner = owner_; // Keep the instance that own this struct.
     state_machine = undefined; // Start machineState
};

function bullet_heat_create (owner_): bullet_create(owner_) constructor {
    vspeed = -2;
    sprite_index = spr_bullet_heat;
    cooldown = 1; 
};

function bullet_missile_create (owner_): bullet_create(owner_) constructor {
     //vspeed = -2;
     sprite_index = spr_missile_basic;
     cooldown = 6;
     speed = 0.5
     //state_machine = new scr_missile_state(owner_)
};

	
