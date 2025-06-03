///@description Constructor for Player Basic Ship
///@param {Id.Instance} _owner Instance Id from the owner object
function uss_cerulean_create(_owner) constructor {
    shield              = 3;        ///@type real
    shieldCapacity      = 3;        ///@type real
    metalicBelt         = 1;          ///@type real
    metalicBeltCapacity = 1;          ///@type real
    overheatStatus      = 0;          ///@type real
    overheatCapacity    = 15;        ///@type real
    mov_speed           = 1;        ///@type real
    mass                = 0.5;        ///@type real
    acceleration        = 2.5;        ///@type real
    shootOn             = false;      ///@type bool
    shotCountdown       = 18;         ///@type real


    owner = _owner; // Keep the instance that own this struct.
    state_movement = new state_player_movement(self); // Start machineState
    
    ///@description Methods that allow player to shoot based in some params
    shootProjectile = method(self, function () {
         var isOverheated = (overheatStatus >= overheatCapacity);

        if (!isOverheated && owner.alarm[0] == -1 && INPUT_SHOOT) {
            fireBullet();                 // dispara
            increaseHeat(1);              // acumula calor, por exemplo 
          
            owner.alarm[0] = shotCountdown;
   
            show_debug_message( shotCountdown)
                // inicia cooldown entre tiros
        }
        else if (isOverheated) {
            show_debug_message("OVERHEAT!");
            // aqui você pode tocar um som, piscar HUD etc.
        }
    })

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
    fireBullet = method(self, function(constructor_ = new scr_bullet_create()) {
        var _h = owner.sprite_height / 2;
        instance_create_layer(owner.x, owner.y - _h, "bullets", obj_projectile_father, constructor_);
        });
};


///@description Constructor for Player USS_EmberStrike.
///@param {Id.Instance} _owner Instance Id from the owner object.
function uss_ember_strike_create(_owner) : uss_cerulean_create(_owner) constructor {
    shield                     = 5;        ///@type real
    static shieldCapacity      = 5 ;        ///@type real
    static overheatCapacity    = 3;        ///@type real
    mov_speed                  = 1.3;        ///@type real
    mass                       = 0.7;        ///@type real
    acceleration               = 1.3;        ///@type real
    shotCountdown              = 40;         ///@type real

    ///@description Fire a bullet from the emissor.
    ///@param {struct} [constructor_] Bullet Data. Default: `new bullet_create()`.
    ///@return {Id.Instance} Referece of instance.
    fireBullet = method(self, function(constructor_ = new scr_bullet_create ()) {
     var half_h = owner.sprite_height * 0.5; 
     var half_w = owner.sprite_width * 0.5;

    
     static missile_timer = 0;

     var bullet_data = constructor_;
     instance_create_layer(owner.x + half_w, owner.y - half_h, "bullets", obj_projectile_father, bullet_data);
     instance_create_layer(owner.x - half_w, owner.y - half_h, "bullets", obj_projectile_father, bullet_data);

    
        if (--missile_timer <= 0) {
        show_debug_message("entrou no missil ")
             var missile = new src_bullet_missile_create(); var inst =instance_create_layer(owner.x, owner.y -half_h, "bullets", obj_projectile_missil, missile); 
             missile_timer = missile.cooldown;
        }
    });
};