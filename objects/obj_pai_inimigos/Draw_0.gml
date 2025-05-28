if (dano_timer > 0) {
    gpu_set_blendmode(bm_add);
    draw_set_color(c_white);

    draw_self(); // primeira vez
    draw_self(); // segunda vez, intensifica o brilho

    gpu_set_blendmode(bm_normal);
    draw_set_color(c_white);
} else {
    draw_self();
}

