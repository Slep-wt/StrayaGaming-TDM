class TimerBar {
	idd = 1099;
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Slep., v1.063, #Vypewi)
	////////////////////////////////////////////////////////
	class timer: RscStructuredText
	{
		idc = 1100;

		text = "<t size='0.34'>&#160;</t><br/><t size=""3"" font=""PuristaSemibold"" align=""center"">1:23</t>"; //--- ToDo: Localize;
		x = 12.73 * GUI_GRID_W + GUI_GRID_X;
		y = -10.23 * GUI_GRID_H + GUI_GRID_Y;
		w = 12.1212 * GUI_GRID_W;
		h = 4.54545 * GUI_GRID_H;
		colorText[] = {219,219,219,1};
		colorBackground[] = {0.2,0.2,0.2,1};
		sizeEx = 1 * GUI_GRID_H * GUI_GRID_H * GUI_GRID_H;
	};
	class timer_stage: RscStructuredText
	{
		idc = 1101;

		text = "<t align=""center"">Stage</t>"; //--- ToDo: Localize;
		x = 15.15 * GUI_GRID_W + GUI_GRID_X;
		y = -7.05 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.27273 * GUI_GRID_W;
		h = 0.909091 * GUI_GRID_H;
		colorBackground[] = {0.2,0.2,0.2,1};
		sizeEx = 0.5 * GUI_GRID_H * GUI_GRID_H * GUI_GRID_H;
	};
	class timer_round: RscStructuredText
	{
		idc = 1102;

		text = "<t align=""center"">Round</t>"; //--- ToDo: Localize;
		x = 15.2 * GUI_GRID_W + GUI_GRID_X;
		y = -10.26 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.27273 * GUI_GRID_W;
		h = 0.909091 * GUI_GRID_H;
		colorBackground[] = {0.2,0.2,0.2,1};
		sizeEx = 0.5 * GUI_GRID_H * GUI_GRID_H * GUI_GRID_H;
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////
};



