//Changed in 0.2.0


private ["_blastPos","_radius100thermal", "_allUnits", "_mark100thermal", "_h"];


_blastPos = _this select 0;
_radius100thermal = _this select 1;

if (_radius100thermal == -1) exitWith{};


/*
//Debug Only
_mark100thermal = createMarker ["100% 3rd Degree burns", _blastPos];
_mark100thermal setMarkerColor "ColorOrange";
_mark100thermal setMarkerShape "ELLIPSE";
_mark100thermal setMarkerSize [_radius100thermal, _radius100thermal];
_mark100thermal setMarkerText "100% 3rd Degree burns";

*/



_allUnits = _blastPos nearObjects ["Man", _radius100thermal];


{ 
_h = [objNull, "GEOM"] checkVisibility [getPosASL _x, _blastPos];
if ( _h >= 0.5 && isDamageAllowed _x) then {_x setDamage[damage _x + 0.1, true];};

} forEach _allUnits;




