
private["_light", "_pos", "_obj", "_brigthness","_radius", "_source", "_vSpeed"];

if (!hasInterface) exitWith {};

_pos = _this select 0;
_radius = _this select 1;

_obj = "Sign_Sphere10cm_F" createVehicleLocal _pos;
_brigthness = 100050;




playSound3D ["A3\Sounds_F\sfx\explosion3.wss", _obj,false, _pos,5, 0.3, 0];


_vSpeed = 20;

if (isServer) then {_obj setPos [getPos _obj select 0,getPos _obj select 1,0]; 
_obj setVectorUp [0,0,1]};
_light = "#lightpoint" createVehicleLocal [0,0,0];
_light lightAttachObject [_obj,[0,0,0]];
_light setLightBrightness _brigthness;
_light setLightColor [1,1,1];
_light setLightUseFlare true;
_light setLightFlareSize 100;
_light setLightDayLight true;


_source = "#particlesource" createVehicleLocal [0,0,0];
_source attachTo [_obj,[0,0,0]];



_source setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,2,16,0], "", "Billboard", 1, 1, [0,0,0], [0,0,0], 1.0, 1, 1, 1.0, [_radius,_radius], [[1,1,1,1],[1,0.4,0,1]], [1,1], 1, 0, "", "", _obj, 0.0, true, -1.0, [[1,1,1,1],[1,0.4,0,1]]];

_source setDropInterval 0.1;


sleep 0.1;
while{_brigthness > 150} do {
	_brigthness = _brigthness - 10000;
	_light setLightBrightness _brigthness;
	sleep 0.01;
};


while{_brigthness < 100050} do {
	_brigthness = _brigthness + 2000;
	_light setLightBrightness _brigthness;
	sleep 0.01;
};

while{_brigthness > 50} do {
	_obj setPos [getPos _obj select 0, getPos _obj select 1, (getPos _obj select 2) + 1 ];
	_brigthness = _brigthness - 8000;
	_light setLightBrightness _brigthness;
	sleep 0.03;
};

_light setLightColor [1,0.3,0];
_light setLightDayLight true;

while{_brigthness < 700} do {
	_obj setPos [getPos _obj select 0, getPos _obj select 1, (getPos _obj select 2) + (_vSpeed / 50) ];
	_brigthness = _brigthness + 50;
	_light setLightBrightness _brigthness;
	sleep 0.02;
};

while {((getPosATL _obj) select 2) < _radius * 2} do 
{
	_obj setPosATL [getPosATL _obj select 0, getPosATL _obj select 1, (getPosATL _obj select 2) + (_vSpeed / 10) ];
	//_brigthness = _brigthness + (random [-200, 0, 200]);
	//_light setLightBrightness _brigthness;
	sleep 0.1;
};

deleteVehicle _source;

while{_brigthness > 0} do 
{
		_brigthness = _brigthness + (random [-5, -2, -1]);
		_light setLightBrightness _brigthness;
		sleep 0.1;
};



deleteVehicle _light;
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