/// Create Event

// Verifica se a struct foi passada corretamente
if (is_struct(id)) {
    if (variable_instance_exists(id, "target")) target = id.target;
    if (variable_instance_exists(id, "owner")) owner = id.owner;
    if (variable_instance_exists(id, "cooldown")) cooldown = id.cooldown;
    if (variable_instance_exists(id, "speed")) speed = id.speed;
    if (variable_instance_exists(id, "sprite_index")) sprite_index = id.sprite_index;

    // Inicia a máquina de estados apenas se ela existir e for válida
    if (variable_instance_exists(id, "state_machine") && is_struct(id.state_machine)) {
        state_machine = id.state_machine;
        init_state(state_machine);
    } else {
        show_debug_message("WARNING: Missile state_machine is undefined or invalid.");
    }
} else {
    show_debug_message("ERROR: No struct passed to missile instance.");
}
