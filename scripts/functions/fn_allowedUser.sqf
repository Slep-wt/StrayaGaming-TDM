/*
@
@ Author: Slep.
@ File: fn_allowedUsers.sqf
@ Description: Quick script used to check if a player is a verified admin.
@
*/

params ["_uid"];
private ["_allowedAdmins","_ret"];

_ret = false;

if (_uid in allowedAdmins) then {
	_ret = true; 
};

_ret;

