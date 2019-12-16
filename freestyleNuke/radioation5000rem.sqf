


private ["_blastPos","_radius5000rem", "_allUnits", "_mark5000rem", "_h"];


_blastPos = _this select 0;
_radius5000rem = _this select 1;

if (_radius5000rem == -1) exitWith{};


/*
_mark5000rem = createMarker ["5000 rem Radiation", _blastPos];
_mark5000rem setMarkerColor "ColorGUER";
_mark5000rem setMarkerShape "ELLIPSE";
_mark5000rem setMarkerSize [_radius5000rem, _radius5000rem];
_mark5000rem setMarkerText "5000 rem Radiation";*/







_allUnits = _blastPos nearObjects ["Man", _radius5000rem];


{ 
_h = [objNull, "GEOM"] checkVisibility [_blastPos, getPosASL _x];
if ( _h >= 0.5) then {_x setDamage[1, true];};

} forEach _allUnits;




