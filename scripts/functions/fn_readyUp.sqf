/*
@
@ Author: Slep.
@ File: fn_readyUp.sqf
@ Description: Sets the players status as ready or not ready.
@
*/

private ["_uid", "_pleft"];

if (playerCountE + playerCountW == 1) exitWith {};

if (gameActive) exitWith { hint "Please wait until the round ends to ready up..." }; 

_pleft = ((playerCountE + playerCountW)-(count playersReady - 1));
_uid = getPlayerUID player;
if (_uid in playersReady) then {
	playersReady = playersReady - [_uid];
	publicVariable "playersReady";
	[[playerSide, "HQ"], format ["%1 is not ready", profileName]] remoteExec ["sideChat", playerSide, false];
	hint parseText "<t size='3' color='#9b0500' shadow='1'>Not Ready</t><br/>The round will start when everyone is ready.";
} else {
	playersReady pushBack _uid;
	publicVariable "playersReady";
	[[playerSide, "HQ"], format format ["%1 is ready. Waiting for %2 players to ready up...", profileName,_pleft]] remoteExec ["sideChat", playerSide, false];
	hint parseText format["<t size='3' color='#009614' shadow='1'>Ready</t><br/>Waiting on %1 players to ready up.", _pleft];
};



