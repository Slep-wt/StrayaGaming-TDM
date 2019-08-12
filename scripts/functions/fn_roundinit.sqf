#include "..\..\macros.hpp"

/*
@
@ Author: Slep.
@ File: fn_roundInit.sqf
@ Description: Round initialisation.
@
*/

private ["_spawnarea","_spawnarr"];

if (playerSide == independent) exitWith {};

player allowDamage false;

if (isServer) then {
	playersReady = ["_ARR_INIT_"];
	publicVariable "playersReady";
};

uisleep 2;

if (gameActive) then { // If is JIP
	if (hasInterface) then {
		"ASSAULT" call ct_fnc_setUnitLoadout; // Set loadout to default
	};
} else {
	while { (playerCountE == 0)||(playerCountW == 0) } do {
		hintSilent "Waiting for players to join...";
	};

	hint "Planning Period Begins";

	if (isServer) then {
		dEast = 0;
		dWest = 0;
		publicVariable "dEast";
		publicVariable "dWest";
	};

	_spawnarr = ["_ARR_INIT_"]; 
	_spawnarea = "spawn_undefined";

	waitUntil { (count playersReady) > (playerCountE+playerCountW) };

	hint parseText format ["<t size='3' color='#00299b' shadow='1'>Round %1</t><br/>Good Luck!<br/>Wasteland: %2 | Altis Life: %3", (str curRnd), (str lvEast), (str lvWest)];
	if (isServer) then {
		gameActive = true;
		publicVariable "gameActive";
	};

	[playerSide, "HQ"] sideChat format ["Round %1 begins! Good Luck! -- Wasteland: %2 | Altis Life: %3", (str curRnd), (str lvEast), (str lvWest)];
	if (isServer) then {
		curRnd = curRnd + 1;
		publicVariable "curRnd";
	};
};

player allowDamage true;

switch (playerSide) do {
	case east: { _spawnarr = spawnsEast };
	case west: { _spawnarr = spawnsWest };
};

_spawnarea = (selectRandom _spawnarr);

spm(_spawnarea);

waitUntil { ((dEast == (playerCountE))||(dWest == (playerCountW))) };

if (dEast <= dWest) then {
	east call ct_fnc_roundEnd; 
} else {
	west call ct_fnc_roundEnd;
};
