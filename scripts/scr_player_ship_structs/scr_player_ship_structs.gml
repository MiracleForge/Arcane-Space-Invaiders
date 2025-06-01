function space_ship_create() constructor {
    shield = 0;
    shieldCapacity = 300;
    metalicBelt = 200;
    overheatStatus = 0;
    overheatCapacity = 200;
    mov_speed = 0.7;
    max_speed = 4;
    mass = 0.5;
    acceleration = 2;
    shootOn = false;
    shotCountdown = 40;

    rechargeShield = function(amount) {
        show_debug_message("Charging " + string(amount));
        shield = clamp(shield + amount, 0, shieldCapacity);
    };

    takeHeat = function(amount) {
        show_debug_message("Heathing " + string(amount));
        overheatStatus = clamp(overheatStatus + amount, 0, overheatCapacity);
    };
    
 /// @function shotBullet
/// @description Cria uma instância de projétil (bala) na posição fornecida, utilizando uma struct para definir os dados da bala.
/// @param {real} _x                 - Posição X onde a bala será criada (geralmente a posição da nave).
/// @param {real} _y                 - Posição Y onde a bala será criada.
/// @param {real} _sprite_height     - Altura do sprite da nave, usado para calcular o offset vertical da bala.
/// @param {Asset.GMObject} _entity     - Objeto da instância que está disparando a bala (por exemplo, a nave).
/// @param {struct} [constructor_]   - Struct com os dados da bala (velocidade, sprite, etc). Padrão: `new bullet_create()`.
/// @return {Asset.GMObject}            - Referência à bala criada.
/// @example - shotBullet(x, y, sprite_height, id, new bullet_strong_create());
    shotBullet = function (_x, _y, _sprite_height, _entity, constructor_ = new bullet_create()) {
        var _bullet = instance_create_layer(_x , _y - _sprite_height, "bullets", obj_father_bullet, constructor_);
        alarm[0] = shotCountdown;
    }
    
    sprite_index = spr_USS_Cerulean;
 
}


