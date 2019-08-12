#include "..\..\macros.hpp"
/*
@
@ Author: Slep.
@ File: fn_roundEnd.sqf
@ Description: Finishes a round, then initialises another
@
*/

params ["_rndWinner"];
if (isServer) then {
	gameActive = false;
	publicVariable "gameActive";
	switch (_rndWinner) do {
		case west: {
			lvWest = lvWest + 1;
			publicVariable "lvWest";
			["Blufor won the round!"] remoteExec ["hint",0,true];
			if ((lvWest > 4) && (lvEast <= 4)) then {
				["Blufor wins the game!"] remoteExec ["hint",0,true];
				winner = "westWon";
				gameover = true;
				publicVariable "winner";
				publicVariable "gameover";
				winner call BIS_fnc_endMission;
				waituntil { !gameover };
			};
		};
		case east: {
			lvEast = lvEast + 1;
			["Opfor won the round!"] remoteExec ["hint",0,true]; 
			publicVariable "lvEast";
			if ((lvEast > 4) && (lvWest <= 4)) then {
				["Opfor wins the game!"] remoteExec ["hint",0,true]; 
				winner = "eastWon";
				gameover = true;
				publicVariable "winner";
				publicVariable "gameover";
				winner call BIS_fnc_endMission;
				waituntil { !gameover };
			};
		};
	};
};

while {gameover} do {uisleep 0.1};

if (hasInterface) then {
	waitUntil { !(gameActive) };
};
uisleep 5;

switch (playerSide) do {
	case east: { spm(rse) };
	case west: { spm(rsw) };
};

call ct_fnc_roundInit;




