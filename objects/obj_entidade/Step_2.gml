/// @description Insert description here
// You can write your code in this editor

// Sistema de colisão e movimentação
var _vel_h = sign(vel_h);
var _vel_v = sign(vel_v);

repeat(abs(vel_h))
{
	if(place_meeting(x + _vel_h, y, obj_block))
	{
		vel_h = 0;
		break;
	}
	x += _vel_h;
}

// Vertical
repeat(abs(vel_v))
{
	if(place_meeting(x, y + _vel_v, obj_block))
	{
		vel_v = 0;
		break;
	}
	y += _vel_v;
}
