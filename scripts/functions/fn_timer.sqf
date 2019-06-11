/*
@
@ Author: Slep.
@ File: fn_timer.sqf
@ Description: Increments ltime as a means of keeping count of time.
@
*/


private ["_ret"];

_ret = false;
uiSleep 1;

if (ltime < 421) then {
	ltime = ltime + 1;
	publicVariable "ltime";
	if (ltime == 151) then {
		hint "2:30 left!";
	};
	if (ltime == 300) then {
		hint "Overtime! You have an extra two minutes!"
	}; 
} else {
	_ret = true;
};

_ret;