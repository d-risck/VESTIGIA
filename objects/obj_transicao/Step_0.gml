/// @description Insert description here
// You can write your code in this editor
if(mudei)
{
	alpha -= .2;
}
else
{
	alpha += .01;
}

if(alpha >= 1)
{
	room_goto(destino)
}

if(mudei && alpha <=0)
{
	instance_destroy()
}