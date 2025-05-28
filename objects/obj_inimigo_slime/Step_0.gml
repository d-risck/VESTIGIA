if (global.pause) exit;

var chao = place_meeting(x, y + 1, obj_bloco);

if (!chao) {
    vel_v += GRAVIDADE * massa * global.vel_mult;
}

if (instance_exists(obj_player)) {
    var dist_player = point_distance(x, y, obj_player.x, obj_player.y);
}

if (instance_exists(obj_player)  && estado != "ataque") {
    image_xscale = (obj_player.x < x) ? -1 : 1;
}

switch (estado) {

    case "parado":
    {
        vel_h = 0;

        if (sprite_index != spr_inimigo_slime_idle) {
            image_index = 0;
            sprite_index = spr_inimigo_slime_idle;
        }

        if (instance_exists(obj_player)) {
            if (dist_player <= dist) {
                vel_h = 0;
				audio_play_sound(snd_slime_ataque, 10, false);
                estado = "ataque";
            } 
			
			else if(dist_player >= 150)  {
            vel_h = 0;
            estado = "parado";
			} 
			
			else {
                // Segue o player horizontalmente usando image_xscale * max_vel_h
               estado = "andando";
            }
			
        }

        break;
    }

    case "andando":
    {
		
		if (!audio_is_playing(snd_slime_movimento)) {
            audio_play_sound(snd_slime_movimento, 10, false);
        }
		
        if (sprite_index != spr_inimigo_slime_movimento) {
            image_index = 0;
            sprite_index = spr_inimigo_slime_movimento;
        }

        if (instance_exists(obj_player)) {
            if (dist_player <= dist) {
                vel_h = 0;
				audio_play_sound(snd_slime_ataque, 10, false);
                estado = "ataque";
            } 
			
			else if(dist_player >= 150)  {
            vel_h = 0;
            estado = "parado";
			} 
			
			else {
                // Segue o player horizontalmente usando image_xscale * max_vel_h
                vel_h = image_xscale * max_vel_h;
            }
			
        }

        break;
    }

    case "ataque":
    {
        atacando(spr_inimigo_slime_ataque, 17, 19, (sprite_width / 4 + 5) - (3 * 5) * (image_xscale == -1), -sprite_height / 2);
        break;
    }

    case "hit":
    {
		if (sprite_index != spr_inimigo_slime_hit) 
		{
       
			sprite_index = spr_inimigo_slime_hit;
			image_index = 0; // Reinicia a animação do início

			audio_play_sound(snd_slime_hit, 10, false);
		}
        levando_dano(spr_inimigo_slime_hit, 2);
        break;
    }

    case "morto":
    {
		if (sprite_index != spr_inimigo_slime_morte) 
		{
       
			sprite_index = spr_inimigo_slime_morte;
			image_index = 0; // Reinicia a animação do início

			audio_play_sound(snd_slime_hit, 10, false);
		}
        morrendo(spr_inimigo_slime_morte);
        break;
    }
}
