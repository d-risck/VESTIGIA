/// @description Código de comportamento do boss

if(global.pause) exit

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
		if(sprite_index != spr_inimigo_esqueleto_boss_movimento)
		{
			sprite_index = spr_inimigo_esqueleto_boss_movimento;
			image_index = 0;
		}
		
		if(instance_exists(obj_player))
		{
			var _dist = point_distance(x,y,obj_player.x, obj_player.y);
			var _dir = point_direction(x,y,obj_player.x, obj_player.y);

			// Virar sprite na direção do player
			image_xscale = (obj_player.x < x) ? -1 : 1;
			
			// Se player estiver longe demais, parar
			if(_dist > 400)
			{
				vel_h = 0;
				estado = "parado";
				break;
			}
			
			// Se estiver em distância média, mover em direção ao player
			if(_dist <= 150 && _dist > 40)
			{
				vel_h = lengthdir_x(max_vel_h, _dir);
			}
			else if (_dist <= 40)
			{
				vel_h = 0;
				estado = "ataque";
				qual_ataque = irandom(1);
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
		break;
	}
	
	case "hit" :
	{
		dano_timer = 20;
		levando_dano(spr_inimigo_esqueleto_boss_hit, 2);
		break;
	}
	
	
	case "morto":
{
    // 1. Garante que a animação de morte está tocando
    morrendo(spr_inimigo_esqueleto_boss_morte);

    // 3. Verifica se a animação chegou ao fim
    if (image_index >= image_number - 1)
    {
        // 4. Só então, cria a transição e esconde a vida do jogador
        // (Verificação extra para não criar a transição várias vezes)
        if (!instance_exists(obj_powerup))
        {
            var _powerup_instancia = instance_create_layer(1545, 483, "Instances", obj_powerup);

            // Agora, use a variável para alterar a escala da instância que acabamos de criar
            _powerup_instancia.image_xscale = 0.5; // Metade da largura (50%)
            _powerup_instancia.image_yscale = 0.5; // Metade da altura (50%)
        }
    }
    break; // Não esqueça o break!
}
}
