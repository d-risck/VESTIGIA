
if(game_over)
{
	global.vel_mult = .5;
	if(keyboard_check(vk_enter))
	{
		room_restart();
		game_over = false;
	}
}
else
{
	global.vel_mult = 1;
}



