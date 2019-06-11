/*
@
@ Author: Slep.
@ File: fn_admin_invisibility.sqf
@ Description: Oooh spooky. Hides an admins player model.
@
*/

private ["_hidden"];

if !(uid call ct_fnc_allowedUser) exitWith { 
	[idPlayer, uid, playerName, 0] remoteExec ["ctserver_fn_kickUser",2];  
}; 

if !(isObjectHidden player) then {
	[player, true] remoteExec ["hideObjectGlobal",2,false];
	hint "Player Hidden";
} else {
	[player, false] remoteExec ["hideObjectGlobal",2,false];
	hint "Player Unhidden";
};

