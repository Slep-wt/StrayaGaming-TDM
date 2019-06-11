#include "macros.hpp"
/*
@
@ Author: Slep.
@ File: init.sqf
@ Description: Clientside initialisation for TDM
@
*/

/* Init */

Server_HasInit = false;
sleep 1;
cutText ["Initialising Client", "BLACK FADED", 999];

allowedAdmins = [""];

while { !Server_HasInit } do { };

// Variable Init
preInit = false;

uid = "getPlayerUID player";
idPlayer = "getPlayerUIDOld player";
playerName = "profileName player"; 

dEast = nil;
dWest = nil;
lvWest = nil;
lvEast = nil;
curRnd = nil;
playerCountW = 0;
playerCountE = 0;
gameActive = false;
ltime = nil;
uidMrksEast = "0";
uidMrksWest = "0";
playersReady = ["_ARR_INIT_"];
spawnsEast = ["cz_east_1","cz_east_2","cz_east_3"];
spawnsWest = ["cz_blue_1","cz_blue_2","cz_blue_3"];

if (isNil "dEast") then {
	ltime = 0;
	dEast = 0;
	lvEast = 0;
	dWest = 0;
	lvWest = 0;
	curRnd = 1;
};



// Player Init
if (hasInterface) then {
	player addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		
		switch (playerSide) do {
			case west: {
				dWest = dWest + 1;
				publicVariable "dWest";
			};

			case east: {
				dEast = dEast + 1;
				publicVariable "dEast";
			};
		};
	}];

	player addEventHandler ["Respawn", {
		params ["_unit", "_corpse"];

		player enableStamina false;
		player setCustomAimCoef 0.3;
		removeAllWeapons player;
		removeAllItems player;
		removeAllAssignedItems player;
		removeVest player;
		removeBackpack player;
		removeHeadgear player;
		removeGoggles player;
		setTerrainGrid 25;
		sleep 2;

		switch (playerSide) do {
			case west: {
				spm(rsw);
			};
			case east: {
				spm(rse);
			};
		};
	}];

	waitUntil {!isNull player && player == player};

	if (playerSide == independent && !(uid call ct_fnc_allowedUser)) exitWith {
		player enableSimulation false;
		titleCut ["", "BLACK FADED", 999];
		"notAdmin" call BIS_fnc_endMission;
	};

	removeAllWeapons player;
	removeAllItems player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;
	removeGoggles player;

	player enableStamina false;
	player setCustomAimCoef 0.3;
	setTerrainGrid 25;

	waitUntil { alive player };

	switch (playerSide) do {
		case west: {
			playerCountW = playerCountW + 1;
			publicVariable "playerCountW";
			spm(rsw);
		};
		case east: {
			playerCountE = playerCountE + 1;
			publicVariable "playerCountE";
			spm(rse);
		};
		case independent: {spm(rsi)};
	};

	if (playerSide != independent) then {
		player addEventHandler ["InventoryOpened", {
			params ["_unit", "_container"];
			true;
		}];
	} else {
		["GAMEMASTER"] call ct_fnc_setUnitLoadout;
		player addAction ["Admin Teleport", {call ct_fnc_admin_teleport}];
		player addAction ["Admin Invisibility", {call ct_fnc_admin_teleport}]; 
	};
	titlecut [" ","BLACK IN",5];
	call ct_fnc_roundInit;
};



