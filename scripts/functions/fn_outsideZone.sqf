/*
@
@ Author: Slep.
@ File: fn_outsideZone.sqf
@ Description: Script that will warn a player if they are outside the game zone, and will kill them if they stay out for too long
@
*/

params ["_isOutside"];
private ["_i"];

_i = 0;

if (!gameActive) exitWith {};

while { !(triggerActivated GameZone) && gameActive } do {
	hint parseText format["<t size='3' color='#9b0500' shadow='1'>Outside Zone</t><br/>Return to the zone in %1 seconds.",5-_i];
	_i = _i + 1;
	uisleep 1;
	if ( _i == 5) exitWith { 
		player setDamage 1;
		hint "You cannot leave the marked red circle.";
	};
};