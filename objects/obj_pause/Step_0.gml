if (keyboard_check_pressed(vk_escape)) {
    global.pause = !global.pause;
	obj_player.desenhar_vida = !obj_player.desenhar_vida;
}

if (global.pause) {
    // Navegação
    if (keyboard_check_pressed(vk_up)) {
        index--;
        if (index < 0) index = op_max - 1;
    }

    if (keyboard_check_pressed(vk_down)) {
        index++;
        if (index >= op_max) index = 0;
    }

    // Ação ao pressionar Enter
    if (keyboard_check_pressed(vk_enter)) {
        if (index == 0) {
			obj_player.desenhar_vida = true;
            global.pause = false; // Retomar jogo
        }
        else if (index == 1) {
			obj_player.persistent = false;
            room_goto(rm_menu_inicial); // Vá para o menu inicial (ajuste o nome conforme sua room)
        }
    }
}

