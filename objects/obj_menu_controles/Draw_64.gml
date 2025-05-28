/// @description Desenha a opção "Sair" no canto inferior direito

// --- Pega as dimensões da tela ---
var _gui_largura = display_get_gui_width();
var _gui_altura = display_get_gui_height();

// Define uma margem para não ficar colado na borda
var _margem = 50; 

// --- Define a posição do texto ---
// O 'x' será a largura da tela menos a margem.
// O 'y' será a altura da tela menos a margem.
var _x = _gui_largura - _margem;
var _y = _gui_altura - _margem;

// --- Configurações de Desenho ---
draw_set_font(Font3);
draw_set_color(c_red); // Ou c_red, como preferir, já que é a única opção

// ESTA É A PARTE MAIS IMPORTANTE: O Alinhamento
// Alinha o texto pela direita (horizontal) e pela base (vertical)
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);


// --- Desenha o Texto ---
draw_text(_x, _y, opcoes[0]);


// --- Boas Práticas: Resetar as configurações de desenho ---
// É bom resetar para não afetar outros textos no jogo.
draw_set_font(-1);
draw_set_color(c_red);
draw_set_halign(fa_left);
draw_set_valign(fa_top);