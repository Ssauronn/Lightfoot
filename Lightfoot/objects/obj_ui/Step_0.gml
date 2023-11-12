/// @description Adjust UI Values
// Pause/Unpause the game with Escape key
if keyboard_check_pressed(vk_escape) {
	gamePaused = !gamePaused;
}
// Timer to make sure everything is initialized before 
if gameStartTimer > 0 {
	gameStartTimer--;
}

if room == GameRoom {
	// Execute regular code as long as the game isn't paused
	if !gamePaused {
		/// Setting delta time
		var dt_ = delta_time / 1000000;
	
		#region Freeze Bar
		/// Count down Freeze Bar timer if the player is freezing
		// Set initial variables
		var nearest_bonfire_ = find_nearest_bonfire(obj_player.x, obj_player.y).id;
		var bonfire_x_ = nearest_bonfire_.x;
		var bonfire_y_ = nearest_bonfire_.y;

		// Check to see if the player isn't currently a Snow Hare on top of the snow, and isn't
		// within a specific range of a bonfire, and if that's the case, then tick down the Freeze Bar.
		if (obj_player.playerCurrentForm != forms.snowharetop) && (abs(point_distance(obj_player.x, obj_player.y, bonfire_x_, bonfire_y_)) > warmthDistance) {
			if freezeBarActive && freezeBarDecays {
				if (freezeBarCurrentValue > 0) {
					freezeBarCurrentValue -= min(dt_, 1 / room_speed);
				}
				else if !freezeBarHitZero {
					freezeBarHitZero = true;
				}
			}
		}
		// If the player is within range of a bonfire, mark it as such, and change objectives if needed.
		else if (abs(point_distance(obj_player.x, obj_player.y, bonfire_x_, bonfire_y_)) <= warmthDistance) {
			if nearest_bonfire_.objective == objectiveCount {
				objectiveCount++;
			}
			if freezeBarCurrentValue < freezeBarMaxValue {
				freezeBarCurrentValue += min(freezeBarMaxValue - freezeBarCurrentValue, dt_ * (freezeBarMaxValue / warmthRegeneration));
			}
		}
		#endregion
	}
}
else if room == MainMenu {
	// Play the splash screen if it hasn't been played yet.
	if !splashscreenOccured {
		splashscreenActive = true;
		if splashscreenFadeInTimerCurrentTime < splashscreenFadeInTimerStartTime {
			splashscreenFadeInTimerCurrentTime++;
			percentToFadeSplashScreen = splashscreenFadeInTimerCurrentTime / splashscreenFadeInTimerStartTime;
		}
		else {
			if splashscreenIdleTimerCurrentTime < splashscreenIdleTimerStartTime {
				splashscreenIdleTimerCurrentTime++;
			}
		}
		if (splashscreenFadeInTimerCurrentTime >= splashscreenFadeInTimerStartTime) && (splashscreenIdleTimerCurrentTime >= splashscreenIdleTimerStartTime) {
			// This will execute once the splash screen finishes. This is where the main menu goes.
			mainMenuActive = true;
			mainMenuSelectionScreenActive = true;
			splashscreenOccured = true;
			splashscreenActive = false;
		}
	}
	// After the splash screen has been played, execute the main menu code
	else if mainMenuActive {
		if mouse_check_button(mb_left) {
			buttonHeldDown = true;
		}
		else {
			buttonHeldDown = false;
		}
		if mainMenuSelectionScreenActive {
			// Check for button clicks on button locations.
			// If button clicks occur, set different selection screens as active.
			
		}
		else if mainMenuSettingsScreenActive {
			// Check for button clicks on button locations.
			// If button clicks occur, set different selection screens as active, or adjust available settings.
			
		}
		else if mainMenuControlsScreenActive {
			// Check for button click going back to Main Selection Screen.
			// Everything else in this screen is read only.
			
		}
	}
}


