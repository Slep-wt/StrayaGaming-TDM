params ["_command", "_data"];

if (isNil "_command") exitWith { "<TDM Client> Server Communication: Command null" };

switch (_command) do {
	case "notif_kicked_protected": {
		hint format parseText ["<t size='3' color='#910000' shadow='1'>Admin Notification: Player Kicked</t><br/><t>Player attempted to modify/access a protected function.</t><br><t color='#910000'>Action Taken:</t> Kicked<br/><t color='#910000'>Name:</t> %1<br/><t color='#910000'>UID:</t> %2<br/>",_data select 0, _data select 1];
	};
	// Will add more functions as the project progresses.
};
