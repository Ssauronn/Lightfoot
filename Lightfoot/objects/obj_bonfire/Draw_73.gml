///@description Draw Self
if objective != 0 {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(spr_glow_inner, 0, x, y, 1, 1, 0, c_white, 0.2);
	draw_sprite_ext(spr_glow_middle, 0, x, y, 1, 1, 0, c_white, 0.2);
	gpu_set_blendmode(bm_normal);
	draw_self();
}
else {
	if invisible > 0 {
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(spr_glow_inner, 0, x, y, 1, 1, 0, c_white, 0.2);
		draw_sprite_ext(spr_glow_middle, 0, x, y, 1, 1, 0, c_white, 0.2);
		gpu_set_blendmode(bm_normal);
		draw_self();
	}
	else {
		visible = false;
	}
}

