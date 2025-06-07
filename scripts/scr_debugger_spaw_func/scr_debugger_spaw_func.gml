///@function scr_spawn_player_ship
///@description Spawna uma nave do player com base no tipo informado.
///@param {string} _ship_type Tipo da nave: "cerulean" ou "ember_strike".
function scr_spawn_player_ship(_ship_type = "cerulean") {
    if (instance_exists(obj_uss_father)) {
        with (obj_uss_father) {
            instance_destroy();
        }
    }

    var _spawn_x = MIDDLE_WIDTH_ROOM;
    var _spawn_y = BORDER_BOUND_TOP + 20;

    var _space_ship;

    switch (_ship_type) {
        case "cerulean":
            _space_ship = obj_uss_cerulean
            break;

        case "ember_strike":
            _space_ship = obj_uss_ember_strike
            break;

        default:
            show_debug_message("Tipo de nave inválido: " + _ship_type);
            return;
    }

    var _ship = instance_create_layer(_spawn_x, _spawn_y, PLAYER_LAYER, _space_ship);

    return _ship;
}
