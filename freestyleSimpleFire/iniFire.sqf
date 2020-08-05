//Changed in 0.7.0
//Created in 0.3.0

private["_obj","_radius","_lifetime","_units", "_pos", "_ace", "_damageScript"];

_obj = _this select 0;
_radius = _this select 1;
_lifetime = _this select 2;
_pos = getPos _obj;

_ace = param[3, false];

_damageScript = "freestyleNuke\crater.sqf";
if(_ace) then {_damageScript = "freestyleNuke\aceDamage.sqf"};


//if(isClass(configFile >> "CfgPatches" >> "ace_main")) then { _ace = true;};

[[_obj, _radius, _lifetime],"freestyleSimpleFire\fireFX.sqf"] remoteExec ["execVM",0];


//loop while fire burns
while{_lifetime > 0} do
{
	_obj setDamage ((damage _obj) + (random 10)/1000); //damage burning object
	_units = nearestObjects [_pos ,["Man"], _radius * 3]; //get units to damage
		
	{
		//damage units
		if(isDamageAllowed _x) then 
		{
			if (_ace) then 
			{
				[_x, (random 40)/100, "explosive"] execVM _damageScript;
			}
			else 
			{
				_x setDamage ((damage _x) + (random 50)/100);
			};
			
		};
	} forEach _units;	
	
	sleep 1;
	
	_lifetime = _lifetime - 1; //decrease lifetime
};
