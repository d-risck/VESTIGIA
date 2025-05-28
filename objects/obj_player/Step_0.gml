if(global.pause){
	vel_h = 0;
	vel_v = 0;
	exit;
}
// INVENCIBILIDADE
if (invencivel && tempo_invencivel > 0) {
    tempo_invencivel--;
    image_alpha = max(sin(get_timer() / 100000), 0.2); // efeito pisca
} else {
    invencivel = false;
    image_alpha = 1; // volta ao normal
}

// ENTRADAS DO TECLADO
var right = keyboard_check(ord("D"));
var left = keyboard_check(ord("A"));
var jump = keyboard_check(vk_space);
var jump_pressed = keyboard_check_pressed(vk_space);
var attack = keyboard_check(ord("K")) || keyboard_check(vk_left);
var pause = keyboard_check(vk_escape);
var dash = keyboard_check(ord("L"));

// VERIFICA SE ESTÁ NO CHÃO
var chao = place_meeting(x, y + 1, obj_block);

// BUFF DE ATAQUE NEGATIVO
if (ataque_buff < 0) ataque_buff -= 2;

// VERIFICA PAREDE NA ESQUERDA E DIREITA
var wall_left = place_meeting(x - 1, y, obj_block);
var wall_right = place_meeting(x + 1, y, obj_block);
var wall = wall_left || wall_right;

// MOVIMENTO HORIZONTAL NORMAL
if (!fez_wall_jump) {
    vel_h = (right - left) * max_vel_h * global.vel_mult;
}

// SE ENCOSTOU NA PAREDE DEPOIS DO WALL JUMP
if (fez_wall_jump && wall) {
    fez_wall_jump = false; // libera controle horizontal
}

// CONTROLE DE ESTADOS DO PERSONAGEM
switch (estado) {

    case "parado":
    {
        mid_vel_h = 0;
        sprite_index = spr_player_parado;

        if (vel_h != 0) {
            estado = "movendo";
        } else if (!chao) {
            estado = "pulando";
        } else if (jump_pressed) {
            estado = "pulando";
            vel_v = -max_vel_v;
            image_index = 0;
        } else if (attack) {
            inicia_ataque();
        } else if (dash) {
            estado = "dash";
            image_index = 0;
        }

        break;
    }

    case "movendo":
    {
        sprite_index = spr_player_movendo;

        //if (!audio_is_playing(snd_steps)) {
          //  audio_play_sound(snd_steps, 2, false);
        //}

        if (abs(vel_h) < 0.1) {
            estado = "parado";
            vel_h = 0;
            //audio_stop_sound(snd_steps);
        } else if (!chao) {
            estado = "pulando";
        } else if (jump_pressed) {
            estado = "pulando";
            vel_v = -max_vel_v;
            image_index = 0;
        } else if (attack) {
            inicia_ataque();
        } else if (dash) {
            estado = "dash";
            image_index = 0;
        }

        break;
    }

    case "pulando":
    {
        aplicando_gravidade();

        if (vel_v > 0) {
            sprite_index = spr_player_caindo;
        } else {
            sprite_index = spr_player_pulando;
            if (image_index >= image_number - 1) {
                image_index = image_number - 1;
            }
        }

        // CAIU NO CHÃO
        if (chao) {
            estado = "parado";
            vel_h = 0;
            mid_vel_h = 0;
            fez_wall_jump = false;
        }

        // PAREDE PARA WALL JUMP
        if (wall && global.power_ups[0]) {
            sprite_index = spr_player_wall;

            if (jump_pressed && can_wall_jump) {
                vel_v = -max_vel_v;
                vel_h = max_vel_h * 1.0 * (wall_left ? 1 : -1); // impulso para lado
                fez_wall_jump = true;
                can_wall_jump = false;
                alarm[0] = room_speed / 2; // meio segundo
            }

            // Limita a queda rápida
            if (vel_v > 1) vel_v = 1;
            else {
                aplicando_gravidade();
                mid_vel_h = lerp(mid_vel_h, 0, 0.05);
            }
        }

        break;
    }

    case "hit":
    {
        if (sprite_index != spr_player_levando_dano) {
            sprite_index = spr_player_levando_dano;
            image_index = 0;
            screenshake(6);

            invencivel = true;
            tempo_invencivel = invencivel_timer;
        }

        vel_h = 0;

        if (vida_atual > 0) {
            if (image_index > image_number - 1) {
                estado = "parado";
            }
        } else {
            if (image_index > image_number - 1) {
                estado = "morto";
            }
        }

        break;
    }

    case "morto":
    {
        if (instance_exists(obj_game_controller)) {
            with (obj_game_controller) {
                game_over = true;
            }
        }

        vel_h = 0;

        if (sprite_index != spr_player_morrendo) {
            image_index = 0;
            sprite_index = spr_player_morrendo;
        }

        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
        }

        break;
    }

    case "ataque":
    {
        vel_h = 0;

        if (combo == 0) {
            sprite_index = spr_player_atacando1;
        } else if (combo == 1) {
            sprite_index = spr_player_atacando2;
        }

        if (image_index >= 1 && dano == noone && posso) {
            dano = instance_create_layer(x + sprite_width / 4, y - sprite_height / 4, layer, obj_dano);
            dano.dano = ataque;
            dano.pai = id;
            posso = false;
        }

        if (attack && combo < 1) {
            ataque_buff = room_speed;
        }

        if (ataque_buff && combo < 1 && image_index >= image_number - 1) {
            combo++;
            image_index = 0;
            posso = true;
        }

        ataque_buff = 0;

        if (image_index > image_number - 1) {
            estado = "parado";
            vel_h = 0;
            combo = 0;
            posso = true;

            if (dano) {
                instance_destroy(dano, false);
                dano = noone;
            }
        }

        if (dash) {
            estado = "dash";
            image_index = 0;
            combo = 0;
            if (dano) {
                instance_destroy(dano, false);
                dano = noone;
            }
        }

        break;
    }

    case "dash":
    {
        aplicando_gravidade();
        sprite_index = spr_player_dash;

        vel_h = image_xscale * dash_vel;

        if (image_index > image_number - 1) {
            estado = "parado";
        }
        break;
    }

    default:
    {
        estado = "parado";
    }
}