if (game_over)
{
    var x1 = camera_get_view_x(view_camera[0]);
    var w = camera_get_view_width(view_camera[0]);
    var x2 = x1 + w;
    var meio_w = x1 + w/2;
    var y1 = camera_get_view_y(view_camera[0]);
    var h = camera_get_view_height(view_camera[0]);
    var y2 = y1 + h;
    var meio_h = y1 + h/2;
	
    valor = lerp(valor, 1, .05);
    var qtd = h * .10;
	
    // ESCURECER TELA INTEIRA
    draw_set_color(c_black);
    draw_set_alpha(valor - 0.3);
    draw_rectangle(x1, y1, x2, y2, false);
    
    draw_set_alpha(1);

    // Barras no topo e rodapé (como já tinha)
    draw_rectangle(x1, y1, x2, y1 + qtd * valor, false);
    draw_rectangle(x1, y2, x2, (y2 - 9) - qtd * valor, false);
    
    draw_set_alpha(1);
    draw_set_color(c_white); // corrigido para branco
    
    if(valor >= 0.85)
    {
        contador = lerp(contador, 1, .05);
        draw_set_font(fnt_gameover);
        draw_set_alpha(contador);
        draw_set_valign(1);
        draw_set_halign(1);
        draw_set_color(c_red);
        draw_text(meio_w + 1, meio_h + 1, "GAME OVER");
        draw_set_color(c_white);
        draw_text(meio_w, meio_h, "GAME OVER");
        draw_set_font(-1);
        draw_set_font(fnt_enter);
        draw_text(meio_w, meio_h + 20, "Pressione ENTER para reiniciar");
        draw_set_font(-1);
        draw_set_valign(-1);
        draw_set_halign(-1);
        draw_set_alpha(1);
    }
}
