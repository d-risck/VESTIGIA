// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_funcoes(){

}
///@function screenshake(valor_da_tremida)
///@arg força_da_tremida
function screenshake(_treme)
{
	var shake = instance_create_layer(0,0,"instances",obj_screenshake)
	shake.shake = _treme;
}