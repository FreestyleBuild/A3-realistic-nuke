//Changed in 0.7.0
//Changed in 0.2.0


private ["_blastPos","_radius5000rem", "_allUnits", "_mark5000rem", "_h"];


_blastPos = _this select 0;
_radius5000rem = _this select 1;
_ace = param[2, false];



_damageScript = "freestyleNuke\crater.sqf";
if(_ace) then {_damageScript = "freestyleNuke\aceDamage.sqf"};




if (_radius5000rem == -1) exitWith{};


/*
//Debug Only
_mark5000rem = createMarker ["5000 rem Radiation", _blastPos];
_mark5000rem setMarkerColor "ColorGUER";
_mark5000rem setMarkerShape "ELLIPSE";
_mark5000rem setMarkerSize [_radius5000rem, _radius5000rem];
_mark5000rem setMarkerText "5000 rem Radiation";
*/


_allUnits = _blastPos nearObjects ["Man", _radius5000rem];


{ 
_h = [objNull, "GEOM"] checkVisibility [_blastPos, getPosASL _x];
if ( (_h >= 0.5) && isDamageAllowed _x) then 
{
	if (_ace) then 
	{
		[_x, 30, "ropeburn"] execVM _damageScript;
	}
	else 
	{
		_x setDamage[1, true];
	};	
};

} forEach _allUnits;




