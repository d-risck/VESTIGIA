/// @description Insert description here
// You can write your code in this editor

//TREMENDO
view_xport[0] = random_range(-shake, shake);
view_yport[0] = random_range(-shake, shake);

shake *= .9
//Destruindo 
if(shake <= .2)
{
	instance_destroy();
}