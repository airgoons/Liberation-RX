params ["_unit", "_pos"];
private [ "_backpack", "_backpack_contents", "_is_mobile_respawn" ];

_unit allowDamage false;
_backpack = backpack _unit;
if ( _backpack != "" && _backpack != "B_Parachute" ) then {
	_is_mobile_respawn = (backpackContainer _unit) getVariable ["GRLIB_mobile_respawn_bag", false];
	_backpack_contents = backpackItems _unit;
	removeBackpack _unit;
	sleep 0.1;
};
_unit addBackpack "B_Parachute";
_unit setPos _pos vectorAdd [floor(random 20), floor(random 20), 0];
sleep 3;
_unit allowDamage true;
halojumping = false;

if(!isPlayer _unit) then {
	_unit allowDamage false;
	removeBackpack _unit;
	waitUntil {sleep 0.1; getPosATL  _unit select 2 < 120};
	_unit addBackpack "b_parachute";
	_unit action ["openParachute"];
}

waitUntil {sleep 0.1; isTouchingGround _unit or (!alive _unit)};

if ( _backpack != "" && _backpack != "B_Parachute" ) then {
	_unit addBackpack _backpack;
	clearAllItemsFromBackpack _unit;
	{_unit addItemToBackpack _x} foreach _backpack_contents;
	if (_is_mobile_respawn) then {
		(backpackContainer _unit) setVariable ["GRLIB_mobile_respawn_bag", true, true];
	};
};

if(!isPlayer _unit) then {
	_unit allowDamage true;
}

_unit doFollow player;
