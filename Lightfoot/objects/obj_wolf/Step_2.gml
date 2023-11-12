/// @description Adjust Variables After Step
if !gamePaused {
	// Set delta time variable
	var dt_ = delta_time / 1000000;

	// Set Wolf animation sprite
	sprite_index = wolfSprite[wolfCurrentMoveState, wolfCurrentDirection];

	// Check after movement to make sure it's still on screen. If it's not, mark it as such.
	if rectangle_in_rectangle(x, y, x + sprite_get_width(sprite_index), y + sprite_get_height(sprite_index), viewX + 128, viewY + 128, viewX + viewW - 128 - sprite_width, viewY + viewH - 128 - sprite_height) != 0 {
		isOnScreen = true;
	}
	else {
		isOnScreen = false;
	}

	// Check to see if any other wolves can see the player, and if so, mark the Wolf as in a pack.
	if canSeePlayer {
		// If all Wolves haven't been checked yet, go through each Wolf.
		if !checkedIfOnScreen {
			checkedIfOnScreen = true;
			with obj_wolf {
				var self_id_ = id;
				inPack = false;
				with obj_wolf {
					if isOnScreen || (obj_player.playerCurrentForm == forms.snowharetop && canSeePlayer) {
						if self.id != self_id_ {
							self_id_.inPack = true;
						}
					}
				}
			}
		}
	}
}


