/*
@
@ Author: Slep.
@ File: fn_setUnitLoadout.sqf
@ Description: Loadout configuration and Rearm script.
@
*/


private ["_uid","_skip"];
params ["_loadout","_rearm"];

_uid = getPlayerUID player;

if (isNil "_rearm") then { _rearm = false };
if (isNil "_loadout") then { _loadout = "ASSAULT" };

if (_rearm) then {
	if (uidMrksEast == _uid || uidMrksWest == _uid) then {
		_loadout = "MARKSMAN";
	};
	player setDamage 0;
};

_skip = false;
_ammoModifier = 8;

if (!_rearm) then {
	if ((_loadout == "MARKSMAN")&&(uidMrksEast != _uid)&&(uidMrksWest != _uid)) then {
		switch (playerSide) do {
			case west : {
				if (uidMrksWest == "0") then {
					uidMrksWest = _uid;
					publicVariable "uidMrksWest";
				} 
				else 
				{
					hint "Loadout Taken. Max (1) Marksman per team.";
					_skip = true;
				};
			};

			case east : {
				if (uidMrksEast == "0") then {
					uidMrksEast = _uid;
					publicVariable "uidMrksEast";
				} 
				else 
				{
					hint "Loadout Taken. Max (1) Marksman per team.";
					_skip = true;
				};
			};
		};
	} 
	else 
	{
		switch (playerSide) do {
			case west : {
				if (uidMrksWest == _uid) then {
					uidMrksWest = "0";
					publicVariable "uidMrksWest";
					_loadout = "ASSAULT";
				};
			};

			case east : {
				if (uidMrksEast == _uid) then {
					uidMrksEast = "0";
					publicVariable "uidMrksEast";
					_loadout = "ASSAULT";
				};
			};
		};
	};
};

if (!(_skip)) then {
	removeAllWeapons player;
	removeAllItems player;
	removeAllAssignedItems player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;
	removeGoggles player;

	switch (playerSide) do { 
		case west : {
			player forceAddUniform "U_B_SpecopsUniform_sgg";
			player addBackpack "B_AssaultPack_rgr";
			player addItemToBackpack "Medikit";
			player addHeadgear "H_HelmetSpecB";
			player addVest "V_PlateCarrier2_rgr";
			for "_i" from 1 to 2 do {player addItemToUniform "HandGrenade";};
			for "_i" from 1 to 2 do {player addItemToUniform "SmokeShellBlue";};

			switch (_loadout) do {
				case "ASSAULT" : {
					player addWeapon "arifle_MX_Black_F";
					player addPrimaryWeaponItem "acc_pointer_IR";
					player addPrimaryWeaponItem "optic_Arco_blk_F";
					player addWeapon "hgun_ACPC2_F";
					player addWeapon "Rangefinder";

					for "_i" from 1 to (5+_ammoModifier) do {player addItemToVest "30Rnd_65x39_caseless_black_mag";};
					for "_i" from 1 to 2 do {player addItemToVest "9Rnd_45ACP_Mag";};
				};
				case "MARKSMAN" : {
					player addWeapon "srifle_EBR_F";
					player addPrimaryWeaponItem "acc_pointer_IR";
					player addPrimaryWeaponItem "optic_DMS";
					player addPrimaryWeaponItem "bipod_01_F_blk";
					player addWeapon "hgun_ACPC2_F";
					player addWeapon "Rangefinder";

					for "_i" from 1 to (5+_ammoModifier) do {player addItemToVest "20Rnd_762x51_Mag";};
					for "_i" from 1 to 2 do {player addItemToVest "9Rnd_45ACP_Mag";};
				};
			};
		}; 
		case east : {
			player forceAddUniform "U_O_OfficerUniform_ocamo";
			player addBackpack "B_AssaultPack_rgr";
			player addItemToBackpack "Medikit";
			player addHeadgear "H_HelmetSpecO_ocamo";
			player addVest "V_PlateCarrier2_rgr";

			for "_i" from 1 to 2 do {player addItemToUniform "HandGrenade";};
			for "_i" from 1 to 2 do {player addItemToUniform "SmokeShellRed";};

			switch (_loadout) do {
				case "ASSAULT" : {
					player addWeapon "arifle_MX_Black_F";
					player addPrimaryWeaponItem "acc_pointer_IR";
					player addPrimaryWeaponItem "optic_Arco_blk_F";
					player addWeapon "hgun_ACPC2_F";
					player addWeapon "Rangefinder";

					for "_i" from 1 to (5+_ammoModifier) do {player addItemToVest "30Rnd_65x39_caseless_black_mag";};
					for "_i" from 1 to 2 do {player addItemToVest "9Rnd_45ACP_Mag";};
				};
				case "MARKSMAN" : {
					player addWeapon "srifle_EBR_F";
					player addPrimaryWeaponItem "acc_pointer_IR";
					player addPrimaryWeaponItem "optic_DMS";
					player addPrimaryWeaponItem "bipod_01_F_blk";
					player addWeapon "hgun_ACPC2_F";
					player addWeapon "Rangefinder";

					for "_i" from 1 to (5+_ammoModifier) do {player addItemToVest "20Rnd_762x51_Mag";};
					for "_i" from 1 to 2 do {player addItemToVest "9Rnd_45ACP_Mag";};
				};
			};
		}; 
		case independent : {
			player allowDamage false;
			player forceAddUniform "U_I_Soldier_VR";
			player addVest "V_PlateCarrier1_blk";
			player addHeadgear "H_PilotHelmetHeli_B";
			player addWeapon "srifle_DMR_03_AMS_F";
			for "_i" from 1 to (5+_ammoModifier) do {player addItemToVest "20Rnd_762x51_Mag";};
		};
	};

	player linkItem "ItemMap";
	player linkItem "ItemCompass";
	player linkItem "ItemWatch";
	player linkItem "ItemRadio";
	player linkItem "ItemGPS";
	player linkItem "NVGoggles";
};



