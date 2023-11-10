/// @description Freeze Bar and Tutorials
if freezeBarActive {
	if !freezeBarHitZero {
		var freeze_bar_x_ = 32;
		var freeze_bar_y_ = 32;
		var percent_to_draw_ = (freezeBarCurrentValue / freezeBarMaxValue) * sprite_get_width(spr_freeze_bar_foreground);
		/// ADJUST - the color here should be set by a shader that rotates from orange to deep blue
		var color_of_freeze_bar_ = c_red;
		draw_sprite(spr_freeze_bar_border, 0, freeze_bar_x_ - 2, freeze_bar_y_ - 2);
		draw_sprite(spr_freeze_bar_background, 0, freeze_bar_x_, freeze_bar_y_);
		draw_sprite_part_ext(spr_freeze_bar_foreground, 0, 0, 0, percent_to_draw_, sprite_get_height(spr_freeze_bar_foreground), freeze_bar_x_, freeze_bar_y_, 1, 1, color_of_freeze_bar_, 1);
	}
}


