if (!global.is_release) {
    layer_create(1, "debugger");
    instance_create_layer(0, 0, "debugger", obj_controller_debugger);
};
