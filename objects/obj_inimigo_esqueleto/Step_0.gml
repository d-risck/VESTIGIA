if (global.pause) exit;

var chao = place_meeting(x, y + 1, obj_bloco);

if (!chao) {
    vel_v += GRAVIDADE * massa * global.vel_mult;
}

// Vira para o player, exceto durante o ataque
if (estado != "ataque" && instance_exists(obj_player)) {
    image_xscale = (obj_player.x < x) ? -1 : 1;
}

if (instance_exists(obj_player)) {
    var dist_player = point_distance(x, y, obj_player.x, obj_player.y);
}

switch (estado) {

    case "parado":
    {
        vel_h = 0;

        if (sprite_index != spr_inimigo_esqueleto_idle) {
            image_index = 0;
            sprite_index = spr_inimigo_esqueleto_idle;
        }

        if (instance_exists(obj_player)) {
            if (dist_player <= dist) {
                estado = "ataque";
				audio_play_sound(snd_esqueleto_ataque, 2, false);
            }
            else if (dist_player <= 120) {
                estado = "andando";
            }
        }

        break;
    }

    case "andando":
    {
		/*if (!audio_is_playing(snd_esqueleto_passos)) {
            audio_play_sound(snd_esqueleto_passos, 2, false);
        }*/
		
        if (sprite_index != spr_inimigo_esqueleto_movimento) {
            image_index = 0;
            sprite_index = spr_inimigo_esqueleto_movimento;
        }

        if (instance_exists(obj_player)) {
            if (dist_player <= dist) {
                vel_h = 0;
                estado = "ataque";
				audio_play_sound(snd_esqueleto_ataque, 2, false);
            }
            else if (dist_player > 150) {
                vel_h = 0;
                estado = "parado";
            }
            else {
                vel_h = image_xscale * max_vel_h;
            }
        }
        else {
            vel_h = 0;
            estado = "parado";
        }

        break;
    }

    case "ataque":
    {
        atacando(spr_inimigo_esqueleto_ataque, 8, 11,(sprite_width / 2.5 + 5) - (1.5 * 5) * (image_xscale == -1), -sprite_height / 2);
        break;
    }

    case "hit":
    {
		if (sprite_index != spr_inimigo_esqueleto_hit) 
		{
       
			sprite_index = spr_inimigo_esqueleto_hit;
			image_index = 0; // Reinicia a animação do início

			audio_play_sound(snd_esqueleto_hit, 10, false);
		}
		
        levando_dano(spr_inimigo_esqueleto_hit, 1);
		
        break;
    }

    case "morto":
    {
		if (sprite_index != spr_inimigo_esqueleto_morte)
        {
          
            sprite_index = spr_inimigo_esqueleto_morte;
            image_index = 0;

            audio_play_sound(snd_esqueleto_hit, 10, false); // Usamos prioridade 10 para garantir que ele toque
        }
        morrendo(spr_inimigo_esqueleto_morte);
        break;
    }
}
