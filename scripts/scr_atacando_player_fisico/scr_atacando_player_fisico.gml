///@function scr_atacando_player_fisico
///@args player dist xscale
function scr_atacando_player_fisico(_player,_dist,_xscale)
{
	var outro = _player;
	var dist = _dist;
	var xscale = _xscale;
	var player = collision_line(x,y-sprite_height/3,x + (dist * xscale), y-sprite_height/3, outro, 0, 1);
	if(player)
	{
		estado = "ataque"
	}
}