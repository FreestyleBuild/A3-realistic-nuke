//Changed in 0.2.0
//Changed in 0.1.1


private ["_blastPos","_radius5", "_rad20psi","_allBuildings", "_allTrees", "_allVehicles", "_allUnits"];
private ["_curRadius5", "_h", "_curDamage5","_mark20psi", "_abort", "_house"];


//hint str "Airblast 5 psi";

_blastPos = _this select 0;
_radius5 = _this select 1;
_rad20psi = _this select 2;
_curRadius5 = 40 + _rad20psi;


/*
_mark5psi = createMarker ["5 psi Airblast", _blastPos];
_mark5psi setMarkerColor "ColorYellow";
_mark5psi setMarkerShape "ELLIPSE";
_mark5psi setMarkerSize [_radius5, _radius5];
_mark5psi setMarkerText "5 psi Airblast";*/



if (_curRadius5 > _radius5) then {_curRadius5 = _radius5;};
_abort = false;


_allTrees = nearestTerrainObjects [_blastPos, ["SMALL TREE", "BUSH"], _radius5];
//_allBuildings = nearestTerrainObjects [_blastPos, [], _curRadius5];
_allBuildings = nearestObjects [_blastPos ,["Building"], _radius5];
_allVehicles = nearestObjects [_blastPos ,["LandVehicles", "Air", "Ship"], _radius5];
_allUnits = nearestObjects [_blastPos ,["Man"], _radius5];

while{_curRadius5 <= _radius5} do {

/*_h = (_curRadius5 - _rad20psi) / (_radius5 - _rad20psi) + 0.8;
_curDamage5 = 1 / (2* _h * _h) + 0.25;*/

_h = (_radius5 - _curRadius5) / (_radius5 - _rad20psi);
_curDamage5 = -0.5 * ((-1 * _h + 1)  ^ 0.2) + 1;



if (_curDamage5 > 1) then {_curDamage5 = 1;}; 



{ _x hideObject true;} forEach _allTrees;

{
_h = (getPos _x) distance _blastPos; 
if (_h >= (_curRadius5 - 40) && _h <= _curRadius5) then {_x setDamage[(random 15) / 100 + _curDamage5 * 1.5 + damage _x, false]; };
} forEach _allBuildings;

{
_h = (getPos _x) distance _blastPos; 
if (_h >= (_curRadius5 - 40) && _h <= _curRadius5) then {_x setDamage[0.9 * _curDamage5 + damage _x, true]; };
} forEach _allVehicles;

{ 
_h = (getPos _x) distance _blastPos; 
if (_h >= (_curRadius5 - 40) && _h <= _curRadius5 && isDamageAllowed _x) then {
_x setDamage[(random 30) / 100 + _curDamage5 * 1.5 + damage _x, true];
//if(!(_x call KK_fnc_inHouse)) then {};
//if(_x call KK_fnc_inHouse) then {_x setDamage[_curDamage5 * 0.01 + damage _x, true];};
 };
} forEach _allUnits;


if(_abort) exitWith{};

_curRadius5 = _curRadius5 + 40;
if (_curRadius5 > _radius5) then {_curRadius5 = _radius5; _abort = true;};
sleep 0.1;

}; 

//hint str "DONE";
