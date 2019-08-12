// functions.hpp

class CfgFunctions {
	class ct {
		tag = "ct";
		class core {
			file = "scripts\functions";
			class allowedUser {};
			class keyHandler {};
			class roundInit {};
			class roundEnd {};
			class readyUp {};
			class setUnitLoadout {};
			class skipBriefing {
				preInit = 1;
			};
		};

		class admin {
			file = "scripts\functions\admin";
			class admin_invisibility {};
			class admin_teleport {};
		};

		class communication {
			file = "scripts\functions\communication";
			class fromServer {};
		};
	};
};
