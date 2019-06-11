#include "..\..\macros.hpp"
private ["_spawnarea","_spawnarr","_players","_ct_timer"];

playersReady = ["_ARR_INIT_"];

ltime = 0;

waitUntil { 
	if (playerCountW + playerCountE > 1) then {
		true;
	} else {
		uisleep 1;
		hintSilent "Waiting for another player to join...";
	};
};

waitUntil{!isNil "playersReady"};

dEast = 0;
dWest = 0;
_spawnarr = [""]; 
_spawnarea = "spawn_undefined";

waitUntil{!isNil "_spawnarea"};
waitUntil{!isNil "_spawnarr"};

switch (playerSide) do {
	case east: { _spawnarr = spawnsEast };
	case west: { _spawnarr = spawnsWest };
};

waitUntil{ count playersReady == (playerCountE + playerCountW - 1) };

_spawnarea = (selectRandom _spawnarr);

hint parseText format ["<t size='3' color='#00299b' shadow='1'>Round %1</t><br/>Good Luck!<br/>Wasteland: %2 | Altis Life: %3", (str curRnd), (str lvEast), (str lvWest)];

gameActive = true;
publicVariable "gameActive";

spm(_spawnarea);

call ct_fnc_outsideZone;

waitUntil { ((dEast == (playerCountE))||(dWest == (playerCountW))||(call ct_fnc_timer == true)) };

if (dEast <= dWest) then {
	east call ct_fnc_roundEnd; 
} else {
	west call ct_fnc_roundEnd;
};
