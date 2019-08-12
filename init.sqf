#include "macros.hpp"
/*
@
@ Author: Slep.
@ File: initPlayerLo.sqf
@ Description: Clientside initialisation for TDM
@
*/

/* Init */

//Admin Users ~~      Slep.         ~       Joshua       ~          Red       ~          M9'       ~        James32     ~         Asnee      ~       Nevetos      ~         Mitch      ~       Leeseven     ~      pkisbest
//AllowedAdmins localised into fn_allowedUser.sqf    allowedAdmins = ["76561198116711642", "76561198243429216", "76561198038557796", "76561198062672956", "76561198042385883", "76561198062186998", "76561198078615667", "76561198191010871", "76561198147006208", "76561198078903168"];

// Variable Init
preInit = false;

spawnsEast = ["cz_east_1","cz_east_2","cz_east_3"];
spawnsWest = ["cz_blue_1","cz_blue_2","cz_blue_3"];

if (isServer) then {

	ltime = 0;
	dEast = 0;
	lvEast = 0;
	dWest = 0;
	lvWest = 0;
	curRnd = 1;
	playerCountE = 0;
	playerCountW = 0;
	uidMrksEast = "0";
	uidMrksWest = "0";
	playersW = ["_ARR_INIT_"];
	playersE = ["_ARR_INIT_"];
	playersReady = ["_ARR_INIT_"];
	gameActive = false;
	gameover = false;
	winner = "NOT_DEFINED";

	publicVariable "ltime";
	publicVariable "dEast";
	publicVariable "dWest";
	publicVariable "lvWest";
	publicVariable "lvEast";
	publicVariable "curRnd";
	publicVariable "playersE";
	publicVariable "playersW";
	publicVariable "playerCountE";
	publicVariable "playerCountW";
	publicVariable "uidMrksEast";
	publicVariable "uidMrksWest";
	publicVariable "playersReady";
	publicVariable "gameActive";
	publicVariable "gameover";
	publicVariable "winner";


	addMissionEventHandler ["HandleDisconnect", {
		params ["_unit", "_id", "_uid", "_name"];
		if (uidMrksEast == _uid) then {
			uidMrksEast = "0";
			publicVariable "uidMrksEast";
		};
		if (uidMrksWest == _uid) then {
			uidMrksWest = "0";
			publicVariable "uidMrksWest";
		};

		if (_uid in playersReady) then {
			playersReady = playersReady - [uid];
			publicVariable "playersReady";
		};

		if (_uid in playersE) then {
			playersE = playersE - [_uid];
			playerCountE = (count playersE) - 1;
			publicVariable "playersE";
			publicVariable "playerCountE";
		};
		if (_uid in playersW) then {
			playersW = playersW - [_uid];
			playerCountW = (count playersW) - 1;
			publicVariable "playersW";
			publicVariable "playerCountW";
		};
	}];
	diag_log "<CT Server>: PublicVariables Initialised";

	call ct_fnc_roundInit;

	waituntil {gameover};
	winner call BIS_fnc_endMissionServer;
};


if (hasInterface && !isServer) then {

	waitUntil { !(isNull player) };

	// Player Init
	0 cutText ["Initialising Client", "BLACK FADED", 99999999];

	removeAllWeapons player;
	removeAllItems player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;
	removeGoggles player;

	player enableStamina false;
	player setCustomAimCoef 0.3;
	setTerrainGrid 25;


	uid = getPlayerUID player;
	idPlayer = player;
	playerName = profileName;

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

		player allowDamage false;

		{
			deleteVehicle _x;
		} forEach allDeadMen;

		if ((uid == uidMrksEast)||(uid == uidMrksWest)) then { ["MARKSMAN", true] call ct_fnc_setUnitLoadout } else { "ASSAULT" call ct_fnc_setUnitLoadout };

		switch (playerSide) do {
			case west: {
				spm(rsw);
			};
			case east: {
				spm(rse);
			};
		};
	}];

	if ((playerSide == independent) && !(uid call ct_fnc_allowedUser)) exitWith {
		player enableSimulation false;
		titleCut ["", "BLACK FADED", 999];
		"notAdmin" call BIS_fnc_endMission;
	};

	switch (playerSide) do {
		case west: {
			playersW = playersW + [uid];
			playerCountW = (count playersW)-1;
			spm(rsw);
			publicVariable "playersW";
			publicVariable "playerCountW";
		};
		case east: {
			playersE = playersE + [uid];
			playerCountE = (count playersE)-1;
			spm(rse);
			publicVariable "playersE";
			publicVariable "playerCountE";
		};
		case independent: {spm(rsi)};
	};

	if (playerSide != independent) then {
		player addEventHandler ["InventoryOpened", {
			params ["_unit", "_container"];
			true;
		}];
		0 enableChannel [true, false]; // Enable user ability to send text but disable voice on global channel
	} else {
		player allowDamage false;
		player addAction ["Admin Teleport", {[] spawn ct_fnc_admin_teleport}];
		player addAction ["Admin Invisibility", {call ct_fnc_admin_invisibility}];
		"GAMEMASTER" call ct_fnc_setUnitLoadout;
	};
	
	[] execVM "scripts\QS_icons.sqf";
	
	0 cutText ["","BLACK IN"];

	//Local Earplugs
	originalaudio = [soundVolume, musicVolume]; //Collect user presets, will use them later
	waitUntil {!(isNull (findDisplay 46))};
	(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call ct_fnc_keyHandler"];
	
	call ct_fnc_roundInit;
};



