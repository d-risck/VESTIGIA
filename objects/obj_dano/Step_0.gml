/// @description Insert description here
// You can write your code in this editor

var outro;
var outra_lista = ds_list_create();
var quantidade = instance_place_list(x,y, obj_entidade, outra_lista, 0);

for(var i = 0; i < quantidade; i++)
{
	var atual = outra_lista[| i];
	
	if(atual.invencivel)
	{
		continue;
	}
	if(object_get_parent(atual.object_index) != object_get_parent(pai.object_index))
	{
		var pos = ds_list_find_index(aplicar_dano, atual);
		if(pos  == -1)
		{
			ds_list_add(aplicar_dano, atual);
		}
	}
}

var tam = ds_list_size(aplicar_dano);
for(var i = 0; i < tam; i++)
{
	outro = aplicar_dano[| i].id;
	if(outro.vida_atual > 0)
			{
				if(outro.delay <= 0)
				{
				outro.estado = "hit"
				outro.image_index = 0;
				}
				outro.vida_atual -= dano;
				
				if(object_get_parent(outro.object_index) == obj_pai_inimigos)
				{
					screenshake(2);
					
					if(outro.vida_atual <= 0)
					{
						outro.estado = "morto";
					}
				}
			}
}
ds_list_destroy(aplicar_dano);
ds_list_destroy(outra_lista);
instance_destroy();