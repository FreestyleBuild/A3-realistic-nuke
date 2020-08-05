//Chnaged in 0.7.0
//Changed in 0.6.0
//Changed in 0.4.1
//Changed in 0.4.0
//Changed in 0.3.0
//Changed in 0.2.1
//Changed in 0.2.0


private ["_blastPos","_radius20", "_allBuildings", "_allTrees", "_allVehicles", "_allUnits", "_curRadius20", "_mark20psi", "_abort", "_hideRadius", "_o"];

/*sleep 5;
private _start = diag_tickTime;*/

_blastPos = _this select 0;
_radius20 = _this select 1;
_hideRadius = _this select 2;
_curRadius20 = 40;
_ace = param[3, false];



_damageScript = "freestyleNuke\crater.sqf";
if(_ace) then {_damageScript = "freestyleNuke\aceDamage.sqf"};


if (_curRadius20 > _radius20) then {_curRadius20 = _radius20;};
_abort = false;

//get affected objects
_allTrees = nearestTerrainObjects [_blastPos, ["TREE", "SMALL TREE", "BUSH", "FOREST","FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE"], _radius20];
_allBuildings = nearestObjects [_blastPos ,["Building"], _radius20];
//_allBuildings = nearestTerrainObjects [_blastPos, ["BUILDING", "HOUSE", "CHURCH", "CHAPEL", "CROSS", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "FENCE", "WALL", "HIDE", "BUSSTOP", "ROAD", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "TRACK", "MAIN ROAD", "POWER LINES", "RAILWAY", "POWERSOLAR", "POWERWAVE", "POWERWIND", "SHIPWRECK"], _radius20];
//_allVehicles = nearestObjects [_blastPos, ["AllVehicles"], _radius20];
_allVehicles = _blastPos nearObjects ["AllVehicles", _radius20];
_craterHidden = nearestTerrainObjects [_blastPos, [], _hideRadius];

private _maxB = count _allBuildings;


{if(isDamageAllowed _x) then { _x hideObjectGlobal true;};} forEach _allTrees;
{if(isDamageAllowed _x) then { _x setDamage[1, false]; _x hideObjectGlobal true;};} forEach _craterHidden;

//iterate from the center and damage the affected objects
while{_curRadius20 <= _radius20} do {



private _c = 0;



while {(((getPos (_allBuildings # _c)) distance _blastPos) < (_curRadius20 - 80)) && (_c < _maxB)} do {_c = _c + 1;};

while {((((getPos (_allBuildings # _c)) distance _blastPos) - 40) <= _curRadius20) && (_c < _maxB)} do
{
	_o = _allBuildings # _c;


	//hide objects for crater generation
	_h = (getPos _o) distance _blastPos; 
	if (_h > (_curRadius20 - 40) && _h <= _curRadius20 && _h <= _hideRadius && isDamageAllowed _o) then {_o hideObjectGlobal true;};
	if (_h > (_curRadius20 - 40) && _h <= _curRadius20 && _h > _hideRadius && isDamageAllowed _o) then {_o setDamage[1, false]; };
	_c = _c + 1;
};


{
	_h = (getPos _x) distance _blastPos;
	if(_h >= (_curRadius20 - 40) && _h <= _curRadius20 && isDamageAllowed _x) then {

		_xVel = -(_blastPos select 0) + ((getPos _x) select 0);
		_yVel = -(_blastPos select 1) + ((getPos _x) select 1); 
		_xVel = _xVel / ((_xVel ^ 2 + _yVel ^ 2) ^ 0.5);
		_yVel = _yVel / ((_xVel ^ 2 + _yVel ^ 2) ^ 0.5);
		_mass = getMass _x;
		_mass = _mass / 2;
		if(_mass == 0) then {_mass = 40;};
		
		_x setVectorDir vectorNormalized ([(vectorDir _x) select 0, (vectorDir _x) select 1, 0] vectorDiff ([_xVel, _yVel, 0] vectorMultiply ([_xVel, _yVel, 0] vectorDotProduct [(vectorDir _x) select 0, (vectorDir _x) select 1, 0])));

		_x setVelocity [_xVel * 10000 / _mass, _yVel * 10000 / _mass, 3];

		
		
		
		
		0 = [_x, [_xVel, _yVel,0]] spawn {
			sleep 0.5;
			(_this select 0) setVectorDirAndUp [vectorDir (_this select 0),(_this select 1)];
		};
		
		if(_x isKindOf "Man") then 
		{
			if (_ace) then 
			{
				[_x, 30, "explosive"] execVM _damageScript;
			}
			else 
			{
				_x setDamage[1, false];
			};
		}
		else
		{
			_x setDamage[1, false];

			{
				if (_ace) then 
				{
					[_x, 30, "explosive"] execVM _damageScript;
				}
				else 
				{
					_x setDamage[1, false];
				};
			} forEach crew _x;	
		};
	};
} forEach _allVehicles;


/*
while {(((getPos (_allVehicles # _c)) distance _blastPos) < (_curRadius20 - 80)) && (_c < _maxV)} do {_c = _c + 1;};

while {((((getPos (_allVehicles # _c)) distance _blastPos) - 40) <= _curRadius20) && (_c < _maxV)} do {

	_o = _allVehicles # _c;
	_h = (getPos _o) distance _blastPos;  if(_h >= (_curRadius20 - 40) && _h <= _curRadius20 && isDamageAllowed _o) then {

	_xVel = -(_blastPos select 0) + ((getPos _o) select 0);
	_yVel = -(_blastPos select 1) + ((getPos _o) select 1); 
	_xVel = _xVel / ((_xVel ^ 2 + _yVel ^ 2) ^ 0.5);
	_yVel = _yVel / ((_xVel ^ 2 + _yVel ^ 2) ^ 0.5);
	_mass = getMass _o;
	_mass = _mass / 2;
	if(_mass == 0) then {_mass = 40;};
	
	_o setVectorDir vectorNormalized ([(vectorDir _o) select 0, (vectorDir _o) select 1, 0] vectorDiff ([_xVel, _yVel, 0] vectorMultiply ([_xVel, _yVel, 0] vectorDotProduct [(vectorDir _o) select 0, (vectorDir _o) select 1, 0])));

	_o setVelocity [_xVel * 10000 / _mass, _yVel * 10000 / _mass, 3];

	
	
	
	
	0 = [_o, [_xVel, _yVel,0]] spawn {
		sleep 0.5;
		(_this select 0) setVectorDirAndUp [vectorDir (_this select 0),(_this select 1)];
	};
	_o setDamage[1, false];
};
	_c = _c + 1;
};*/


if(_abort) exitWith{/*hint str(diag_tickTime - _start);*/};

_curRadius20 = _curRadius20 + 40;
if (_curRadius20 > _radius20) then {_curRadius20 = _radius20; _abort = true;};
sleep 0.1;

}; 


//hint str(diag_tickTime - _start);

