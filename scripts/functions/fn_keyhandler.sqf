params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];
private _handled = false;

switch (_dikCode) do {
	case 0x01: {
		if (playerSide == independent) then {
			((findDisplay 49) displayCtrl 1010) ctrlEnable false;
		};
	};
	case 0x23: {
		if (_shift) then {
			player action ["SWITCHWEAPON",player,player,-1];
		};
	};
	case 0xCF: {
		if ((musicVolume > 0.2)||(soundVolume > 0.2)) then {
			1 fadeSound 0.2;
			1 fadeMusic 0.2;
			hint parseText "<t size='3' color='#e07f00' shadow='1'>Earplugs in</t>";
			systemChat "You put in some earplugs.";
			_handled = true;
		} else {
			1 fadeSound (originalaudio select 0);
			1 fadeMusic (originalaudio select 1);
			hint parseText "<t size='3' color='#e07f00' shadow='1'>Earplugs out</t>";
			systemChat "You took out your earplugs.";
			_handled = true;
		};
	};
};

_handled;