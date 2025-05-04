/// @description Insert description here
// You can write your code in this editor

randomize();

// Inherit the parent event
event_inherited();

vida_max = 4;
vida_atual = vida_max;

max_vel_h = 2.5;
max_vel_v = 5.8;

mostra_estado = false;

combo = 0;
img_spd = 30;

dano = noone;
posso = true;
ataque_buff = room_speed;

invencivel = false;
invencivel_timer = room_speed * 2;
tempo_invencivel = invencivel_timer;

inicia_ataque = function()
{
	estado = "ataque";
	vel_h = 0;
	image_index = 0;
}



