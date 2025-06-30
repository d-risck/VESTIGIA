/// @description Código de comportamento do Esqueleto Boss (Polido)

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
		if(sprite_index != spr_inimigo_esqueleto_boss_idle)
		{
			sprite_index = spr_inimigo_esqueleto_boss_idle;
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
		// Toca o som de passos
		if (!audio_is_playing(snd_esqueleto_passos)) {
			audio_play_sound(snd_esqueleto_passos, 2, false);
		}

		if(sprite_index != spr_inimigo_esqueleto_boss_movimento)
		{
			sprite_index = spr_inimigo_esqueleto_boss_movimento;
			image_index = 0;
		}
		
		if(instance_exists(obj_player))
		{
			var _dist = point_distance(x,y,obj_player.x, obj_player.y);
			var _dir = point_direction(x,y,obj_player.x, obj_player.y);
			image_xscale = (obj_player.x < x) ? -1 : 1;
			
			// --- CORREÇÃO: Lógica de distância sem lacunas ---
			if(_dist > 400)
			{
				vel_h = 0;
				estado = "parado";
				audio_stop_sound(snd_esqueleto_passos); // POLIMENTO: Para o som de passos
			}
			else if (_dist <= 30)
			{
				vel_h = 0;
				estado = "ataque";
				audio_stop_sound(snd_esqueleto_passos); // POLIMENTO: Para o som de passos
				
				qual_ataque = irandom(1);
				
				// POLIMENTO: Nomes de som consistentes
				switch(qual_ataque)
				{
					case 0: audio_play_sound(snd_boss_ataque_1, 10, false); break;
					case 1: audio_play_sound(snd_esqueleto_boss_ataque_2, 10, false); break;
				}
			}
			else // Se não, ANDE!
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
				atacando(spr_inimigo_esqueleto_boss_ataque, 4, 6, sprite_width/3, -sprite_height/3, 2, 2);
				break;
			}
			case 1:
			{
				atacando(spr_inimigo_esqueleto_boss_ataque2, 10, 15, sprite_width/2.5, -sprite_height/3, 3, 1);
				break;
			}
		}

		// --- CORREÇÃO: Adicionada lógica para sair do estado de ataque ---
		if (image_index >= image_number - 1)
		{
			estado = "parado"; // Volta para o estado parado após o ataque
		}
		break;
	}
	
	case "hit" :
	{
		if (sprite_index != spr_inimigo_esqueleto_boss_hit)
		{
			sprite_index = spr_inimigo_esqueleto_boss_hit;
			image_index = 0;
			audio_play_sound(snd_esqueleto_hit, 10, false);
		}

		dano_timer = 20;
		levando_dano(spr_inimigo_esqueleto_boss_hit, 2);
		break;
	}
	
	case "morto":
	{
		if (sprite_index != spr_inimigo_esqueleto_boss_morte)
		{
			sprite_index = spr_inimigo_esqueleto_boss_morte;
			image_index = 0;
			// POLIMENTO: Usando um som de morte dedicado
			audio_play_sound(snd_esqueleto_hit, 10, false); 
		}

		morrendo(spr_inimigo_esqueleto_boss_morte);

		if (image_index >= image_number - 1)
		{
			if (!instance_exists(obj_powerup))
			{
				// POLIMENTO: Dropa o item na posição do boss
				var _powerup_instancia = instance_create_layer(1348, 485, "Instances", obj_powerup);
				_powerup_instancia.image_xscale = 0.75;
				_powerup_instancia.image_yscale = 0.75;
			}
		}
		break; 
	}
}