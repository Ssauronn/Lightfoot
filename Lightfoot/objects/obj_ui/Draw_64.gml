/// @description Draw To GUI
// Delta Time
var dt_ = delta_time / 1000000;

if room == GameRoom {
	/// Freeze Bar
	if freezeBarActive {
		if !freezeBarHitZero {
			var freeze_bar_x_ = 32;
			var freeze_bar_y_ = 32;
			var percent_to_draw_ = (freezeBarCurrentValue / freezeBarMaxValue) * sprite_get_width(spr_freeze_bar_foreground);
			/// ADJUST - the color here should be set by a shader that rotates from orange to deep blue
			var color_of_freeze_bar_ = c_red;
			draw_sprite(spr_freeze_bar_border, 0, freeze_bar_x_ - 10, freeze_bar_y_ - 10);
			draw_sprite(spr_freeze_bar_background, 0, freeze_bar_x_, freeze_bar_y_);
		
			// Shader to shift color of Freeze Bar status
			shader_set(shd_shift_color_blue);
			var uniform_percentage_ = shader_get_uniform(shd_shift_color_blue, "freeze_bar_percentage");
			shader_set_uniform_f(uniform_percentage_, (freezeBarCurrentValue / freezeBarMaxValue));
			// Draw the Freeze Bar status using a shader
			draw_sprite_part_ext(spr_freeze_bar_foreground, 0, 0, 0, percent_to_draw_, sprite_get_height(spr_freeze_bar_foreground), freeze_bar_x_, freeze_bar_y_, 1, 1, color_of_freeze_bar_, 1);
			// Reset the shader
			shader_reset();
		}
	}

	/// Tutorials
	if tutorialsActive && !pauseMenuActive {
		#region Beginning Tutorial
		if !openingTutorialComplete {
			// Execute the opening tutorial once the game starts and is initialized.
			dialogueTreeMaxChain = ds_grid_get(tutorialsGrid, 1, 0);
			if gameStartTimer <= 0 {
				gamePaused = true;
				if dialogueTreeCurrentChain == 2 {
					draw_sprite_ext(spr_glow_inner, 0, 32 + (sprite_get_width(spr_freeze_bar_foreground) / 2), 32 + (sprite_get_height(spr_freeze_bar_foreground) / 2), 0.5, 0.5, 0, c_blue, iconAlpha);
				}
				play_dialogue(ds_grid_get(tutorialsGrid, 3, (0 + dialogueTreeCurrentChain - 1)));
				if dialogueTreeCurrentChain > dialogueTreeMaxChain {
					dialogueTreeCurrentChain = 1;
					gamePaused = false;
					openingTutorialComplete = true;
				}
			}
		}
		#endregion
		#region First Wolf Tutorial
		if !firstWolfSeenTutorialComplete {
			// Execute the tutorial explaining wolf behavior
			dialogueTreeMaxChain = ds_grid_get(tutorialsGrid, 1, 5);
			var wolf_on_screen_ = false;
			with obj_wolf {
				if isOnScreen {
					wolf_on_screen_ = true;
					break;
				}
			}
			if (wolf_on_screen_) && (openingTutorialComplete) {
				gamePaused = true;
				play_dialogue(ds_grid_get(tutorialsGrid, 3, (5 + dialogueTreeCurrentChain - 1)));
				if dialogueTreeCurrentChain > dialogueTreeMaxChain {
					dialogueTreeCurrentChain = 1;
					gamePaused = false;
					firstWolfSeenTutorialComplete = true;
				}
			}
		}
		#endregion
		#region Snow Hare Form Tutorial
		if !firstWolfSeenInPackTutorialComplete {
			// Execute the tutorial explaining wolf behavior
			dialogueTreeMaxChain = ds_grid_get(tutorialsGrid, 1, 6);
			var wolf_in_pack_ = false;
			with obj_wolf {
				if inPack {
					wolf_in_pack_ = true;
					break;
				}
			}
			if (wolf_in_pack_) && (openingTutorialComplete) && (firstWolfSeenTutorialComplete) {
				gamePaused = true;
				play_dialogue(ds_grid_get(tutorialsGrid, 3, (6 + dialogueTreeCurrentChain - 1)));
				if dialogueTreeCurrentChain > dialogueTreeMaxChain {
					dialogueTreeCurrentChain = 1;
					gamePaused = false;
					firstWolfSeenInPackTutorialComplete = true;
					// After the standard tutorial setting, I force the player into Snow Hare form.
					with obj_player{
						formCooldown = formMaxCooldown;
						playerCurrentForm = forms.snowharetop;
					}
				}
			}
		}
		#endregion
		#region Snow Hare Digging Tutorial
		if !firstTimeDugInSnowTutorialComplete {
			// Execute the tutorial explaining hiding in the snow
			dialogueTreeMaxChain = ds_grid_get(tutorialsGrid, 1, 9);
			var nearest_wolf_ = instance_nearest(obj_player.x + (sprite_get_width(obj_player.sprite_index) / 2), obj_player.y + (sprite_get_height(obj_player.sprite_index) / 2), obj_wolf)
			var wolf_range_ = point_distance(obj_player.x, obj_player.y, nearest_wolf_.x, nearest_wolf_.y);
			var wolf_within_range_ = false;
			if wolf_range_ <= (viewW / 8) {
				wolf_within_range_ = true;
			}
			if (wolf_within_range_) && (openingTutorialComplete) && (firstWolfSeenTutorialComplete) && (firstWolfSeenInPackTutorialComplete) {
				gamePaused = true;
				play_dialogue(ds_grid_get(tutorialsGrid, 3, (9 + dialogueTreeCurrentChain - 1)));
				if dialogueTreeCurrentChain > dialogueTreeMaxChain {
					dialogueTreeCurrentChain = 1;
					gamePaused = false;
					firstTimeDugInSnowTutorialComplete = true;
					// After the standard tutorial setting, I force the player into digging into the snow.
					with obj_player{
						formCooldown = formMaxCooldown;
						playerCurrentForm = forms.snowharedugin;
					}
					lastKnownX = nearest_wolf_.x;
					lastKnownY = nearest_wolf_.y;
				}
			}
		}
		#region Wolf Hearing Tutorial
		if !firstTimeWolfCanHearTutorialComplete {
			if (obj_player.playerCurrentForm == forms.snowharedugin) || (obj_player.playerCurrentForm == forms.snowharetop) {
				// Execute the tutorial explaining hiding in the snow
				dialogueTreeMaxChain = ds_grid_get(tutorialsGrid, 1, 11);
				var nearest_wolf_ = instance_nearest(obj_player.x + (sprite_get_width(obj_player.sprite_index) / 2), obj_player.y + (sprite_get_height(obj_player.sprite_index) / 2), obj_wolf)
				var wolf_range_ = point_distance(obj_player.x, obj_player.y, nearest_wolf_.x, nearest_wolf_.y);
				var wolf_within_range_ = false;
				if wolf_range_ <= (viewW / 12) {
					wolf_within_range_ = true;
				}
				if (wolf_within_range_) && (openingTutorialComplete) && (firstWolfSeenTutorialComplete) && (firstWolfSeenInPackTutorialComplete) && (firstTimeDugInSnowTutorialComplete) {
					gamePaused = true;
					play_dialogue(ds_grid_get(tutorialsGrid, 3, (11 + dialogueTreeCurrentChain - 1)));
					if dialogueTreeCurrentChain > dialogueTreeMaxChain {
						// After the standard tutorial setting, I force the player into digging into the snow.
						with obj_player{
							formCooldown = formMaxCooldown;
							playerCurrentForm = forms.snowharedugin;
						}
						lastKnownX = nearest_wolf_.x;
						lastKnownY = nearest_wolf_.y;
						dialogueTreeCurrentChain = 1;
						gamePaused = false;
						firstTimeWolfCanHearTutorialComplete = true;
					}
				}
			}
		}
		#endregion
		#region Wolves Given Up Tutorial
		if !firstTimeEscapingWolvesTutorialComplete {
			// Execute the tutorial explaining hiding in the snow
			dialogueTreeMaxChain = ds_grid_get(tutorialsGrid, 1, 12);
			var all_wolves_have_given_up_ = true;
			with obj_wolf {
				if (canSeePlayer) || (wolfCurrentAction == wolfActionState.smallpatrol) || ((wolfCurrentAction == wolfActionState.idle) && (idleStateToReturnTo == wolfActionState.smallpatrol)) {
					all_wolves_have_given_up_ = false;
				}
			}
			if (all_wolves_have_given_up_) && (openingTutorialComplete) && (firstWolfSeenTutorialComplete) && (firstWolfSeenInPackTutorialComplete) && (firstTimeDugInSnowTutorialComplete) {
				gamePaused = true;
				play_dialogue(ds_grid_get(tutorialsGrid, 3, (12 + dialogueTreeCurrentChain - 1)));
				if dialogueTreeCurrentChain > dialogueTreeMaxChain {
					dialogueTreeCurrentChain = 1;
					gamePaused = false;
					firstTimeEscapingWolvesTutorialComplete = true;
				}
			}
		}
		#endregion
		#region Bonfire Tutorial
		if !firstTimeFindingNewBonfireTutorialComplete {
			dialogueTreeMaxChain = ds_grid_get(tutorialsGrid, 1, 15);
			var has_reached_bonfire_ = false;
			if objectiveCount == 2 {
				has_reached_bonfire_ = true;
			}
			// I don't check for any other tutorial except the beginning tutorial here, because it is technically possible
			// the player reaches the next bonfire without seeing a Wolf due to patrol routes and careful play.
			if (has_reached_bonfire_) && (firstTimeEscapingWolvesTutorialComplete) {
				gamePaused = true;
				play_dialogue(ds_grid_get(tutorialsGrid, 3, (15 + dialogueTreeCurrentChain - 1)));
				if dialogueTreeCurrentChain > dialogueTreeMaxChain {
					dialogueTreeCurrentChain = 1;
					gamePaused = false;
					firstTimeFindingNewBonfireTutorialComplete = true;
				}
			}
		}
		#endregion
		#region Almost Frozen Tutorial
		if !firstTimeAlmostFrozenTutorialComplete {
			dialogueTreeMaxChain = ds_grid_get(tutorialsGrid, 1, 18);
			var almost_frozen_ = false;
			if (freezeBarCurrentValue / freezeBarMaxValue) <= 0.25 {
				almost_frozen_ = true;
			}
			// I don't check for any other tutorial except the beginning tutorial here, because it is technically possible
			// the player reaches the next bonfire without seeing a Wolf due to patrol routes and careful play.
			if (almost_frozen_) {
				gamePaused = true;
				play_dialogue(ds_grid_get(tutorialsGrid, 3, (18 + dialogueTreeCurrentChain - 1)));
				if dialogueTreeCurrentChain > dialogueTreeMaxChain {
					dialogueTreeCurrentChain = 1;
					gamePaused = false;
					firstTimeAlmostFrozenTutorialComplete = true;
				}
			}
		}
		#endregion
		#region Game Complete Dialogue
		if !lastBonfireReachedComplete {
			dialogueTreeMaxChain = ds_grid_get(tutorialsGrid, 1, 17);
			if gameStartTimer <= 0 {
				if objectiveCount >= instance_number(obj_bonfire) {
					play_dialogue(ds_grid_get(tutorialsGrid, 3, (17 + dialogueTreeCurrentChain - 1)));
					if dialogueTreeCurrentChain > dialogueTreeMaxChain {
						dialogueTreeCurrentChain = 1;
						lastBonfireReachedComplete = true;
					}
				}
			}
		}
		#endregion
		#endregion
	}
	// Only disable tutorials if tutorials are disabled in settings
	else if !tutorialsActive {
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


