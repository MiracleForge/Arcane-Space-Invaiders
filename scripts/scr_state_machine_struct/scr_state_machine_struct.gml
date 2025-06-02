function state() constructor {
    start = method(self, function() {});
    run   = method(self, function() {});
    stop  = method(self, function() {});
};

function run_state() {
    active_state.run();
};

function change_state(_state) {
    active_state.stop();
    active_state = _state;
    active_state.start();
};

function init_state(_state) {
    active_state = _state;
    active_state.start();
};