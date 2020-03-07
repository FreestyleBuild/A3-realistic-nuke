//Changed in 0.4.1 Fixed Sounds
//Changed in 0.4.0
//Created in 0.3.0

private["_obj","_radius", "_lifetime", "_color", "_color2", "_flames", "_smoke", "_haze", "_light", "_sound"];

if (!hasInterface) exitWith {};

_obj = "Sign_Sphere10cm_F" createVehicleLocal (getPos (_this select 0));
_radius = _this select 1;
_lifetime = _this select 2;

_obj setPos (_obj modelToWorld [0,0,2]);


//create colors for particles
_r = 255;
_b = 255;
_g = 255;
_a = 100;

_color = [_r / 255, _g / 255, _b / 255, _a / 100];


_r = 250;
_b = 250;
_g = 250;
_a = 100;

_color2 = [_r / 255, _g / 255, _b / 255, _a / 100];




_flames = "#particlesource" createVehicleLocal [0,0,0];
_flames attachTo [_obj,[0,0,0]];

_haze = "#particlesource" createVehicleLocal [0,0,0];
_haze attachTo [_obj,[0,0,1]];

_smoke= "#particlesource" createVehicleLocal [0,0,0];
_smoke attachTo [_obj,[0,0,1.5]];


_flames setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1], "", "Billboard", 1, 5, [0,0,-1.3], [0,0,0.1], 0, 9.996,7.84, 0, [_radius / 1.5,_radius / 1.5], [_color ,_color2 ], [1,1], 1, 0.1, "", "", _obj, 0.0, false, -1.0, [_color ,_color2]];
_flames setParticleRandom [1, [0.5, 0.5, 0], [0.1, 0.1, 0.1], 0, 1, [0, 0, 0, 0], 0, 0];
_flames setParticleCircle [_radius,[0,0,0]];
_flames setDropInterval 0.1;


_haze setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 10, [0,0,0], [0,0,0.8], 30, 9.996,7.84, 0.2, [_radius * 2,_radius * 2], [[1,1,1,0],[1,1,1,1],[1,1,1,0]], [0.1], 1, 0, "", "", _obj, 0.0, false, -1.0, [_color ,_color2]];
_haze setDropInterval 1;


_smoke setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1], "", "Billboard", 1, 35, [0,0,1], [0,0,0], 0.2, 8.9,7.84, 0.4, [5,7], [_color ,[0,0,0,0] ], [0.3], 4, 0.3, "", "", _obj, 0.0, false, -1.0, [_color ,_color2]];
_smoke setParticleCircle [3,[0,0,0]];
_smoke setParticleRandom [5, [0.5, 0.5, 0.5], [0.1, 0.1, 0.1], 0.5, 0, [0, 0, 0, 0], 0.3, 0.1];
_smoke setDropInterval 0.1;


_light = "#lightpoint" createVehicleLocal [0,0,0];
_light lightAttachObject [_obj,[0,0,0]];
_light setLightBrightness 5;
_light setLightColor [0.9,0.4,0];
_light setLightUseFlare true;
_light setLightFlareSize _radius * 3;
_light setLightDayLight true;
_light setLightFlareMaxDistance 100;


//make light flickers randomly
0 = [_light, _radius * 3] spawn{
	private _l = _this select 0;
	private _r = _this select 1;
	private _h = 1;
	while {true} do
	{
		_h = 1 + (random(60) - 30) / 100;
		_l setLightBrightness (5 * _h);
		_l setLightFlareSize (_r * _h);
		sleep 0.07;
	};
};


//add burning sound effects
_sound = selectRandom ["A3\Sounds_F\sfx\fire2_loop.wss", "A3\Sounds_F\sfx\fire3_loop.wss", "A3\Sounds_F\sfx\fire1_loop.wss"];
0 = [_obj, _radius * 12, _sound] spawn
{
	private _o = _this select 0;
	private _r = _this select 1;
	private _s = _this select 2;
	while{!(isNull _o)} do{
	playSound3D [_s, _o,false, getPos _o,3, 0.8, 0];
	sleep 4;
	};
};

//let fire burn for its lifetime
sleep _lifetime;

deleteVehicle _obj;
deleteVehicle _flames;
deleteVehicle _haze;
deleteVehicle _smoke;
deleteVehicle _light;

