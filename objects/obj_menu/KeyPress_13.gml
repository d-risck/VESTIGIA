if(index = 0){
 instance_create_layer(0, 0, "Transicao", obj_transicao_menu);
}

if(index = 1){
 room_goto(rm_menu_controles);
}

else if(index = 2){
 game_end();	
}

