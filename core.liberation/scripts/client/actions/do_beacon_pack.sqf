private _tent = cursorObject;

sleep random 0.3;

//only one at time
if ((_tent getVariable ["tent_in_use", false])) exitWith {};
player setVariable ["GRLIB_action_inuse", true, true];
_tent setVariable ["tent_in_use", true, true];
_tent setVariable ["R3F_LOG_disabled", true, true];

disableUserInput true;
player switchMove "AinvPknlMstpSlayWnonDnon_medic";
player playMoveNow "AinvPknlMstpSlayWnonDnon_medic";
sleep 6;
[_tent, "del"] remoteExec ["addel_beacon_remote_call", 2];
sleep 2;
if (backpack player == "") then {
	player addBackpack mobile_respawn_bag;
	(backpackContainer player) setVariable ["GRLIB_mobile_respawn_bag", true, true];
	(backpackContainer player) setMaxLoad 0;
} else {
	sleep 1;
	private _backpack = createVehicle [mobile_respawn_bag, (player getRelPos[3, 0]), [], 0, "NONE"];
	_backpack setVariable ["GRLIB_mobile_respawn_bag", true, true];
	_backpack setMaxLoad 0;
};
disableUserInput false;
disableUserInput true;
disableUserInput false;
player setVariable ["GRLIB_action_inuse", false, true];