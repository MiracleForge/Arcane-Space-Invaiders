//data = new uss_cerulean_create(id);
//data.state_movement = new state_player_movement(data); // <- passa a struct real agora
//init_state(data.state_movement);
data = new uss_cerulean_create(id);

// O estado já foi criado dentro da struct, e `state_movement.entity = self` já está feito
init_state(data.state_movement);
alarm[0] = -1;
flare_frame = 0;