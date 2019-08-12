/*
@
@ Author: Slep.
@ File: fn_admin_teleport.sqf
@ Description: Admin teleport script, pretty self explanatory
@
*/

private ["_lpos"];

if !(uid call ct_fnc_allowedUser) exitWith { 
	"prohibited" call BIS_fnc_endMission;
}; 

_pos = [0];
_startpos = getPosATL player;
hint "Click on the Map where you'd like to teleport.";
openMap true;
onMapSingleClick { 
	player setPos _pos;
	onMapSingleClick {};
};
sleep 1;
_lpos = getPosATL player;
while { _startpos select 0 == _lpos select 0 } do {
	_lpos = getPosATL player;
};
openMap false; 
hint format["Teleported to %1, %2", _lpos select 0, _lpos select 1];