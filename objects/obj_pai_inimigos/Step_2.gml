/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var _vel_h = sign(vel_h);

if(place_meeting(x + _vel_h, y, obj_block2))
{	
	if(vel_h = 1)
	{
		vel_h = -1;
	}
	else
	{
		vel_h = 1;
	}
}
