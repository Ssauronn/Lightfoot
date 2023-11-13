///@description Death Screen
if room == GameRoom {
	// If the player has beaten the game, draw the congratulations splash text
	if gameBeaten {
		var x_scale_ = sprite_get_width(spr_splash_screen) / viewW;
		var y_scale_ = sprite_get_height(spr_splash_screen) / viewH;
		
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
	}
}


