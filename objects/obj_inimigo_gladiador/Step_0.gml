/// @description Insert description here
// You can write your code in this editor
var chao = place_meeting(x, y + 1, obj_block);

if(!chao) 
{
	vel_v += GRAVIDADE * massa * global.vel_mult;
}

switch(estado)
{
	case "parado":
	{
		vel_h = 0;
		timer_estado++;
		if(sprite_index != spr_inimigo_gladiador_idle)
		{
			image_index = 0 
			sprite_index = spr_inimigo_gladiador_idle;
		}
		
		if(irandom(timer_estado) > 100)
			{
				estado = choose("andando","parado");
				timer_estado = 0;
			}
	
		scr_atacando_player_fisico(obj_player,dist,xscale);
		
		break;
	}
	
	case "andando" :
	{
		timer_estado++;
		if(sprite_index != spr_inimigo_gladiador_andando)
		{
			image_index = 0 
			sprite_index = spr_inimigo_gladiador_andando;
		}
		
		if(vel_h == 0)
		{
			vel_h = choose(-1, 1);
		}
		
		if(irandom(timer_estado) > 100)
		{
			estado = choose("parado","parado","andando");
			timer_estado = 0;
		}
		
		scr_atacando_player_fisico(obj_player,dist,xscale);
		
		break;
	}
	
	case "ataque" :
	{
		atacando(spr_inimigo_gladiador_ataque, 1, 3, sprite_width/3 + 5, -sprite_height/2);
		break;
	}
	
	case "hit" :
	{
		levando_dano(spr_inimigo_gladiador_levando_dano, 1)
		break;
	}
	
	case "morto" :
	{
		morrendo(spr_inimigo_gladiador_morrendo);
	}
}