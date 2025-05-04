/// @description Insert description here
// You can write your code in this editor

var chao = place_meeting(x, y + 1, obj_block);

if(!chao) 
{
	if(vel_v < max_vel_v * 2)
	{
		vel_v += GRAVIDADE * massa * global.vel_mult;
	}
}

switch(estado)
{
	#region Parado
	case "parado" :
	{
		 vel_h = 0;
		 timer_estado++;
		 if(sprite_index != spr_inimigo_mini_golem_parado)
		 {
			image_index = 0
			sprite_index = spr_inimigo_mini_golem_parado;
		 }
		
		if(irandom(timer_estado) > 300)
		{
			estado = choose("andando","parado","andando");
			timer_estado = 0;
		}
		
		scr_atacando_player_fisico(obj_player,dist,xscale);
		
		break;
	}
	#endregion
	
	#region Andando
	case "andando" :
	{
		timer_estado++;
		if(sprite_index != spr_inimigo_mini_golem_movendo)
		{
			image_index = 0 
			vel_h = choose(1,-1);
		}
		 
		sprite_index = spr_inimigo_mini_golem_movendo;
		 
		if(irandom(timer_estado) > 200)
		{
			estado = choose("parado","andando","parado");
			timer_estado = 0;
		}	
		
		scr_atacando_player_fisico(obj_player,dist,xscale);
		
		break;
	}
	#endregion
	
	#region Ataque
	case "ataque":
	{
		atacando(spr_inimigo_mini_golem_atacando, 4, 6, sprite_width/2, -sprite_height/2);
		break;
	}
	#endregion
	
	#region Hit
	case "hit" :
	{
	    levando_dano(spr_inimigo_mini_golem_levando_dano, 4) 
		break;
	}
	#endregion
	
	#region Morto
	case "morto" :
	{
		morrendo(spr_inimigo_mini_golem_morrendo);
	}
	#endregion
}
