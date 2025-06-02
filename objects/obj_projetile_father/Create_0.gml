if (variable_instance_exists(id, "target")) target = id.target;
if (variable_instance_exists(id, "state_machine")) {
    state_machine = id.state_machine;
    init_state(state_machine);
}

