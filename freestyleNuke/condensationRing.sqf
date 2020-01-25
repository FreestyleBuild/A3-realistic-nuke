//Changed in 0.3.0
//Changed in 0.2.0

private["_ring", "_pos", "_obj","_radius", "_heigth"];

if (!hasInterface) exitWith {};

_pos = _this select 0;
_heigth = _this select 1;
_radius = _this select 2;

_obj = "Sign_Sphere10cm_F" createVehicleLocal [_pos select 0, _pos select 1, (_pos select 2) + _heigth];


if (isServer) then {_obj setPos [getPos _obj select 0,getPos _obj select 1,(_pos select 2) + _heigth]; 
_obj setVectorUp [0,0,1]};
_ring = "#particlesource" createVehicleLocal [0,0,0];
_ring attachTo [_obj,[0,0,0]];


_ring setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1], "", "Billboard", 1, 180, [0,0,0], [0,0,0.1], 0, 9.996,7.84, 0, [10,10], [[1,1,1,1],[1,1,1,0]], [1,1], 1, 0, "", "", _obj, 0.0, false, -1.0, [[1,1,1,1],[1,1,1,0]]];

_ring setParticleCircle [_radius, [0,0,0]]; //create particle circle for the ring

_ring setDropInterval 5/(2 * 3.141 * _radius * 2); //set drop intervall depending on ring circumference

sleep 5;

deleteVehicle _ring;
deleteVehicle _obj;
