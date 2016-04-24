class RscScarHudCurrentVehicle
{
    idd = 16031;
    duration = 99999;
    fadeIn = 0.3;
    onLoad = "uiNamespace setVariable ['RscScarHudCurrentVehicle', _this select 0]";
    class IGUIBack
    {
    	type = 0;
    	style = 128;
    	text = "";
    	colorText[] = {0,0,0,0};
    	font = "PuristaMedium";
    	sizeEx = 0;
    	shadow = 0;
    	colorbackground[] = {1,1,1,0.97};
    };
    class RscText
    {
    	deletable = 0;
    	fade = 0;
    	access = 0;
    	type = 0;
        colorBackground[] = {1,1,1,0.97};
    	colorText[] = {0,0,0,0.8};
    	text = "";
    	fixedWidth = 0;
    	style = 0;
    	shadow = 0;
    	colorShadow[] = {0,0,0,0.5};
    	font = "PuristaMedium";
    	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    	linespacing = 0;
    	tooltipColorText[] = {1,1,1,1};
    	tooltipColorBox[] = {1,1,1,1};
    	tooltipColorShade[] = {0,0,0,0.65};
    };
    class RscPicture
    {
        deletable = 0;
    	fade = 0;
    	access = 0;
    	type = 0;
    	style = 48;
    	colorBackground[] = {0,0,0,0};
    	colorText[] = {0,0,0,0.8};
    	font = "TahomaB";
    	sizeEx = 0;
    	lineSpacing = 0;
    	text = "";
    	fixedWidth = 0;
    	shadow = 0;
    	tooltipColorText[] = {1,1,1,1};
    	tooltipColorBox[] = {1,1,1,1};
    	tooltipColorShade[] = {0,0,0,0.65};
    };
    class Controls
    {
      class vehInfoPanel: IGUIBack
      {
        idc = -1;
        x = 0.872 * safezoneW + safezoneX;
        y = 0.931 * safezoneH + safezoneY;
        w = 0.015 * safezoneW;
        h = 0.045 * safezoneH;
      };
      class vehSpeedBackground: IGUIBack
      {
        idc = -1;
        x = 0.889 * safezoneW + safezoneX;
        y = 0.917 * safezoneH + safezoneY;
        w = 0.065 * safezoneW;
        h = 0.036 * safezoneH;
      };
      class vehicleSpeed: RscText
      {
        idc = 1000;
        style = 1;
        font = "PuristaSemiBold";
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.7)";
        colorBackground[] = {-1,-1,-1,-1};
           x = 0.889 * safezoneW + safezoneX;
        y = 0.911 * safezoneH + safezoneY;
        w = 0.065 * safezoneW;
        h = 0.04 * safezoneH;
      };
      class vehicleImageBackground: IGUIBack
      {
        idc = 1001;
        x = 0.956 * safezoneW + safezoneX;
        y = 0.884 * safezoneH + safezoneY;
        w = 0.031 * safezoneW;
        h = 0.0685 * safezoneH;
      };
      class vehicleImage: RscPicture
      {
        idc = 1002;
        style = 2096;
        x = 0.956 * safezoneW + safezoneX;
        y = 0.888 * safezoneH + safezoneY;
        w = 0.031 * safezoneW;
        h = 0.045 * safezoneH;
      };
      class vehicleDamage: RscText
      {
        idc = 1003;
        style = 2;
        font = "PuristaSemiBold";
        colorBackground[] = {1,1,1,0.3};
        x = 0.956 * safezoneW + safezoneX;
        y = 0.935 * safezoneH + safezoneY;
        w = 0.031 * safezoneW;
        h = 0.018 * safezoneH;
      };
      class ALT: RscText
      {
        idc = 1006;
        style = 1;
        fade = 1;
        font = "PuristaSemiBold";
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.6)";
        x = 0.889 * safezoneW + safezoneX;
        y = 0.892 * safezoneH + safezoneY;
        w = 0.065 * safezoneW;
        h = 0.025 * safezoneH;
      };
      class vehicleFuelBarBackground: IGUIBack
      {
        idc = -1;
        x = 0.915 * safezoneW + safezoneX;
        y = 0.956 * safezoneH + safezoneY;
        w = 0.0725 * safezoneW;
        h = 0.02 * safezoneH;
      };
      class vehicleFuelBar: RscText
      {
        idc = 1010;
        type = 8;
        colorBar[] = {0,0,0,0.8};
        colorFrame[] = {-1,-1,-1,-1};
        texture = "#(argb,8,8,3)color(1,1,1,1)";
        x = 0.9165 * safezoneW + safezoneX;
        y = 0.958 * safezoneH + safezoneY;
        w = 0.0695 * safezoneW;
        h = 0.015 * safezoneH;
      };
      class txtFuel: RscText
      {
        idc = -1;
        style = 2;
        text = "FUEL";
        x = 0.889 * safezoneW + safezoneX;
        y = 0.956 * safezoneH + safezoneY;
        w = 0.025 * safezoneW;
        h = 0.02 * safezoneH;
      };
      class imgLights: RscPicture
      {
        idc = 1011;
        style = 2096;
        text = "A3\ui_f\data\IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa";
        colorText[] = {0,0,0,0.25};
        x = 0.872 * safezoneW + safezoneX;
        y = 0.932 * safezoneH + safezoneY;
        w = 0.015 * safezoneW;
        h = 0.025 * safezoneH;
      };
      class imgCollisLights: RscPicture
      {
        idc = 1012;
        style = 2096;
        text = "A3\ui_f\data\IGUI\Cfg\VehicleToggles\collisionlightsiconon_ca.paa";
        colorText[] = {0,0,0,0.25};
        x = 0.872 * safezoneW + safezoneX;
        y = 0.95 * safezoneH + safezoneY;
        w = 0.015 * safezoneW;
        h = 0.025 * safezoneH;
      };
    };
};
