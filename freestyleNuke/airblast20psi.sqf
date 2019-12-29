//Changed in 0.2.1
//Changed in 0.2.0


private ["_blastPos","_radius20", "_allBuildings", "_allTrees", "_allVehicles", "_allUnits", "_curRadius20", "_mark20psi", "_abort"];

//hint str "Airblast 20 psi";

_blastPos = _this select 0;
_radius20 = _this select 1;
_curRadius20 = 40;


/*
_mark20psi = createMarker ["20 psi Airblast", _blastPos];
_mark20psi setMarkerColor "ColorRed";
_mark20psi setMarkerShape "ELLIPSE";
_mark20psi setMarkerSize [_radius20, _radius20];
_mark20psi setMarkerText "20 psi Airblast";
*/


if (_curRadius20 > _radius20) then {_curRadius20 = _radius20;};
_abort = false;

_allTrees = nearestTerrainObjects [_blastPos, ["TREE", "SMALL TREE", "BUSH", "FOREST","FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE"], _radius20];
_allBuildings = nearestTerrainObjects [_blastPos, ["BUILDING", "HOUSE", "CHURCH", "CHAPEL", "CROSS", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "FENCE", "WALL", "HIDE", "BUSSTOP", "ROAD", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "TRACK", "MAIN ROAD", "POWER LINES", "RAILWAY", "POWERSOLAR", "POWERWAVE", "POWERWIND", "SHIPWRECK"], _radius20];
//_allBuildings = _blastPos nearObjects ["Building", _radius20];
_allVehicles = _blastPos nearObjects ["AllVehicles", _radius20];
//_allUnits = _blastPos nearObjects ["Man", _radius20];

while{_curRadius20 <= _radius20} do {


{ _x hideObject true;} forEach _allTrees;

{
_h = (getPos _x) distance _blastPos; 
if (_h > (_curRadius20 - 40) && _h <= _curRadius20) then {_x setDamage[1, false]; };
} forEach _allBuildings;


//{ _x setDamage[1, false]; } forEach _allBuildings;
//{ _x setDamage[1, false]; } forEach _allVehicles;
{
_h = (getPos _x) distance _blastPos;  if(_h >= (_curRadius20 - 40) && _h <= _curRadius20 && isDamageAllowed _x) then {

	_xVel = -(_blastPos select 0) + ((getPos _x) select 0);
	_yVel = -(_blastPos select 1) + ((getPos _x) select 1); 
	_xVel = _xVel / ((_xVel ^ 2 + _yVel ^ 2) ^ 0.5);
	_yVel = _yVel / ((_xVel ^ 2 + _yVel ^ 2) ^ 0.5);
	_mass = getMass _x;
	_mass = _mass / 2;
	if(_mass == 0) then {_mass = 100;};
	
	_x setVectorDir vectorNormalized ([(vectorDir _x) select 0, (vectorDir _x) select 1, 0] vectorDiff ([_xVel, _yVel, 0] vectorMultiply ([_xVel, _yVel, 0] vectorDotProduct [(vectorDir _x) select 0, (vectorDir _x) select 1, 0])));

	_x setVelocity [_xVel * 10000 / _mass, _yVel * 10000 / _mass, 3];

	
	
	
	
	0 = [_x, [_xVel, _yVel,0]] spawn {
		sleep 0.5;
		(_this select 0) setVectorDirAndUp [vectorDir (_this select 0),(_this select 1)];
	};
	_x setDamage[1, false]; 
};
} forEach _allVehicles;


if(_abort) exitWith{};

_curRadius20 = _curRadius20 + 40;
if (_curRadius20 > _radius20) then {_curRadius20 = _radius20; _abort = true;};
sleep 0.1;

}; 


