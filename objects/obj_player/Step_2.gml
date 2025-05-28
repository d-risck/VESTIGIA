/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var _vel_h = sign(vel_h);
var _vel_v = sign(vel_v);


if(place_meeting(x + _vel_h, y, obj_bloco_morte))
{
	vel_h = 0;
	estado = "morto"
	vida_atual = 0;
}

if(place_meeting(x, y + _vel_v, obj_bloco_morte))
{
	estado = "morto"
	vida_atual = 0;
}