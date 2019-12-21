//Created in 0.2.0

private["_ring", "_pos", "_obj","_radius", "_abort", "_lifetime", "_r", "_a", "_b","_g", "_color2"];

if (!hasInterface) exitWith {};

_pos = _this select 0;
_radius = _this select 1;
_lifetime = _this select 2;



_r = 145;
_g = 124;
_b = 61;
_a = 70;

_color = [_r / 255, _g / 255, _b / 255, _a / 100];


_r = 145;
_g = 124;
_b = 61;
_a = 0;

_color2 = [_r / 255, _g / 255, _b / 255, _a / 100];

_obj = "Sign_Sphere10cm_F" createVehicleLocal _pos;
_curRadius = 10;

if (isServer) then {_obj setPos [getPos _obj select 0,getPos _obj select 1,0]; 
_obj setVectorUp [0,0,1]};
_ring = "#particlesource" createVehicleLocal [0,0,0];
_ring attachTo [_obj,[0,0,0]];


_ring setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,0], "", "Billboard", 1, _lifetime, [0,0,0], [0,0,0.1], 0, 9.996,7.84, 0, [40,40], [_color ,_color2 ], [1,1], 1, 0, "", "", _obj, 0.0, true, -1.0, [_color ,_color2]];





_abort = false;

//_ring setDropInterval 0.01;

while {_curRadius <= _radius} do 
{
	_ring setParticleCircle [_curRadius, [0,0,0]];
	_ring setDropInterval 10/(3 * _curRadius);
		
	if(_abort) exitWith{deleteVehicle _ring; deleteVehicle _obj;};
		
	_curRadius = _curRadius + 4;
	if (_curRadius > _radius) then {_curRadius = _radius; _abort = true;};
	sleep 0.1;
};


deleteVehicle _ring;
deleteVehicle _obj;


/*
_light = "lightpoint" createVehicle[0,0,0];
_light setLightAmbient [0.7,0.7,0.8];  
_light setLightColor [0.7,0.7,0.8];
_light setLightIntensity 30;
_light setLightUseFlare true;
_light setLightFlareSize 10;
_light setLightFlareMaxDistance 2000; 
_light setLightAttenuation [200, 1, 100,  0, 50,190];
*/