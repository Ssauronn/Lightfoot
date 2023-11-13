///@description Draw To World
// Draw Menu stuff if we're in the menu room
if room == MainMenu {
	if splashscreenActive {
		var x_scale_ = sprite_get_width(spr_splash_screen) / viewW;
		var y_scale_ = sprite_get_height(spr_splash_screen) / viewH;
		draw_sprite_ext(spr_splash_screen, 0, viewX, viewY, x_scale_, y_scale_, 0, c_white, percentToFadeSplashScreen);
		
	}
	else if mainMenuActive {
		// If the mouse button (left) is NOT currently held down, then shift the button slightly up and to the left
		// with the background sprite remaining at original position, to give the illusion of a 3D press on a button
		var button_x_adjust_ = 0;
		var button_y_adjust_ = 0;
		
		// Check for various menus on the main menu screen
		if (mainMenuSelectionScreenActive) || (mainMenuSettingsScreenActive) {
			var x_scale_ = sprite_get_width(spr_main_menu_selection) / viewW;
			var y_scale_ = sprite_get_height(spr_main_menu_selection) / viewH;
			if mainMenuSelectionScreenActive {
				draw_sprite_ext(spr_main_menu_selection, 0, viewX, viewY, x_scale_, y_scale_, 0, c_white, 1);
				var main_button_text_ = "Play Game";
				var first_button_text_ = "Settings";
				var second_button_text_ = "Controls";
				
				// Draw quit button
				if (buttonHeldDown) && (startGameButtonClickedOn == 4) {
					button_x_adjust_ = 0;
					button_y_adjust_ = 0;
				}
				else {
					button_x_adjust_ = -8;
					button_y_adjust_ = -8;
				}
				draw_sprite_ext(spr_button_background, 0, 32, viewH - 98, startGameSmallButtonScale, startGameSmallButtonScale, 0, c_black, 1);
				draw_sprite_ext(spr_button_background, 0, 32 + button_x_adjust_, viewH - 98 + button_y_adjust_, startGameSmallButtonScale, startGameSmallButtonScale, 0, c_white, 1);
			}
			else if mainMenuSettingsScreenActive {
				draw_sprite_ext(spr_main_menu_settings, 0, viewX, viewY, x_scale_, y_scale_, 0, c_white, 1);
				var main_button_text_ = "Mute Sound";
				var first_button_text_ = "Toggle Tutorial";
				var second_button_text_ = "Go Back";
			}
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
		else if mainMenuControlsScreenActive {
			var x_scale_ = sprite_get_width(spr_main_menu_controls) / viewW;
			var y_scale_ = sprite_get_height(spr_main_menu_controls) / viewH;
			var second_button_text_ = "Go Back";
			draw_sprite_ext(spr_main_menu_controls, 0, viewX, viewY, x_scale_, y_scale_, 0, c_white, 1)
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
}

