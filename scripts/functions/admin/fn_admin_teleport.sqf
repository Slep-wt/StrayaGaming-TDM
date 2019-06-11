/*
@
@ Author: Slep.
@ File: fn_outsideZone.sqf
@ Description: Admin teleport script, pretty self explanatory
@
*/

private ["_newPos", "_timer"];

if !(uid call ct_fnc_allowedUser) exitWith { 
	[idPlayer, uid, playerName, 0] remoteExec ["ctserver_fn_kickUser",2];  
}; 

openMap true;
_timer = time + 1;
while {time <= _timer} do {};
hint "Click on map to teleport."
onMapSingleClick "player setPos _pos; onMapSingleClick ' '; true;"
openMap false;
_newPos = getPosATL player;
hint format["Teleported to %1 %2 %3",_newPos select 0, _newPos select 1, _newPos select 2]; 