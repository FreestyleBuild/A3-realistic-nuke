//Version 0.1.1


private["_blastPos", "_20psi", "_5psi", "_1psi", "_y", "_radFireball", "_rad1psi", "_rad5psi", "_rad20psi", "_rad500rem", "_rad5000rem", "_rad100thermal", "_rad50thermal", "_int", "_jam", "_debug", "_damage"];
//hint str "NUKED";

_blastPos = _this select 0;
_y = _this select 1;
_debug = _this select 2;
_damage = _this select 3;

_radFireball = (_y ^ 0.39991) * 79.30731 - 0.33774;
_rad1psi = (_y ^ 0.33308) * 1179.03371;
_rad5psi = (_y ^ 0.33325) * 458.29634;
_rad20psi = (_y ^ 0.33355) * 216.89585 + (_y ^ 0.1798) * 1.17158;
_rad500rem = (_y ^ 0.16353) * 228.38886 + (_y ^ 3) * 7.86898e-8 - 0.00175 * (_y ^ 2) + (_y ^ 0.16353) * 625.25398;
_rad5000rem = (_y ^ 0.21107) * 424.37067 + (_y ^ 3) * 2.40299e-6 - 0.00175 * (_y ^ 2) + (_y ^ 0.21107) * 85.15598;
_rad100thermal = (_y ^ 0.43788) * 517.81986 + (_y ^ 3) * 3.17366e-11 - (_y ^ 2) * 4.76245e-6 + (_y ^ (-1.11864)) * 3.50645;
_rad50thermal = (_y ^ 0.9993) * 283.0527 + (_y ^ 5) * 9.10689e-22 + (_y ^ 0.41672) * 598.33159 - 280.91567 * _y;

if (_y >= 550) then {_rad5000rem = -1;};
if (_y >= 2000) then {_rad500rem = -1;};



if (_debug) then {
	_mark1psi = createMarker ["1 psi Airblast", _blastPos];
	_mark1psi setMarkerColor "ColorGrey";
	_mark1psi setMarkerShape "ELLIPSE";
	_mark1psi setMarkerSize [_rad1psi, _rad1psi];
	_mark1psi setMarkerText "1 psi Airblast";

	_mark5psi = createMarker ["5 psi Airblast", _blastPos];
	_mark5psi setMarkerColor "ColorYellow";
	_mark5psi setMarkerShape "ELLIPSE";
	_mark5psi setMarkerSize [_rad5psi, _rad5psi];
	_mark5psi setMarkerText "5 psi Airblast";

	_mark20psi = createMarker ["20 psi Airblast", _blastPos];
	_mark20psi setMarkerColor "ColorRed";
	_mark20psi setMarkerShape "ELLIPSE";
	_mark20psi setMarkerSize [_rad20psi, _rad20psi];
	_mark20psi setMarkerText "20 psi Airblast";
};

_radFireball = _radFireball * 0.4;

[[_blastPos, _radFireball],"freestyleNuke\flash.sqf"] remoteExec ["execVM",0];
[[_blastPos, 0.7 * _radFireball,_radFireball * 6,_radFireball * 8.5],"freestyleNuke\mushroomcloud.sqf"] remoteExec ["execVM",0];
[[_blastPos, _rad1psi],"freestyleNuke\blastwave.sqf"] remoteExec ["execVM",0];



[_blastPos, _y, _radFireball] execVM "freestyleNuke\iniCondensationRings.sqf";




if (_damage) then {
	_5000rem = [_blastPos, _rad5000rem] execVM "freestyleNuke\radioation5000rem.sqf";
	_500rem = [_blastPos, _rad500rem] execVM "freestyleNuke\radioation5000rem.sqf";
	_100thermal = [_blastPos, _rad100thermal] execVM "freestyleNuke\thermal100.sqf";
	_50thermal = [_blastPos, _rad50thermal] execVM "freestyleNuke\thermal50.sqf";

	_20psi = [_blastPos, _rad20psi] execVM "freestyleNuke\airblast20psi.sqf";
	waitUntil { scriptDone _20psi };

	_5psi = [_blastPos, _rad5psi,_rad20psi] execVM "freestyleNuke\airblast5psi.sqf";
	waitUntil { scriptDone _5psi };

	_1psi = [_blastPos, _rad1psi,_rad5psi] execVM "freestyleNuke\airblast1psi.sqf";
	waitUntil { scriptDone _1psi };


	_jam = [_blastPos, _rad1psi] execVM "freestyleNuke\jamming.sqf";
}

//hint str "NUKE DONE";
