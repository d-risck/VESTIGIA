/// @description Inicialização do jogador

randomize(); 

event_inherited(); 

// VIDA
vida_max = 6;
vida_atual = vida_max;

// VELOCIDADES MÁXIMAS
max_vel_h = 3;    
max_vel_v = 5.8;    

// WALL JUMP
can_wall_jump = true;   
fez_wall_jump = false; 

// DASH
dash_vel = 2; 

// EXIBIÇÃO
mostra_estado = false; // Mostrar estado no debug (opcional)

// ATAQUE
combo = 0;       
img_spd = 30;   
dano = noone;    
posso = true;     
ataque_buff = room_speed; 

// INVENCIBILIDADE
invencivel = false;                  
invencivel_timer = room_speed * 2;   
tempo_invencivel = invencivel_timer; 

// POWER-UPS GLOBAIS
global.power_ups = [false];
// FUNÇÃO: Inicia ataque
inicia_ataque = function() {
    estado = "ataque";
    vel_h = 0;
    image_index = 0;
}

// FUNÇÃO: Aplica gravidade
aplicando_gravidade = function() {
    var chao = place_meeting(x, y + 1, obj_block);

    if (!chao) {
        if (vel_v < max_vel_v * 2) {
            vel_v += GRAVIDADE * massa * global.vel_mult;
        }
    }
}
