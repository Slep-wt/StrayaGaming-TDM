/*
@
@ Author: Slep.
@ File: fn_admin_invisibility.sqf
@ Description: Oooh spooky. Hides an admins player model.
@
*/

private ["_hidden"];

if !(uid call ct_fnc_allowedUser) exitWith { 
	"prohibited" call BIS_fnc_endMission;
}; 

if !(isObjectHidden player) then {
	[player, true] remoteExec ["hideObjectGlobal",2,false];
	hint "Player Hidden";
} else {
	[player, false] remoteExec ["hideObjectGlobal",2,false];
	hint "Player Unhidden";
};

