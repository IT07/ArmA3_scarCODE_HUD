/*
    Author: IT07

    Description:
    launches and manages the scarHUD
*/

if hasInterface then
{
   showHUD
   [
      true,	// Scripted HUD (same as showHUD command)
   	false,	// Vehicle + soldier info
   	true,	// Vehicle radar [HIDDEN]
   	true,	// Vehicle compass [HIDDEN]
   	true,	// Tank direction indicator
   	true,	// Commanding menu
   	true,	// Group Bar
   	true	// HUD Weapon Cursors
   ];

   disableSerialization;
   waitUntil { if isNull(findDisplay 46) then { uiSleep 0.5; false } else { true } };
   while {true} do
   { // masterLoop
      scopeName "masterLoop";
      if (alive player) then
      {
         if (vehicle player isKindOf "Man") then
         {
            // Scope for when player is not in a vehicle
            (["RscScarHudCurrentWeapon"] call BIS_fnc_rscLayer) cutRsc ["RscScarHudCurrentWeapon","plain"];
            _dsp = uiNamespace getVariable ["RscScarHudCurrentWeapon", displayNull];
            if not isNull _dsp then
            {
               private["_ctrlWeaponName","_ctrlBg","_ctrlAmmo","_ctrlMagCap","_ctrlZeroing","_ctrlFireMode","_ctrlMagCount","_ctrlPlayerDamage","_ctrlPlayerBg","_ctrlStance","_ctrlScope","_ctrlAtt","_ctrlBipod","_ctrlSilencer","_ctrlNade"];
               _defineControls =
               {
                  _ctrlAmmo = _dsp displayCtrl 1001;
                  _ctrlZeroing = _dsp displayCtrl 1003;
                  _ctrlFireMode = _dsp displayCtrl 1004;
                  _ctrlMagCount = _dsp displayCtrl 1005;
                  _ctrlPlayerDamage = _dsp displayCtrl 1006;
                  _ctrlPlayerBg = _dsp displayCtrl 1007;
                  _ctrlStance = _dsp displayCtrl 1002;
                  _ctrlNade = _dsp displayCtrl 1010;
               };

               call _defineControls;
               while {alive player} do
               {
                  scopeName "currentWeaponLoop";
                  if (vehicle player isKindOf "Man") then
                  {
                     if not(currentWeapon player isEqualTo "") then
                     {
                        if not(weaponLowered player) then
                        {
                           if isNull _dsp then
                           {
                              (["RscScarHudCurrentWeapon"] call BIS_fnc_rscLayer) cutRsc ["RscScarHudCurrentWeapon","plain"];
                              _dsp = uiNamespace getVariable ["RscScarHudCurrentWeapon", displayNull];
                              call _defineControls;
                           };
                           _ammo = player ammo (currentWeapon player);
                           _magCap = getNumber (configFile >> "CfgMagazines" >> (currentMagazine player) >> "count");
                           if (_magCap - (_magCap - _ammo) < (_magCap / 6)) then
                           {
                              _ctrlAmmo ctrlSetTextColor [0.922,0.224,0.224,1]
                           } else { _ctrlAmmo ctrlSetTextColor (getArray (missionConfigFile >> "RscTitles" >> "RscScarHudCurrentWeapon" >> "RscText" >> "colorText")) };
                           _ctrlAmmo ctrlSetText str _ammo;
                           _magCount = call
                           {
                              _amount = 0;
                              {
                                 if (_x isEqualTo (currentMagazine player)) then
                                 {
                                    _amount = _amount + 1
                                 };
                              } forEach (magazines player);
                              _amount
                           };
                           if (_magCount isEqualTo 0) then
                           {
                              _ctrlMagCount ctrlSetTextColor [0.922,0.224,0.224,1];
                           } else
                           {
                              _ctrlMagCount ctrlSetTextColor (getArray (missionConfigFile >> "RscTitles" >> "RscScarHudCurrentWeapon" >> "RscText" >> "colorText"))
                           };
                           _hitPoints = (configFile >> "CfgVehicles" >> (typeOf (vehicle player)) >> "HitPoints") call BIS_fnc_getCfgSubClasses;
                           _maxDamage = count _hitPoints;
                           _hitDamage = 0;
                           _total = 0;
                           {
                              _hitDamage = _hitDamage + (vehicle player getHitPointDamage _x);
                           } forEach _hitPoints;
                           if not(_hitDamage isEqualTo 0) then
                           {
                              _total = round(100 - ((_hitDamage / _maxDamage) * 100));
                              _ctrlPlayerDamage ctrlSetText format["%1%2", _total, "%"];
                              switch true do
                              {
                                 case (_total >= 70):
                                 {
                                    _ctrlPlayerBg ctrlSetBackgroundColor [1,1,1,0.97];
                                    _ctrlStance ctrlSetTextColor [0,0,0,0.8];
                                 };
                                 case (_total >= 40):
                                 {
                                    _ctrlPlayerBg ctrlSetBackgroundColor [1,1,1,0.97];
                                    _ctrlStance ctrlSetTextColor [1,0.749,0,0.8];
                                 };
                                 case (_total >= 20):
                                 {
                                    _ctrlPlayerBg ctrlSetBackgroundColor [1,1,1,0.97];
                                    _ctrlStance ctrlSetTextColor [1,0,0,0.8];
                                 };
                                 case (_total < 20):
                                 {
                                    _ctrlPlayerBg ctrlSetBackgroundColor [1,0,0,0.5];
                                    _ctrlStance ctrlSetTextColor [1,0,0,1];
                                 };
                              };
                           } else
                           {
                              _ctrlPlayerBg ctrlSetBackgroundColor [1,1,1,0.97];
                              _ctrlStance ctrlSetTextColor [0,0,0,0.8];
                              _ctrlPlayerDamage ctrlSetText "100%";
                           };
                           // Set the stance icon
                           _animImage = getText(missionConfigFile >> "CfgStanceImages" >> (animationState player) >> "image");
                           if not(_animImage isEqualTo "") then
                           {
                              _ctrlStance ctrlSetText _animImage;
                           };
                           _ctrlZeroing ctrlSetText format["%1m", currentZeroing player];
                           _ctrlFireMode ctrlSetText (currentWeaponMode player);
                           _ctrlMagCount ctrlSetText format["x%1", _magCount];
                           _curNade = getText(configFile >> "CfgMagazines" >> ((currentThrowable player) select 0) >> "displayName");
                           if not isNil"_curNade" then
                           {
                              _curNadeCount = call
                              {
                                 _nades = 0;
                                 {
                                    if (_x isEqualTo (currentThrowable player select 0)) then
                                    {
                                       _nades = _nades + 1
                                    };
                                 } forEach (magazines player); _nades
                              };
                              _ctrlNade ctrlSetText format["%1 x%2", _curNade, _curNadeCount];
                           } else
                           {
                              _ctrlNade ctrlSetText "-"
                           };
                           uiSleep 0.075;
                        } else
                        {
                           if not isNull _dsp then
                           {
                              (["RscScarHudCurrentWeapon"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
                              uiSleep 0.5;
                           };
                        };
                     } else
                     {
                        if not isNull _dsp then
                        {
                           (["RscScarHudCurrentWeapon"] call BIS_fnc_rscLayer) cutRsc ["RscScarHudCurrentWeapon","PLAIN"];
                        };
                        uiSleep 0.5;
                     };
                  } else
                  {
                     (["RscScarHudCurrentWeapon"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
                     uiSleep 0.5;
                     breakTo "masterLoop"
                  };
               };
               if not(alive player) then
               {
                  breakTo "masterLoop";
               };
            };
         } else // if player in vehicle
         {
            // Scope for whilst player is in vehicle
            scopeName "inVehicle";
            if (assignedDriver vehicle player isEqualTo player) then
            {
               private ["_dsp","_defineControls"];
               (["RscScarHudCurrentVehicle"] call BIS_fnc_rscLayer) cutRsc ["RscScarHudCurrentVehicle","plain"];
               _dsp = uiNamespace getVariable ["RscScarHudCurrentVehicle", displayNull];
               if not isNull _dsp then
               {
                  private ["_ctrlSpeed","_ctrlVehFuel","_ctrlLights","_ctrlCollisLights","_ctrlVehHealth","_ctrlVehImageBg","_ctrlVehImage","_ctrlVehDamage","_ctrlAlt","_ctrlWarning"];
                  _defineControls =
                  {
                     _ctrlSpeed = _dsp displayCtrl 1000;
                     _ctrlVehFuel = _dsp displayCtrl 1010;
                     _ctrlLights = _dsp displayCtrl 1011;
                     _ctrlCollisLights = _dsp displayCtrl 1012;
                     _ctrlVehImageBg = _dsp displayCtrl 1001;
                     _ctrlVehImage = _dsp displayCtrl 1002;
                     _ctrlVehDamage = _dsp displayCtrl 1003;
                     _ctrlAlt = _dsp displayCtrl 1006;
                     _ctrlWarning = _dsp displayCtrl 1013;
                  };
                  call _defineControls;
                  if not(vehicle player isEqualTo player) then
                  {
                     if (vehicle player isKindOf "Air") then
                     {
                        _ctrlAlt ctrlSetFade 0;
                        _ctrlAlt ctrlCommit 0.5;
                     };
                     while {alive player} do
                     {
                        scopeName "vehicleLoop";
                        if not(vehicle player isKindOf "Man") then
                        {
                           if (driver vehicle player isEqualTo player) then
                           {
                              if isNull _dsp then
                              {
                                 (["RscScarHudCurrentVehicle"] call BIS_fnc_rscLayer) cutRsc ["RscScarHudCurrentVehicle","plain"];
                                 _dsp = uiNamespace getVariable ["RscScarHudCurrentVehicle", displayNull];
                                 call _defineControls;
                              };
                              _ctrlVehFuel progressSetPosition (fuel vehicle player);
                              _ctrlVehImage ctrlSetText (getText (configFile >> "CfgVehicles" >> (typeOf (vehicle player)) >> "Icon"));
                              _speed = round speed (vehicle player);
                              if not(_speed isEqualTo 0) then
                              {
                                 _ctrlSpeed ctrlSetText format["%1", _speed];
                              } else
                              {
                                 _ctrlSpeed ctrlSetText "0";
                              };
                              if (isLightOn (vehicle player)) then
                              {
                                 _ctrlLights ctrlSetTextColor [0,0,0,0.8];
                              } else
                              {
                                 _ctrlLights ctrlSetTextColor getArray(missionConfigFile >> "RscTitles" >> "RscScarHudCurrentVehicle" >> "Controls" >> "imgLights" >> "colorText");
                              };
                              if ((vehicle player) isKindOf "Air") then
                              {
                                 if (isCollisionLightOn (vehicle player)) then
                                 {
                                    _ctrlCollisLights ctrlSetTextColor [0,0,0,0.8];
                                 } else
                                 {
                                    _ctrlCollisLights ctrlSetTextColor getArray(missionConfigFile >> "RscTitles" >> "RscScarHudCurrentVehicle" >> "Controls" >> "imgCollisLights" >> "colorText");
                                 };
                                 _alt = round((getPosATL (vehicle player)) select 2);
                                 if not(_alt isEqualTo 0) then
                                 {
                                    _ctrlAlt ctrlSetText format["%1", _alt];
                                 } else
                                 {
                                    _ctrlAlt ctrlSetText "0";
                                 };
                              };

                              _hitPoints = (configFile >> "CfgVehicles" >> (typeOf (vehicle player)) >> "HitPoints") call BIS_fnc_getCfgSubClasses;
                              _maxDamage = count _hitPoints;
                              _hitDamage = 0;
                              _total = 0;
                              {
                                 _hitDamage = _hitDamage + (vehicle player getHitPointDamage _x);
                              } forEach _hitPoints;
                              if not(_hitDamage isEqualTo 0) then
                              {
                                 _total = round(100 - ((_hitDamage / _maxDamage) * 100));
                                 _ctrlVehDamage ctrlSetText format["%1%2", _total, "%"];
                                 switch true do
                                 {
                                    case (_total >= 70):
                                    {
                                       _ctrlVehImageBg ctrlSetBackgroundColor [1,1,1,0.97];
                                       _ctrlVehImage ctrlSetTextColor [0,0,0,0.8];
                                    };
                                    case (_total >= 40):
                                    {
                                       _ctrlVehImageBg ctrlSetBackgroundColor [1,1,1,0.97];
                                       _ctrlVehImage ctrlSetTextColor [1,0.749,0,0.8];
                                    };
                                    case (_total >= 20):
                                    {
                                       _ctrlVehImageBg ctrlSetBackgroundColor [1,1,1,0.97];
                                       _ctrlVehImage ctrlSetTextColor [1,0,0,0.8];
                                    };
                                    case (_total < 20):
                                    {
                                       _ctrlVehImageBg ctrlSetBackgroundColor [1,0,0,0.5];
                                       _ctrlVehImage ctrlSetTextColor [1,0,0,1];
                                    };
                                 };
                              };
                              if (_hitDamage isEqualTo 0) then
                              {
                                 _ctrlVehImageBg ctrlSetBackgroundColor [1,1,1,0.97];
                                 _ctrlVehImage ctrlSetTextColor [0,0,0,0.8];
                                 _ctrlVehDamage ctrlSetText "100%";
                              };
                              if not(alive player) then
                              {
                                 (["RscScarHudCurrentVehicle"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
                                 breakTo "masterLoop";
                              };
                              uiSleep 0.075;
                           } else
                           {
                              if not isNull _dsp then
                              {
                                 (["RscScarHudCurrentVehicle"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
                              };
                              breakTo "inVehicle";
                           };
                        } else
                        {
                           breakOut "vehicleLoop";
                        };
                     };
                     if not(alive player) then
                     {
                        breakTo "masterLoop";
                     };

                     if not isNull(uiNamespace getVariable ["RscScarHudCurrentVehicle", displayNull]) then
                     {
                        (["RscScarHudCurrentVehicle"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
                     };
                     if not(vehicle player isEqualTo player) then
                     {
                        breakTo "inVehicle";
                     } else
                     {
                        uiSleep 0.5;
                        breakTo "masterLoop";
                     };
                  };
               };
            } else
            {
               if (assignedGunner (vehicle player) isEqualTo player) then
               {
                  private ["_dsp"];
                  (["RscScarHudCurrentMuzzle"] call BIS_fnc_rscLayer) cutRsc ["RscScarHudCurrentMuzzle","plain"];
                  _dsp = uiNamespace getVariable ["RscScarHudCurrentMuzzle", displayNull];
                  if not isNull _dsp then
                  {
                     private ["_defineControls","_ctrlWeaponName","_ctrlAmmo","_ctrlZeroing","_ctrlFireMode","_ctrlMagCount"];
                     _defineControls =
                     {
                        _ctrlWeaponName = _dsp displayCtrl 999;
                        _ctrlAmmo = _dsp displayCtrl 1001;
                        _ctrlZeroing = _dsp displayCtrl 1003;
                        _ctrlFireMode = _dsp displayCtrl 1004;
                        _ctrlMagCount = _dsp displayCtrl 1005;
                     };
                     call _defineControls;
                     if (assignedGunner (vehicle player) isEqualTo player) then
                     {
                        while {not(vehicle player isEqualTo player)} do
                        {
                           if not(vehicle player isEqualTo player) then
                           {
                              if (assignedGunner (vehicle player) isEqualTo player) then
                              {
                                 private ["_gun"];
                                 _gun = currentMuzzle player;
                                 if (typeName _gun isEqualTo "STRING") then
                                 {
                                    if isNull _dsp then
                                    {
                                       (["RscScarHudCurrentMuzzle"] call BIS_fnc_rscLayer) cutRsc ["RscScarHudCurrentMuzzle","PLAIN"];
                                       _dsp = uiNamespace getVariable ["RscScarHudCurrentMuzzle", displayNull];
                                       call _defineControls;
                                    };
                                    _ctrlWeaponName ctrlSetText getText(configFile >> "CfgWeapons" >> _gun >> "displayName");
                                    _ammo = player ammo (currentMuzzle player);
                                    _ctrlAmmo ctrlSetText str _ammo;
                                    _magCap = getNumber(configFile >> "CfgMagazines" >> (currentMagazine (vehicle player)) >> "count");
                                    if (_magCap - (_magCap - _ammo) < (_magCap / 6)) then
                                    {
                                       _ctrlAmmo ctrlSetTextColor [0.922,0.224,0.224,1];
                                    } else
                                    {
                                       _ctrlAmmo ctrlSetTextColor (getArray (missionConfigFile >> "RscTitles" >> "RscScarHudCurrentVehicle" >> "RscText" >> "colorText"));
                                    };
                                    _ctrlZeroing ctrlSetText format["%1m", currentZeroing player];
                                    _ctrlFireMode ctrlSetText (currentWeaponMode player);
                                    _magCount = call { _mags = -1; { if(_x isEqualTo (currentMagazine (vehicle player))) then { _mags = _mags + 1 }} forEach (magazines vehicle player); _mags };
                                    _ctrlMagCount ctrlSetText format["%1", if (_magCount > 0) then { format["x%1", _magCount] } else {"+0"}];
                                    if (_magCount < 1) then
                                    {
                                       _ctrlMagCount ctrlSetTextColor [0.922,0.224,0.224,1];
                                    } else
                                    {
                                       _ctrlMagCount ctrlSetTextColor (getArray (missionConfigFile >> "RscTitles" >> "RscScarHudCurrentVehicle" >> "RscText" >> "colorText"));
                                    };
                                    uiSleep 0.075;
                                 };
                                 if not(typeName _gun isEqualTo "STRING") then
                                 {
                                    if not isNull _dsp then
                                    {
                                       (["RscScarHudCurrentMuzzle"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
                                       uiSleep 0.5;
                                    };
                                 };
                              };
                              if not(assignedGunner (vehicle player) isEqualTo player) then
                              {
                                 if not isNull(uiNamespace getVariable ["RscScarHudCurrentMuzzle", displayNull]) then
                                 {
                                    (["RscScarHudCurrentMuzzle"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
                                 };
                                 if not(vehicle player isEqualTo player) then
                                 {
                                    uiSleep 0.5;
                                    breakTo "inVehicle";
                                 } else
                                 {
                                    uiSleep 0.5;
                                    breakTo "masterLoop";
                                 };
                              };
                           };
                        };

                        (["RscScarHudCurrentMuzzle"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
                        breakTo "masterLoop";
                     };
                  };
               } else
               {
                  if not(vehicle player isEqualTo player) then
                  {
                     breakTo "inVehicle";
                  } else
                  {
                     uiSleep 0.5;
                     breakTo "masterLoop";
                  };
               };
            };
         };
      } else
      {
         if not isNull (uiNamespace getVariable ["RscScarHudCurrentMuzzle", displayNull]) then
         {
            (["RscScarHudCurrentMuzzle"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
         };
         if not isNull (uiNamespace getVariable ["RscScarHudCurrentVehicle", displayNull]) then
         {
            (["RscScarHudCurrentVehicle"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
         };
         if not isNull (uiNamespace getVariable ["RscScarHudCurrentWeapon", displayNull]) then
         {
            (["RscScarHudCurrentWeapon"] call BIS_fnc_rscLayer) cutFadeOut 0.1;
         };
         uiSleep 1;
      };
   };
};
