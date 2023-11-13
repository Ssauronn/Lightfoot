/// @description Adjust UI Values
iconAlpha += 0.01;
if iconAlpha > 1 {
	iconAlpha = 0.0;
}
if room == GameRoom {
	// Timer to make sure everything is initialized before. I set the value to exactly 0 once it drops
	// below 0, and then to -1 once the code executes, so that the code to initialize only executes once.
	// Any code that executes when the value is set to -1 is code that needs to be updated every frame.
	if gameStartTimer > 0 {
		gameStartTimer--;
		if gameStartTimer <= 0 {
			gameStartTimer = 0;
		}
	}
	if gameStartTimer == 0 {
		gameStartTimer = -1;
		if tutorialsActive {
			openingTutorialComplete = false;
			firstWolfSeenTutorialComplete = false;
			firstWolfSeenInPackTutorialComplete = false;
			firstTimeDugInSnowTutorialComplete = false;
			firstTimeWolfCanHearTutorialComplete = false;
			firstTimeEscapingWolvesTutorialComplete = false;
			firstTimeFindingNewBonfireTutorialComplete = false;
			lastBonfireReachedComplete = false;
			firstTimeAlmostFrozenTutorialComplete = false;
		}
		else {
			openingTutorialComplete = true;
			firstWolfSeenTutorialComplete = true;
			firstWolfSeenInPackTutorialComplete = true;
			firstTimeDugInSnowTutorialComplete = true;
			firstTimeWolfCanHearTutorialComplete = true;
			firstTimeEscapingWolvesTutorialComplete = true;
			firstTimeFindingNewBonfireTutorialComplete = true;
			lastBonfireReachedComplete = true;
			firstTimeAlmostFrozenTutorialComplete = true;
		}
	}
	if gameStartTimer == -1 {
		startGameButtonX = viewX + (viewW / 2) - (sprite_get_width(spr_button_background) / 2);
		startGameButtonY = viewY + (viewH / 2) - ((sprite_get_height(spr_button_background)) / 2);
		startGameSmallButtonX = startGameButtonX + ((sprite_get_width(spr_button_background) - (sprite_get_width(spr_button_background) * startGameSmallButtonScale)) / 2)
		startGameSmallButtonFirstY = startGameButtonY + (8 * (viewH / 32));
		startGameSmallButtonSecondY = startGameButtonY + (13 * (viewH / 32));
	}
	// Pause/Unpause the game with Escape key
	if keyboard_check_pressed(vk_escape) {
		pauseMenuActive = !pauseMenuActive;
	}
	if pauseMenuActive {
		gamePaused = true;
		if mouse_check_button(mb_left) {
			buttonHeldDown = true;
		}
		else {
			buttonHeldDown = false;
		}
		
		if buttonHeldDown {
			if point_in_rectangle(mouse_x, mouse_y, startGameButtonX, startGameButtonY, startGameButtonX + sprite_get_width(spr_button_background), startGameButtonY + sprite_get_height(spr_button_background) + (2 * (viewH / 32))) {
				startGameButtonClickedOn = 1;
			}
			else if point_in_rectangle(mouse_x, mouse_y, startGameSmallButtonX, startGameSmallButtonFirstY, startGameSmallButtonX + (sprite_get_width(spr_button_background) * startGameSmallButtonScale), startGameSmallButtonFirstY + (sprite_get_height(spr_button_background) * startGameSmallButtonScale)) {
				startGameButtonClickedOn = 2;
			}
			else if point_in_rectangle(mouse_x, mouse_y, startGameSmallButtonX, startGameSmallButtonSecondY, startGameSmallButtonX + (sprite_get_width(spr_button_background) * startGameSmallButtonScale), startGameSmallButtonSecondY + (sprite_get_height(spr_button_background) * startGameSmallButtonScale)) {
				startGameButtonClickedOn = 3;
			}
			else {
				startGameButtonClickedOn = 0;
			}
		}
		
		if mouse_check_button_released(mb_left) {
			switch startGameButtonClickedOn {
				case 1:
					pauseMenuActive = false;
					gamePaused = false;
					break;
				case 2:
					tutorialsActive = !tutorialsActive;
					if !tutorialsActive {
						openingTutorialComplete = true;
						firstWolfSeenTutorialComplete = true;
						firstWolfSeenInPackTutorialComplete = true;
						firstTimeDugInSnowTutorialComplete = true;
						firstTimeWolfCanHearTutorialComplete = true;
						firstTimeEscapingWolvesTutorialComplete = true;
						firstTimeFindingNewBonfireTutorialComplete = true;
						lastBonfireReachedComplete = true;
						firstTimeAlmostFrozenTutorialComplete = true;
					}
					break;
				case 3:
					playerDied = false;
					gameBeaten = false;
					deathText = "You Froze to Death."
					pauseMenuActive = false;
					gameStartTimer = 2;
					dialogueCharacterAppearTimerCurrentTime = 0;
					with obj_wolf {
						idleTimerCurrentTime = 0;
						searchingForDugInHareCurrentTimer = 0;
					}
					playerDiedTimerCurrentTime = 0;
					splashscreenActive = false;
					splashscreenOccured = true;
					splashscreenFadeInTimerCurrentTime = splashscreenFadeInTimerStartTime;
					splashscreenIdleTimerCurrentTime = splashscreenIdleTimerStartTime;
					openingTutorialComplete = true;
					firstWolfSeenTutorialComplete = true;
					firstWolfSeenInPackTutorialComplete = true;
					firstTimeDugInSnowTutorialComplete = true;
					firstTimeWolfCanHearTutorialComplete = true;
					firstTimeEscapingWolvesTutorialComplete = true;
					firstTimeFindingNewBonfireTutorialComplete = true;
					lastBonfireReachedComplete = true;
					firstTimeAlmostFrozenTutorialComplete = true;
					mainMenuActive = true;
					mainMenuSelectionScreenActive = true;
					mainMenuSettingsScreenActive = false;
					mainMenuControlsScreenActive = false;
					startGameButtonClickedOn = 0;
					buttonHeldDown = false;
					if !tutorialsActive {
						dialogueCharacterCount = 1;
						openingTutorialComplete = false;
						firstWolfSeenTutorialComplete = false;
						firstWolfSeenInPackTutorialComplete = false;
						firstTimeDugInSnowTutorialComplete = false;
						firstTimeWolfCanHearTutorialComplete = false;
						firstTimeEscapingWolvesTutorialComplete = false;
						firstTimeFindingNewBonfireTutorialComplete = false;
						lastBonfireReachedComplete = false;
						firstTimeAlmostFrozenTutorialComplete = false;
					}
					else {
						openingTutorialComplete = true;
						firstWolfSeenTutorialComplete = true;
						firstWolfSeenInPackTutorialComplete = true;
						firstTimeDugInSnowTutorialComplete = true;
						firstTimeWolfCanHearTutorialComplete = true;
						firstTimeEscapingWolvesTutorialComplete = true;
						firstTimeFindingNewBonfireTutorialComplete = true;
						lastBonfireReachedComplete = true;
						firstTimeAlmostFrozenTutorialComplete = true;
					}
					room_goto(MainMenu);
					break;
			}
		}
		
		// Reset the button variable
		if !mouse_check_button(mb_left) {
			startGameButtonClickedOn = 0;
		}
		
	}
	else {
		// If tutorials aren't active, then automatically unpause the game. Otherwise, the
		// game shouldn't necessarily unpause, because the player might be in the middle
		// of a tutorial.
		if !tutorialsActive {
			gamePaused = false;
		}
	}
	
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
			
			// If the player has reached the last Bonfire, then play a splash text to let them know.
			if objectiveCount >= instance_number(obj_bonfire) {
				gameBeaten = true;
			}
			else {
				gameBeaten = false;
			}
		}
		// If the player freezes to death, play the death screen
		if freezeBarHitZero {
			playerDied = true;
		}
		
		// Player death menu
		if playerDied {
			pauseMenuActive = false;
			tutorialsActive = false;
			// Play the fade to black screen if it hasn't been played yet
			if playerDiedTimerCurrentTime < playerDiedTimerStartTime {
				playerDiedTimerCurrentTime++;
				percentToFadeToDeathScreen = playerDiedTimerCurrentTime / playerDiedTimerStartTime;
			}
			if playerDiedTimerCurrentTime >= playerDiedTimerStartTime {
				deathScreenActive = true;
			}
			
			// After the fade screen has been played, display buttons
			if deathScreenActive {
				tutorialsActive = false;
				openingTutorialComplete = true;
				firstWolfSeenTutorialComplete = true;
				firstWolfSeenInPackTutorialComplete = true;
				firstTimeDugInSnowTutorialComplete = true;
				firstTimeWolfCanHearTutorialComplete = true;
				firstTimeEscapingWolvesTutorialComplete = true;
				firstTimeFindingNewBonfireTutorialComplete = true;
				lastBonfireReachedComplete = true;
				firstTimeAlmostFrozenTutorialComplete = true;
				pauseMenuActive = false;
				gamePaused = false;
				if mouse_check_button(mb_left) {
					buttonHeldDown = true;
				}
				else {
					buttonHeldDown = false;
				}
				if mouse_check_button(mb_left) {
					if point_in_rectangle(mouse_x, mouse_y, startGameSmallButtonX, startGameSmallButtonSecondY, startGameSmallButtonX + (sprite_get_width(spr_button_background) * startGameSmallButtonScale), startGameSmallButtonSecondY + (sprite_get_height(spr_button_background) * startGameSmallButtonScale)) {
						startGameButtonClickedOn = 3;
					}
					else {
						startGameButtonClickedOn = 0;
					}
				}
				
				if mouse_check_button_released(mb_left) {
					if startGameButtonClickedOn == 3 {
						gameBeaten = false;
						deathText = "You Froze to Death."
						gameStartTimer = 2;
						playerDied = false;
						dialogueCharacterAppearTimerCurrentTime = 0;
						dialogueCharacterCount = 1;
						with obj_wolf {
							idleTimerCurrentTime = 0;
							searchingForDugInHareCurrentTimer = 0;
						}
						playerDiedTimerCurrentTime = 0;
						splashscreenActive = false;
						splashscreenOccured = true;
						splashscreenFadeInTimerCurrentTime = splashscreenFadeInTimerStartTime;
						splashscreenIdleTimerCurrentTime = splashscreenIdleTimerStartTime;
						tutorialsActive = false;
						openingTutorialComplete = true;
						firstWolfSeenTutorialComplete = true;
						firstWolfSeenInPackTutorialComplete = true;
						firstTimeDugInSnowTutorialComplete = true;
						firstTimeWolfCanHearTutorialComplete = true;
						firstTimeEscapingWolvesTutorialComplete = true;
						firstTimeFindingNewBonfireTutorialComplete = true;
						lastBonfireReachedComplete = true;
						firstTimeAlmostFrozenTutorialComplete = true;
						mainMenuActive = true;
						mainMenuSelectionScreenActive = true;
						mainMenuSettingsScreenActive = false;
						mainMenuControlsScreenActive = false;
						startGameButtonClickedOn = 0;
						buttonHeldDown = false;
						room_goto(MainMenu);
					}
				}
			}
		}
		#endregion
	}
}
else if room == MainMenu {
	// Timer to make sure everything is initialized before. I set the value to exactly 0 once it drops
	// below 0, and then to -1 once the code executes, so that the code to initialize only executes once.
	if gameStartTimer > 0 {
		gameStartTimer--;
	}
	if gameStartTimer <= 0 {
		startGameButtonX = viewX + (viewW / 2) - (sprite_get_width(spr_button_background) / 2);
		startGameButtonY = viewY + (viewH / 2) - ((sprite_get_height(spr_button_background)) / 2);
		startGameSmallButtonX = startGameButtonX + ((sprite_get_width(spr_button_background) - (sprite_get_width(spr_button_background) * startGameSmallButtonScale)) / 2)
		startGameSmallButtonFirstY = startGameButtonY + (8 * (viewH / 32));
		startGameSmallButtonSecondY = startGameButtonY + (13 * (viewH / 32));
	}
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
			if mouse_check_button(mb_left) {
				if point_in_rectangle(mouse_x, mouse_y, startGameButtonX, startGameButtonY, startGameButtonX + sprite_get_width(spr_button_background), startGameButtonY + sprite_get_height(spr_button_background) + (2 * (viewH / 32))) {
					startGameButtonClickedOn = 1;
				}
				else if point_in_rectangle(mouse_x, mouse_y, startGameSmallButtonX, startGameSmallButtonFirstY, startGameSmallButtonX + (sprite_get_width(spr_button_background) * startGameSmallButtonScale), startGameSmallButtonFirstY + (sprite_get_height(spr_button_background) * startGameSmallButtonScale)) {
					startGameButtonClickedOn = 2;
				}
				else if point_in_rectangle(mouse_x, mouse_y, startGameSmallButtonX, startGameSmallButtonSecondY, startGameSmallButtonX + (sprite_get_width(spr_button_background) * startGameSmallButtonScale), startGameSmallButtonSecondY + (sprite_get_height(spr_button_background) * startGameSmallButtonScale)) {
					startGameButtonClickedOn = 3;
				}
				else {
					startGameButtonClickedOn = 0;
				}
			}
			
			// Check for button click on quit button
			if mouse_check_button(mb_left) {
				if point_in_rectangle(mouse_x, mouse_y, 32, viewH - 98, 32 + (sprite_get_width(spr_button_background) * startGameSmallButtonScale), (viewH - 98) + (sprite_get_height(spr_button_background) * startGameSmallButtonScale)) {
					startGameButtonClickedOn = 4;
				}
			}
			
			// Send to proper state once button is released
			if mouse_check_button_released(mb_left) {
				switch startGameButtonClickedOn {
					case 1:
						gameBeaten = false;
						deathText = "You Froze to Death."
						gameStartTimer = 2;
						mainMenuActive = false;
						mainMenuSelectionScreenActive = false;
						mainMenuSettingsScreenActive = false;
						mainMenuControlsScreenActive = false;
						startGameButtonClickedOn = 0;
						room_goto_next();
						break;
					case 2:
						mainMenuSelectionScreenActive = false;
						mainMenuSettingsScreenActive = true;
						startGameButtonClickedOn = 0;
						break;
					case 3:
						mainMenuSelectionScreenActive = false;
						mainMenuControlsScreenActive = true;
						startGameButtonClickedOn = 0;
						break;
					case 4:
						game_end();
						break;
				}
			}
			
			// Reset the button variable
			if !mouse_check_button(mb_left) {
				startGameButtonClickedOn = 0;
			}
		}
		else if mainMenuSettingsScreenActive {
			// Check for button clicks on button locations.
			// If button clicks occur, set different selection screens as active, or adjust available settings.
			if point_in_rectangle(mouse_x, mouse_y, startGameButtonX, startGameButtonY, startGameButtonX + sprite_get_width(spr_button_background), startGameButtonY + sprite_get_height(spr_button_background) + (2 * (viewH / 32))) {
				startGameButtonClickedOn = 1;
			}
			else if point_in_rectangle(mouse_x, mouse_y, startGameSmallButtonX, startGameSmallButtonFirstY, startGameSmallButtonX + (sprite_get_width(spr_button_background) * startGameSmallButtonScale), startGameSmallButtonFirstY + (sprite_get_height(spr_button_background) * startGameSmallButtonScale)) {
				startGameButtonClickedOn = 2;
			}
			else if point_in_rectangle(mouse_x, mouse_y, startGameSmallButtonX, startGameSmallButtonSecondY, startGameSmallButtonX + (sprite_get_width(spr_button_background) * startGameSmallButtonScale), startGameSmallButtonSecondY + (sprite_get_height(spr_button_background) * startGameSmallButtonScale)) {
				startGameButtonClickedOn = 3;
			}
			else {
				startGameButtonClickedOn = 0;
			}
			
			// Send to proper state once button is released
			if mouse_check_button_released(mb_left) {
				switch startGameButtonClickedOn {
					case 1:
						soundMute = !soundMute;
						startGameButtonClickedOn = 0;
						break;
					case 2:
						tutorialsActive = !tutorialsActive;
						if !tutorialsActive {
							openingTutorialComplete = true;
							firstWolfSeenTutorialComplete = true;
							firstWolfSeenInPackTutorialComplete = true;
							firstTimeDugInSnowTutorialComplete = true;
							firstTimeWolfCanHearTutorialComplete = true;
							firstTimeEscapingWolvesTutorialComplete = true;
							firstTimeFindingNewBonfireTutorialComplete = true;
							lastBonfireReachedComplete = true;
							firstTimeAlmostFrozenTutorialComplete = true;
						}
						break;
					case 3:
						mainMenuSelectionScreenActive = true;
						mainMenuSettingsScreenActive = false;
						startGameButtonClickedOn = 0;
						break;
				}
			}
			
			// Reset the button variable
			if !mouse_check_button(mb_left) {
				startGameButtonClickedOn = 0;
			}
		}
		else if mainMenuControlsScreenActive {
			// Check for button click going back to Main Selection Screen.
			// Everything else in this screen is read only.
			if point_in_rectangle(mouse_x, mouse_y, startGameSmallButtonX, startGameSmallButtonSecondY, startGameSmallButtonX + (sprite_get_width(spr_button_background) * startGameSmallButtonScale), startGameSmallButtonSecondY + (sprite_get_height(spr_button_background) * startGameSmallButtonScale)) {
				startGameButtonClickedOn = 3;
			}
			else {
				startGameButtonClickedOn = 0;
			}
			
			// Send to proper state once button is released
			if mouse_check_button_released(mb_left) {
				if startGameButtonClickedOn == 3 {
					mainMenuSelectionScreenActive = true;
					mainMenuControlsScreenActive = false;
					startGameButtonClickedOn = 0;
				}
			}
			
			// Reset the button variable
			if !mouse_check_button(mb_left) {
				startGameButtonClickedOn = 0;
			}
		}
	}
}


