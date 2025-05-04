/// @description Insert description here
// You can write your code in this editor
if not instance_exists(alvo_) exit;

x = lerp(x,alvo_.x,0.1);
y = lerp(y,alvo_.y-height_/2.5,0.05);
camera_set_view_pos(view_camera[0], x-width_/2, y-height_/2.5);