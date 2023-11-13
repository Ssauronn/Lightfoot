///@description Death Screen
if room == GameRoom {
	// Draw Lighting Effects
	if instance_exists(obj_player) {
		draw_sprite_ext(spr_glow_inner, 0, obj_player.x + (sprite_get_width(obj_player.sprite_index) / 2), obj_player.y + (sprite_get_height(obj_player.sprite_index) / 2), 1, 1, 0, c_white, 0.2);
		draw_sprite_ext(spr_glow_middle, 0, obj_player.x + (sprite_get_width(obj_player.sprite_index) / 2), obj_player.y + (sprite_get_height(obj_player.sprite_index) / 2), 1, 1, 0, c_white, 0.2)
		draw_sprite_ext(spr_glow_outter, 0, obj_player.x + (sprite_get_width(obj_player.sprite_index) / 2), obj_player.y + (sprite_get_height(obj_player.sprite_index) / 2), 1, 1, 0, c_white, 0.2)
		draw_sprite_ext(spr_glow_shadow, 0, obj_player.x + (sprite_get_width(obj_player.sprite_index) / 2), obj_player.y + (sprite_get_height(obj_player.sprite_index) / 2), 1, 1, 0, c_white, 0.6)
	}
	// Bonfire Icon
	var current_objective_, bonfire_to_move_to_;
	bonfire_to_move_to_ = noone;
	current_objective_ = objectiveCount;
	with obj_bonfire {
		if objective == current_objective_ {
			bonfire_to_move_to_ = id;
			break;
		}
	}
	// If the next bonfire to move to exists, and it's not on screen, then draw the icon.
	if (bonfire_to_move_to_ != noone) && (!rectangle_in_rectangle(bonfire_to_move_to_.x, bonfire_to_move_to_.y, bonfire_to_move_to_.x + bonfire_to_move_to_.sprite_width, bonfire_to_move_to_.y + bonfire_to_move_to_.sprite_height, viewX, viewY, viewX + viewW, viewY + viewH)) {
		var bicon_x_ = obj_player.x + lengthdir_x(viewW / 2, point_direction(obj_player.x, obj_player.y, bonfire_to_move_to_.x, bonfire_to_move_to_.y));
		bicon_x_ = clamp(bicon_x_, viewX + 32, viewX + viewW - 64);
		var bicon_y_ = obj_player.y + lengthdir_y(viewW / 2, point_direction(obj_player.x, obj_player.y, bonfire_to_move_to_.x, bonfire_to_move_to_.y));
		bicon_y_ = clamp(bicon_y_, viewY + 32, viewY + viewH - 64);
		var sprite_scale_ = min(0.5, (warmthDistance / point_distance(obj_player.x, obj_player.y, bonfire_to_move_to_.x, bonfire_to_move_to_.y)));
		sprite_scale_ = clamp(sprite_scale_, 0.2, 0.5);
		draw_sprite_ext(spr_bonfire, 0, bicon_x_, bicon_y_, sprite_scale_, sprite_scale_, 0, c_white, 1);
	}
	
	// If the player has beaten the game, draw the congratulations splash text
	if gameBeaten {
		var x_scale_ = sprite_get_width(spr_splash_screen) / viewW;
		var y_scale_ = sprite_get_height(spr_splash_screen) / viewH;
		draw_sprite_ext(spr_button_background, 0, startGameButtonX, startGameButtonY + (2 * (viewH / 32)), 1, 1, 0, c_black, 1);
		draw_set_color(c_black);
		draw_text_ext_transformed(viewX + 16, startGameButtonY + (2 * (viewH / 32)), "CONGRATULATIONS! YOU ARE SAFE!", 2, 1000, 4, 4, 0);
		draw_set_color(c_white);
	}
	// If the player has died, draw the death screen
	if playerDied {
		var x_scale_ = sprite_get_width(spr_splash_screen) / viewW;
		var y_scale_ = sprite_get_height(spr_splash_screen) / viewH;
		draw_sprite_ext(spr_splash_screen, 0, viewX, viewY, x_scale_, y_scale_, 0, c_black, percentToFadeToDeathScreen);
		
		// If the fade animation is complete, make the buttons for the screen appear.
		if playerDiedTimerCurrentTime >= playerDiedTimerStartTime {
			var x_scale_ = sprite_get_width(spr_main_menu_selection) / viewW;
			var y_scale_ = sprite_get_height(spr_main_menu_selection) / viewH;
			var second_button_text_ = "Go Again!";
			if (buttonHeldDown) && (startGameButtonClickedOn == 3) {
				button_x_adjust_ = 0;
				button_y_adjust_ = 0;
			}
			else {
				button_x_adjust_ = -8;
				button_y_adjust_ = -8;
			}
			draw_sprite_ext(spr_button_background, 0, startGameSmallButtonX, startGameSmallButtonSecondY, startGameSmallButtonScale, startGameSmallButtonScale, 0, c_black, 1);
			draw_sprite_ext(spr_button_background, 0, startGameSmallButtonX + button_x_adjust_, startGameSmallButtonSecondY+ button_y_adjust_, startGameSmallButtonScale, startGameSmallButtonScale, 0, c_white, 1);
			draw_text_ext_transformed(startGameSmallButtonX + 4, startGameSmallButtonSecondY + 4, second_button_text_, 2, 600, 2, 2, 0);
		}
	}
	// Draw pause menu buttons
	else if pauseMenuActive {
		var x_scale_ = sprite_get_width(spr_main_menu_selection) / viewW;
		var y_scale_ = sprite_get_height(spr_main_menu_selection) / viewH;
		var main_button_text_ = "Resume";
		var first_button_text_ = "Toggle Tutorials";
		var second_button_text_ = "Back To Main Menu";
		if (buttonHeldDown) && (startGameButtonClickedOn == 1) {
			button_x_adjust_ = 0;
			button_y_adjust_ = 0;
		}
		else {
			button_x_adjust_ = -8;
			button_y_adjust_ = -8;
		}
		draw_sprite_ext(spr_button_background, 0, startGameButtonX, startGameButtonY + (2 * (viewH / 32)), 1, 1, 0, c_black, 1);
		draw_sprite_ext(spr_button_background, 0, startGameButtonX + button_x_adjust_, startGameButtonY + button_y_adjust_ + (2 * (viewH / 32)), 1, 1, 0, c_white, 1);
		if (buttonHeldDown) && (startGameButtonClickedOn == 2) {
			button_x_adjust_ = 0;
			button_y_adjust_ = 0;
		}
		else {
			button_x_adjust_ = -8;
			button_y_adjust_ = -8;
		}
		draw_sprite_ext(spr_button_background, 0, startGameSmallButtonX, startGameSmallButtonFirstY, startGameSmallButtonScale, startGameSmallButtonScale, 0, c_black, 1);
		draw_sprite_ext(spr_button_background, 0, startGameSmallButtonX + button_x_adjust_, startGameSmallButtonFirstY + button_y_adjust_, startGameSmallButtonScale, startGameSmallButtonScale, 0, c_white, 1);
		if (buttonHeldDown) && (startGameButtonClickedOn == 3) {
			button_x_adjust_ = 0;
			button_y_adjust_ = 0;
		}
		else {
			button_x_adjust_ = -8;
			button_y_adjust_ = -8;
		}
		draw_sprite_ext(spr_button_background, 0, startGameSmallButtonX, startGameSmallButtonSecondY, startGameSmallButtonScale, startGameSmallButtonScale, 0, c_black, 1);
		draw_sprite_ext(spr_button_background, 0, startGameSmallButtonX + button_x_adjust_, startGameSmallButtonSecondY+ button_y_adjust_, startGameSmallButtonScale, startGameSmallButtonScale, 0, c_white, 1);
		
		// Draw Text for in-game menu
		draw_text_ext_transformed(startGameButtonX + 16, startGameButtonY + 42, main_button_text_, 2, 600, 4, 4, 0);
		draw_text_ext_transformed(startGameSmallButtonX + 4, startGameSmallButtonFirstY + 4, first_button_text_, 2, 600, 2, 2, 0);
		draw_text_ext_transformed(startGameSmallButtonX + 4, startGameSmallButtonSecondY + 4, second_button_text_, 2, 600, 2, 2, 0);
		draw_set_color(c_black);
		if tutorialsActive {
			var tutorial_status_ = "ON"
		}
		else {
			var tutorial_status_ = "OFF"
		}
		draw_text_ext_transformed(startGameSmallButtonX + (sprite_get_width(spr_button_background) * startGameSmallButtonScale) + 4, startGameSmallButtonFirstY + 4, tutorial_status_, 2, 600, 2, 2, 0);
		draw_set_color(c_white);
	}
}


