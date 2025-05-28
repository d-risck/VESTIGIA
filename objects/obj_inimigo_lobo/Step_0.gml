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

        if (sprite_index != spr_inimigo_lobo_idle) {
            image_index = 0;
            sprite_index = spr_inimigo_lobo_idle;
        }

        if (instance_exists(obj_player)) {
            if (dist_player <= dist) {
                estado = "ataque";
				 audio_play_sound(snd_lobo_ataque, 1, false);
            } else if (dist_player <= 120) {
                estado = "andando";
            }
        }

        break;
    }

    case "andando":
    {
        if (sprite_index != spr_inimigo_lobo_movimento) {
            image_index = 0;
            sprite_index = spr_inimigo_lobo_movimento;
        }
		
		if (!audio_is_playing(snd_lobo_passos)) {
            audio_play_sound(snd_lobo_passos, 2, false);
        }

       if (instance_exists(obj_player)) {
            if (dist_player <= dist) {
                vel_h = 0;
                estado = "ataque";
				 audio_play_sound(snd_lobo_ataque, 1, false);
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
        atacando(spr_inimigo_lobo_ataque, 3, 4, (sprite_width / 3 + 5) - (2 * 5) * (image_xscale == -1), -sprite_height / 2);
		break;
    }

    case "hit":
    {
		if (sprite_index != spr_inimigo_lobo_hit) 
    {
       
        sprite_index = spr_inimigo_lobo_hit;
        image_index = 0; // Reinicia a animação do início

        audio_play_sound(snd_lobo_hit, 10, false);
    }
    
		levando_dano(spr_inimigo_lobo_hit, 2);
        break;
    }

    case "morto":
    {
		if (sprite_index != spr_inimigo_lobo_morte)
        {
          
            sprite_index = spr_inimigo_lobo_morte;
            image_index = 0;

            // 2. TOQUE O SOM DE MORTE AQUI!
            audio_play_sound(snd_lobo_hit, 10, false); // Usamos prioridade 10 para garantir que ele toque
        }
        morrendo(spr_inimigo_lobo_morte);
        break;
    }
}
