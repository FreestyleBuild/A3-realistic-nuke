//Changed in 0.2.0


private["_wave", "_pos", "_obj","_radius", "_curRadius", "_abort"];

sleep 1;

if (!hasInterface) exitWith {};

_pos = _this select 0;
_radius = _this select 1;

_abort = false;

_curRadius = 4;

_obj = "Sign_Sphere10cm_F" createVehicleLocal _pos;

if (isServer) then 
{
_obj setPos [getPos _obj select 0 ,getPos _obj select 1, 0]; 
_obj setVectorUp [0,0,1];
};
_wave = "#particlesource" createVehicleLocal [0,0,0];
_wave attachTo [_obj,[0,0,0]];



_wave setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1], "", "Billboard", 1, 0.5, [0,0,0], [0,0,0], 0, 9.996,7.84, 0, [40,30], [[0,0,0,1],[0,0,0,1]], [1,1], 1, 0, "", "", _obj, 0.0, true, -1.0, [[0,0,0,1],[0,0,0,1]]];


while {_curRadius <= _radius} do 
{
	//_wave setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1], "", "Billboard", 1, 1, [0,0,0], [0,0,0], 0, 9.996,7.84, 0, [40,30], [[0,0,0,1],[0,0,0,1]], [1,1], 1, 0, "", "", _obj, 0.0, true, -1.0, [[0,0,0,1],[0,0,0,1]]];
	_wave setParticleCircle [_curRadius, [0,0,0]];

	_wave setDropInterval 1/(2 * 3.141 * _curRadius * 1.3);
	//_wave setDropInterval 0.001;
		
	if(_abort) exitWith{deleteVehicle _wave; deleteVehicle _obj;};
		
	_curRadius = _curRadius + 4;
	if (_curRadius > _radius) then {_curRadius = _radius; _abort = true;};
	sleep 0.01;
};

deleteVehicle _wave;
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