if (global.pause) {
    // Escurece a tela
    draw_set_color(c_black);
    draw_set_alpha(0.95);
    draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
    draw_set_alpha(1);

    draw_set_font(Font3); // Use a fonte desejada
    draw_set_halign(fa_center);
    draw_set_valign(fa_center);

    var dist = 55;
    var gui_altura = display_get_gui_height();
    var gui_largura = display_get_gui_width();

    var x1 = gui_largura / 2;
    var y1 = gui_altura / 2;

    for (var i = 0; i < op_max; i++) {
        if (index == i) {
            draw_set_color(c_red);
        } else {
            draw_set_color(c_white);
        }

        draw_text(x1, y1 + (dist * i), opcoes[i]);
    }

    draw_set_font(-1); // Resetar fonte
}
