data = new space_ship_create(id);          // cria a struct
init_state(data.state_movement);           // inicia estado depois da struct completa

sprite_index = data.sprite_index;
alarm[0] = data.shotCountdown;



