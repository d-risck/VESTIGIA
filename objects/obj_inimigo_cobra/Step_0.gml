/// @description Insert description here
// You can write your code in this editor

if(global.pause){
	vel_h = 0;
	vel_v = 0;
	exit;
}

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
		if(sprite_index != spr_inimigo_cobra_parada)
		{
			image_index = 0 
			sprite_index = spr_inimigo_cobra_parada;
		}
		 
		if(irandom(timer_estado) > 100)
		{
			estado = choose("andando","parado");
			timer_estado = 0;
		}
		
		scr_atacando_player_fisico(obj_player, dist, xscale);
		
		break;
	}
	
	case "andando" :
	{
		timer_estado++;
		if(sprite_index != spr_inimigo_cobra_andando)
		{
			image_index = 0 
			sprite_index = spr_inimigo_cobra_andando;
		}
		
		if(vel_h == 0)
		{
			vel_h = choose(-1, 1);
		}
		
		if(irandom(timer_estado) > 200)
		{
			estado = choose("parado","parado","andando");
			timer_estado = 0;
		}
		
		scr_atacando_player_fisico(obj_player,dist,xscale);
		
		break;
	}
	
	case "ataque" :
	{
		atacando(spr_inimigo_cobra_atacando, 3, 4, sprite_width/3 + 20, -sprite_height/2);
		break;
	}
	
	case "hit" :
	{
		levando_dano(spr_inimigo_cobra_sofrendo_dano, 2)
		break;
	}
	
	case "morto" :
	{
		morrendo(spr_inimigo_cobra_morrendo);
	}
}