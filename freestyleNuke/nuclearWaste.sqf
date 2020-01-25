//Created in 0.2.0


private ["_blastPos","_radius","_allUnits", "_duration", "_t", "_protectUniforms", "_protectGoggles"];

_blastPos = _this select 0;
_radius = _this select 1;
_duration = _this select 2;
_protectUniforms = _this select 3;
_protectGoggles = _this select 4;


while {_duration > 0} do
{
	_allUnits = _blastPos nearObjects ["Man", _radius]; //get affected units
	
	//damage units depending on thier protective gear
	{ 
		if(!((uniform _x) in _protectUniforms) && isDamageAllowed _x) then {_x setDamage [damage _x + 0.04, true];};
		if(!((goggles _x) in _protectGoggles) && isDamageAllowed _x) then {_x setDamage [damage _x + 0.01, true];};
	} forEach _allUnits;
	
	
	_t = random[1,5,10]; //wait random time to next tick
	sleep _t;
	_duration = _duration - _t;
};


