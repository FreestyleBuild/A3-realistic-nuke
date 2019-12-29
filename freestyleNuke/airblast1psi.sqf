//Changed in 0.2.1
//Changed in 0.2.0


private ["_blastPos","_radius1", "_rad5psi","_allBuildings", "_allTrees", "_allVehicles", "_allUnits"];
private ["_curRadius1", "_h", "_curDamage1", "_abort"];
//Changed in 0.1.1

//hint str "Airblast 1 psi";

_blastPos = _this select 0;
_radius1 = _this select 1;
_rad5psi = _this select 2;
_curRadius1 = 40 + _rad5psi;


/*
_mark1psi = createMarker ["1 psi Airblast", _blastPos];
_mark1psi setMarkerColor "ColorGrey";
_mark1psi setMarkerShape "ELLIPSE";
_mark1psi setMarkerSize [_radius1, _radius1];
_mark1psi setMarkerText "1 psi Airblast";
*/


if (_curRadius1 > _radius1) then {_curRadius1 = _radius1;};
_abort = false;

//_allTrees = nearestTerrainObjects [_blastPos, ["SMALL TREE", "BUSH"], _radius1];
//_allBuildings = nearestTerrainObjects [_blastPos, [], _curRadius1];
_allBuildings = nearestObjects [_blastPos ,["Building"], _radius1];
_allVehicles = nearestObjects [_blastPos ,["LandVehicles", "Air", "Ship"], _radius1];
_allUnits = nearestObjects [_blastPos ,["Man"], _radius1];

while{_curRadius1 <= _radius1} do {

//_h = (_curRadius1 - _rad5psi) / (_radius1 - _rad5psi);
_h = (_radius1 - _curRadius1) / (_radius1 - _rad5psi);
_curDamage1 = 0.5 * (_h  ^ 0.2);



if (_curDamage1 < 0.1) then {_curDamage1 = 0.1;}; 

if (_curDamage1 > 1) then {_curDamage1 = 1;}; 


//{ _x setDamage 1;} forEach _allTrees;

{
_h = (getPos _x) distance _blastPos; 
if (_h > ((_curRadius1 - 40) max _rad5psi) && _h <= _curRadius1) then {_x setDamage[_curDamage1 * 1.5 + damage _x, false]; };
} forEach _allBuildings;

{
_h = (getPos _x) distance _blastPos; 
if (_h > ((_curRadius1 - 40) max _rad5psi) && _h <= _curRadius1) then {_x setDamage[_curDamage1 + damage _x, true]; };
} forEach _allVehicles;

{ 
_h = (getPos _x) distance _blastPos; 
if (_h > ((_curRadius1 - 40) max _rad5psi) && _h <= _curRadius1 && isDamageAllowed _x) then 
{
	if (stance _x == "PRONE") then {_x setDamage[(_curDamage1 / 1.5) + damage _x, true];} else {_x setDamage[_curDamage1 + damage _x, true];}; 
};
} forEach _allUnits;


if(_abort) exitWith{};

_curRadius1 = _curRadius1 + 40;
if (_curRadius1 > _radius1) then {_curRadius1 = _radius1; _abort = true;};
sleep 0.1;

}; 

//hint str "DONE";
