draw_set_font(Font3);

draw_set_color(c_white);

var dist = 55;
var gui_altura = display_get_gui_height();
var gui_largura = display_get_gui_width();

var x1 = gui_largura/2;
var y1 = gui_altura/2 + 160;

for (var i = 0; i < op_max; i++) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_center);

    if (index == i)
    {
        draw_set_color(c_red); // seta a cor vermelha se for a opção selecionada
    }
    else
    {
        draw_set_color(c_white); // senão continua branco
    }

    draw_text(x1, y1 + (dist * i), opcoes[i]);
}

draw_set_font(-1);