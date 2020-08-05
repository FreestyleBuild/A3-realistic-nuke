//Created in 0.7.0

params["_unit", "_damage", "_type"];

/*
_unit: Unit to apply damage to
_damage: Amount of damage to apply
_type: Type of applied damage, one of Ace damageTypes

*/

if (_damage > 10) exitWith
{
	{
		[_unit, 1, _x, _type] call ace_medical_fnc_addDamageToUnit;
	} forEach ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
};


if (_damage <= 0.1) exitWith
{
	[_unit, _damage, "Body", _type] call ace_medical_fnc_addDamageToUnit;

};

{
	_t = random (_damage min 1);
	if (_t < 0.1) then {_t = 0.1};
	[_unit, _t, _x, _type] call ace_medical_fnc_addDamageToUnit;
	_damage = _damage - _t;
	if(_damage <= 0) exitWith{};
} forEach ["Body", "Head", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];


[_unit, _damage, "Body", _type] call ace_medical_fnc_addDamageToUnit;