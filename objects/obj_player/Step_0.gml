if(instance_exists(obj_transicao)) exit;

if(invencivel && tempo_invencivel > 0)
{
	tempo_invencivel--;
	image_alpha = max(sin(get_timer()/100000),0.2);
}
else
{
	invencivel = false;
	image_alpha = 1;
}

var right, left, jump, attack;
var chao = place_meeting(x, y + 1, obj_block);
right = keyboard_check(ord("D"));
left = keyboard_check(ord("A"));
jump = keyboard_check(vk_space);
attack = keyboard_check(ord("K")) || keyboard_check(vk_left);
var pause = keyboard_check(vk_escape);
var restart = keyboard_check(ord("R"));

if(restart)
{
	room_restart();	
	
}

if(ataque_buff < 0) ataque_buff-=2;

if(!chao) 
{
	if(vel_v < max_vel_v * 2)
	{
		vel_v += GRAVIDADE * massa * global.vel_mult;
	}
}

vel_h = (right-left) * max_vel_h * global.vel_mult;

switch(estado)
{
 	#region parado
	case "parado" :
	{		
		sprite_index = spr_player_parado;

		if(vel_h != 0)
		{
			estado = "movendo";
		}
		
		else if(jump)
		{
			estado = "pulando";
			vel_v = -max_vel_v;
			image_index = 0;
		}
		
		else if(attack)
		{
			inicia_ataque()
		}
		break;
	}
	#endregion
	
	#region movendo
	case "movendo" :
	{
		sprite_index = spr_player_movendo;
		if (!audio_is_playing(snd_steps)) {
			 audio_play_sound(snd_steps, 2, false); // false = não loopa automaticamente
		}
		
		if(abs(vel_h) < .1)
		{
			estado = "parado";
			vel_h = 0;
			audio_stop_sound(snd_steps);
		}
		
		else if(jump)
		{
			estado = "pulando";
			vel_v = -max_vel_v;
			image_index = 0;
		}
		
		else if(attack)
		{
		   inicia_ataque()
		}
		break;
	}
	#endregion
	
	#region pulando
	case "pulando" :
	{
		if(vel_v > .1)
		{
			sprite_index = spr_player_caindo;
		}
		
		else 
		{
			sprite_index = spr_player_pulando;
			if(image_index >= image_number-1)
			{
				image_index = image_number-1;
			}
		}
		
		if(chao)
		{
			estado = "parado";
			vel_h = 0;
		}
		break;
	}
	#endregion
	
	#region hit
	case"hit" :
	{
		if(sprite_index != spr_player_levando_dano)
		{
			sprite_index = spr_player_levando_dano;
			image_index = 0;
			screenshake(4);
			
			invencivel = true;
			tempo_invencivel = invencivel_timer
		}
		 
		vel_h = 0;
		 
		if(vida_atual > 0)
		{
			if(image_index > image_number - 1)
			{
				estado = "parado";
			}
		 }
		else 
		{
			if(image_index > image_number - 1)
			{
				estado = "morto"
			}
		}
		break;
	}
	#endregion
	
	#region morto
	case "morto":
	{		
		if(instance_exists(obj_game_controller))
		{
			with(obj_game_controller)
			{
				game_over = true;
			}
		}
		
		vel_h = 0;
		
		if(sprite_index != spr_player_morrendo)
		{
			image_index = 0;
			sprite_index = spr_player_morrendo;
		}
		
		if(image_index >= image_number - 1)
		{
			image_index = image_number - 1;
		}		
		break;
	}
	#endregion
	
	#region ataque
	case "ataque" :
	{
		vel_h = 0;
		
		if(combo == 0)
		{
			sprite_index = spr_player_atacando1;
		}
		
		else if(combo == 1)
		{
			sprite_index = spr_player_atacando2;
		}
		
		if(image_index >= 2 && dano == noone && posso)
		{
			dano = instance_create_layer(x + sprite_width/4,y - sprite_height/4,layer, obj_dano)
			dano.dano = ataque;
			dano.pai = id;
			posso = false;
		}
		
		if(attack && combo < 2)
		{
			ataque_buff = room_speed;
		}

		if(ataque_buff && combo < 2 && image_index >= image_number-1)
		{
			combo ++;
			image_index = 0;
			posso = true;
		}
		
		ataque_buff = 0;
		
		if(image_index > image_number-1)
		{
			estado = "parado";
			vel_h = 0;
			combo = 0;
			posso = true;
			if(dano)
			{
				instance_destroy(dano, false);
				dano = noone;
			}
		}		
		break;	
	}
	#endregion
	
	default:
	{
		estado = "parado"
	}
}

show_debug_message(tempo_invencivel);

