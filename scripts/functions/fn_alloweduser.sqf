/*
@
@ Author: Slep.
@ File: fn_allowedUsers.sqf
@ Description: Quick script used to check if a player is a verified admin.
@
*/

params ["_uid"];
private ["_allowedAdmins","_ret"];

//Admin Users ~~      Slep.         ~       Joshua       ~          Red       ~          M9'       ~        James32     ~         Asnee      ~       Nevetos      ~         Mitch      ~       Leeseven     ~      pkisbest
_allowedAdmins = ["76561198116711642", "76561198243429216", "76561198038557796", "76561198062672956", "76561198042385883", "76561198062186998", "76561198078615667", "76561198191010871", "76561198147006208", "76561198078903168"];


_ret = false;

if (_uid in _allowedAdmins) then {
	_ret = true; 
};

_ret;

