/// @description Insert description here
// You can write your code in this editor

//Olhando pro lado correto
if(vel_h != 0) xscale = sign(vel_h);
image_xscale = xscale;

//exibindo meu estado quando eu quiser
if(position_meeting(mouse_x, mouse_y, id)) 
{
	if(mouse_check_button_released(mb_left))
	{
	mostra_estado = !mostra_estado;
	}
}

image_speed = (img_spd/room_speed) * global.vel_mult;