if(global.pause) exit



var chao = place_meeting(x, y + 1, obj_bloco);



if(!chao) 

{

vel_v += GRAVIDADE * massa * global.vel_mult;

}



switch(estado)

{

case "parado":

{

if(sprite_index != spr_boss_idle)

{

sprite_index = spr_boss_idle;

image_index = 0;

}


if(instance_exists(obj_player))

{

var _dist = point_distance(x,y,obj_player.x, obj_player.y);

if(_dist < 300)

{

estado = "andando";

}

}

break;

}


case "andando":

{

if(sprite_index != spr_boss_movimento)

{

sprite_index = spr_boss_movimento;

image_index = 0;

}


if(instance_exists(obj_player))

{

var _dist = point_distance(x,y,obj_player.x, obj_player.y);

var _dir = point_direction(x,y,obj_player.x, obj_player.y);



// Virar sprite na direção do player

image_xscale = (obj_player.x < x) ? -1 : 1;


// Se player estiver longe demais, parar

if(_dist > 400)

{

vel_h = 0;

estado = "parado";

break;

}


// Se estiver em distância média, mover em direção ao player

if(_dist <= 150 && _dist > 40)

{

vel_h = lengthdir_x(max_vel_h, _dir);

}

else if (_dist <= 40)

{

vel_h = 0;

estado = "ataque";

qual_ataque = irandom(2);

}

}

break;

}


case "ataque" :

{

switch(qual_ataque)

{

case 0:

{

atacando(spr_boss_ataque_01, 2, 6, sprite_width/2, -sprite_height/3, 2, 2, "taunt");

break;

}

case 1:

{

atacando(spr_boss_ataque_02, 2, 4, sprite_width/2.5, -sprite_height/3, 3, 1, "taunt");

break;

}

case 2:

{

atacando(spr_boss_ataque_03, 4, 7, 0, -sprite_height/3, 5, 1, "taunt");

break;

}

}

break;

}


case "hit" :

{

dano_timer = 20;

levando_dano(spr_boss_hit, 2);

break;

}


case "taunt" :

{

if(instance_exists(obj_player)) {

image_xscale = (obj_player.x < x) ? -1 : 1;

}


taunt_timer--;

if(sprite_index != spr_boss_taunt)

{

sprite_index = spr_boss_taunt;

image_index = 0;

}


if(taunt_timer <= 0)

{

taunt_timer = taunt_delay;

estado = "parado";

}

break;

}


case "morto":

{

    // 1. Garante que a animação de morte está tocando

    morrendo(spr_boss_morte);



    // 2. Trava o jogador imediatamente para ele não se mover durante a animação de morte

    obj_player.vel_h = 0;

    obj_player.vel_v = 0;



    // 3. Verifica se a animação chegou ao fim

    if (image_index >= image_number - 1)

    {

        // 4. Só então, cria a transição e esconde a vida do jogador

        // (Verificação extra para não criar a transição várias vezes)

        if (!instance_exists(obj_transicao_final))

        {

            instance_create_layer(0, 0, "Transicao", obj_transicao_final);

            obj_player.desenhar_vida = false;

  

        }

    }

    break; // Não esqueça o break!

}

}