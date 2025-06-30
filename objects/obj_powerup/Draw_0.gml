draw_self();

// --- 2. Encontrar o Centro Visual do Sprite (A CORREÇÃO PRINCIPAL) ---
// Usamos a bounding box para encontrar o meio exato do sprite na tela,
// independentemente de onde o seu ponto de origem esteja.
var _centro_x_sprite = (bbox_left + bbox_right) / 2;
var _centro_y_sprite = bbox_top; // Usaremos o topo do sprite como referência vertical


// --- 3. Definições para o texto e o retângulo ---
var _texto = "Pule na parede\nCom Espaço.";
var _padding = 8;
var _offset_y = 20; // Distância que a caixa ficará acima do TOPO do sprite

// Define a fonte ANTES de medir o texto
draw_set_font(fnt_powerup); // Use a sua fonte


// --- 4. Medir o Texto para saber o tamanho do retângulo ---
var _texto_largura = string_width(_texto);
var _texto_altura = string_height(_texto);

var _retangulo_largura = _texto_largura + (_padding * 2);
var _retangulo_altura = _texto_altura + (_padding * 2);


// --- 5. Calcular as Coordenadas do Retângulo ---
// A posição X é baseada no centro do sprite.
// A posição Y é baseada no topo do sprite, mais o offset.
var _ret_x1 = _centro_x_sprite - (_retangulo_largura / 2);
var _ret_y1 = _centro_y_sprite - _offset_y - _retangulo_altura; // Ajustado para ficar acima
var _ret_x2 = _centro_x_sprite + (_retangulo_largura / 2);
var _ret_y2 = _centro_y_sprite - _offset_y;


// --- 6. Desenhar o Retângulo Preto Semi-Transparente ---
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(_ret_x1, _ret_y1, _ret_x2, _ret_y2, false);


// --- 7. Desenhar o Texto Centralizado ---
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Desenha o texto no centro do retângulo que acabamos de calcular
var _texto_y = _ret_y1 + (_retangulo_altura / 2);
draw_text(_centro_x_sprite, _texto_y, _texto);


// --- 8. Boas Práticas: Resetar todas as configurações de desenho ---
draw_set_font(-1);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);