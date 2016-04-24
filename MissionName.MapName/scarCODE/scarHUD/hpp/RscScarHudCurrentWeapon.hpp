class RscScarHudCurrentWeapon
{
    idd = 16032;
    duration = 99999;
    fadeIn = 0.3;
    onLoad = "uiNamespace setVariable ['RscScarHudCurrentWeapon', _this select 0]";
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
    	linespacing = 1;
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
      class stanceBackground: IGUIBack
      {
        idc = 1007;
        x = 0.956 * safezoneW + safezoneX;
        y = 0.884 * safezoneH + safezoneY;
        w = 0.031 * safezoneW;
        h = 0.0685 * safezoneH;
      };
      class stanceImage: RscPicture
      {
        idc = 1002;
        style = 2096;
        x = 0.956 * safezoneW + safezoneX;
        y = 0.888 * safezoneH + safezoneY;
        w = 0.031 * safezoneW;
        h = 0.045 * safezoneH;
      };
      class playerDamage: RscText
      {
        idc = 1006;
        style = 2;
        font = "PuristaSemiBold";
        colorBackground[] = {1,1,1,0.3};
        x = 0.956 * safezoneW + safezoneX;
        y = 0.935 * safezoneH + safezoneY;
        w = 0.031 * safezoneW;
        h = 0.018 * safezoneH;
      };
      class bulletCountBackground: IGUIBack
      {
        idc = -1;
        x = 0.889 * safezoneW + safezoneX;
        y = 0.917 * safezoneH + safezoneY;
        w = 0.065 * safezoneW;
        h = 0.036 * safezoneH;
      };
      class bulletCount: RscText
      {
        idc = 1001;
        style = 1;
        font = "PuristaSemiBold";
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2.7)";
        colorBackground[] = {-1,-1,-1,-1};
        x = 0.889 * safezoneW + safezoneX;
        y = 0.911 * safezoneH + safezoneY;
        w = 0.065 * safezoneW;
        h = 0.04 * safezoneH;
      };
      class currentZeroing: RscText
      {
        idc = 1003;
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = 0.856 * safezoneW + safezoneX;
        y = 0.915 * safezoneH + safezoneY;
        w = 0.031 * safezoneW;
        h = 0.018 * safezoneH;
      };
      class currentWeaponMode: RscText
      {
        idc = 1004;
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        x = 0.856 * safezoneW + safezoneX;
        y = 0.935 * safezoneH + safezoneY;
        w = 0.031 * safezoneW;
        h = 0.018 * safezoneH;
      };
      class magazineCount: RscText
      {
        idc = 1005;
        style = 1;
        font = "PuristaBold";
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.6)";
        x = 0.889 * safezoneW + safezoneX;
        y = 0.892 * safezoneH + safezoneY;
        w = 0.065 * safezoneW;
        h = 0.025 * safezoneH;
      };
      class currentThrowable: RscText
      {
        x = 0.856 * safezoneW + safezoneX;
        y = 0.956 * safezoneH + safezoneY;
        w = 0.1315 * safezoneW;
        h = 0.02 * safezoneH;

        idc = 1010;
        SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
        style = 1;
      };
    };
};
