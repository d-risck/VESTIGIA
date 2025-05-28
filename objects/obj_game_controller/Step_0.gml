
if(game_over)
{
	global.vel_mult = .5;
	if(keyboard_check(vk_enter))
	{
		room_goto(fase_01)
		obj_player.persistent = false
		game_over = false;
	}
}
else
{
	global.vel_mult = 1;
}


