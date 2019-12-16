


private ["_blastPos","_radius500rem", "_allUnits", "_mark500rem", "_h"];


_blastPos = _this select 0;
_radius500rem = _this select 1;

if (_radius500rem == -1) exitWith{};

/*

_mark500rem = createMarker ["500 rem Radiation", _blastPos];
_mark500rem setMarkerColor "ColorGreen";
_mark500rem setMarkerShape "ELLIPSE";
_mark500rem setMarkerSize [_radius500rem, _radius500rem];
_mark500rem setMarkerText "500 rem Radiation";

*/





_allUnits = _blastPos nearObjects ["Man", _radius500rem];


{ 
_h = [objNull, "GEOM"] checkVisibility [_blastPos, getPosASL _x];
_x setDamage[_h + damage _x + 0.3, true];

} forEach _allUnits;




