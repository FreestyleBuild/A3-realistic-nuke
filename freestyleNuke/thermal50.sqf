//Changed in 0.7.0
//Changed in 0.2.0


private ["_blastPos","_radius50thermal", "_allUnits", "_mark50thermal", "_h"];


_blastPos = _this select 0;
_radius50thermal = _this select 1;





if (_radius50thermal == -1) exitWith{};
_ace = param[2, false];





_damageScript = "freestyleNuke\crater.sqf";
if(_ace) then {_damageScript = "freestyleNuke\aceDamage.sqf"};

/*
//Debug Only
_mark50thermal = createMarker ["50% 3rd Degree burns", _blastPos];
_mark50thermal setMarkerColor "ColorRed";
_mark50thermal setMarkerShape "ELLIPSE";
_mark50thermal setMarkerSize [_radius50thermal, _radius50thermal];
_mark50thermal setMarkerText "50% 3rd Degree burns";
*/


_allUnits = _blastPos nearObjects ["Man", _radius50thermal];


{ 
_h = [objNull, "GEOM"] checkVisibility [getPosASL _x, _blastPos];
if ( _h >= 0.5 && isDamageAllowed _x) then 
{
	if (_ace) then 
	{
		[_x, 0.05, "ropeburn"] execVM _damageScript;
	}
	else 
	{
		_x setDamage[damage _x + 0.05, true];
	};	
};

} forEach _allUnits;




