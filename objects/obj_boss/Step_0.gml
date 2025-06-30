/// @description Código de comportamento do Boss (Revisado)

if(global.pause) exit;

var chao = place_meeting(x, y + 1, obj_bloco);

if(!chao) 
{
	vel_v += GRAVIDADE * massa * global.vel_mult;
}

switch(estado)
{
	case "parado":
	{
		if(sprite_index != spr_boss_idle)
		{
			sprite_index = spr_boss_idle;
			image_index = 0;
		}

		if(instance_exists(obj_player))
		{
			var _dist = point_distance(x,y,obj_player.x, obj_player.y);
			if(_dist < 300)
			{
				estado = "andando";
			}
		}
		break;
	}

	case "andando":
	{
		if (!audio_is_playing(snd_boss_passos)) {
			audio_play_sound(snd_boss_passos, 10, false);
		}
		
		if(sprite_index != spr_boss_movimento)
		{
			sprite_index = spr_boss_movimento;
			image_index = 0;
		}

		if(instance_exists(obj_player))
		{
			var _dist = point_distance(x,y,obj_player.x, obj_player.y);
			var _dir = point_direction(x,y,obj_player.x, obj_player.y);
			image_xscale = (obj_player.x < x) ? -1 : 1;
			
			if(_dist > 400)
			{
				vel_h = 0;
				estado = "parado";
				audio_stop_sound(snd_boss_passos);
			}
			else if (_dist <= 40)
			{
				vel_h = 0;
				estado = "ataque";
				audio_stop_sound(snd_boss_passos); 
				
				qual_ataque = irandom(2);
				switch(qual_ataque)
				{
					case 0: audio_play_sound(snd_boss_ataque_1, 10, false); break;
					case 1: audio_play_sound(snd_boss_ataque_2, 10, false); break;
					case 2: audio_play_sound(snd_boss_ataque_3, 10, false); break;
				}
			}
			else
			{
				vel_h = lengthdir_x(max_vel_h, _dir);
			}
		}
		break;
	}

	case "ataque" :
	{
		switch(qual_ataque)
		{
			case 0:
			{
				atacando(spr_boss_ataque_01, 2, 6, sprite_width/2, -sprite_height/3, 2, 2, "taunt");
				break;
			}
			case 1:
			{
				atacando(spr_boss_ataque_02, 2, 4, sprite_width/2.5, -sprite_height/3, 3, 1, "taunt");
				break;
			}
			case 2:
			{
				atacando(spr_boss_ataque_03, 4, 7, 0, -sprite_height/3, 5, 1, "taunt");
				break;
			}
		}
		break;
	}

	case "hit" :
	{
		if (sprite_index != spr_boss_hit)
		{
			sprite_index = spr_boss_hit;
			image_index = 0;
			audio_play_sound(snd_boss_hit, 10, false);
		}
		dano_timer = 20;
		levando_dano(spr_boss_hit, 2);
		break;
	}

	case "taunt" :
	{
		if(instance_exists(obj_player)) {
			image_xscale = (obj_player.x < x) ? -1 : 1;
		}
		
		taunt_timer--;
		
		if(sprite_index != spr_boss_taunt)
		{
			sprite_index = spr_boss_taunt;
			image_index = 0;
			audio_play_sound(snd_boss_taunt, 10, false);
		}
		
		if(taunt_timer <= 0)
		{
			taunt_timer = taunt_delay;
			estado = "parado";
		}
		break;
	}

	case "morto":
	{
		if (sprite_index != spr_boss_morte)
		{
			sprite_index = spr_boss_morte;
			image_index = 0;
			audio_play_sound(snd_boss_hit, 10, false);
		}
		
		morrendo(spr_boss_morte);

		obj_player.vel_h = 0;
		obj_player.vel_v = 0;

		if (image_index >= image_number - 1)
		{
			if (!instance_exists(obj_transicao_final))
			{
				instance_create_layer(0, 0, "Transicao", obj_transicao_final);
				obj_player.desenhar_vida = false;
			}
		}
		break;
	}
}