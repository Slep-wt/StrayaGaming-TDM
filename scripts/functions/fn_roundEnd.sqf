#include "..\..\macros.hpp"
/*
@
@ Author: Slep.
@ File: fn_roundEnd.sqf
@ Description: Finishes a round, then initialises another
@
*/

params ["_rndWinner"];

switch (_rndWinner) do {
	case west: { 
		lvWest = (lvWest + 1);
		if ((lvWest > 4) && (lvEast <= 4)) then {
			hint "Blufor Wins!";
			waituntil {"westWon" call BIS_fnc_endMissionServer};
			
		};
		publicVariable "lvWest";
	};
	case east: {
		lvEast = (lvEast + 1);
		if ((lvEast > 4) && (lvWest <= 4)) then {
			hint "Opfor Wins!";
			waituntil {"eastWon" call BIS_fnc_endMissionServer}; 
			
		};
		publicVariable "lvEast";
	};
};

switch (playerSide) do {
	case east: { spm(rse) };
	case west: { spm(rsw) };
};

curRnd = (curRnd + 1);
publicVariable "curRnd";
call ct_fnc_roundInit;




