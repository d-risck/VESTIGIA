/// @description Insert description here
// You can write your code in this editor

if(global.pause) exit

var chao = place_meeting(x, y + 1, obj_block);

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
		if(sprite_index != spr_boss_run)
		{
			sprite_index = spr_boss_run;
			image_index = 0;
		}
		
		if(instance_exists(obj_player))
		{
			var _dist = point_distance(x,y,obj_player.x, obj_player.y);
			var _dir = point_direction(x,y,obj_player.x, obj_player.y);
			
			if(_dist > 40)
			{
				vel_h = lengthdir_x(max_vel_h, _dir);
			}
			else
			{
				vel_h = 0;
				estado = "ataque";
				qual_ataque = irandom(2);
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
		levando_dano(spr_boss_levando_dano, 2);
		break;
	}
	
	case "taunt" :
	{
		taunt_timer--;
		if(sprite_index != spr_boss_taunt)
		{
			sprite_index = spr_boss_taunt;
			image_index = 0;
		}
		
		if(taunt_timer <= 0)
		{
			taunt_timer = taunt_delay;
			estado = "parado";
		}
		break;
	}
	
	case "morto" :
	{
		morrendo(spr_boss_morrendo);
	}
}