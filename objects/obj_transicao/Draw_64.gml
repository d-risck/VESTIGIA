/// @description Insert description here
// You can write your code in this editor


draw_set_alpha(alpha);
draw_set_color(c_black);
draw_text(10, 10, "Alpha: " + string(alpha));

draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
draw_set_alpha(1);
