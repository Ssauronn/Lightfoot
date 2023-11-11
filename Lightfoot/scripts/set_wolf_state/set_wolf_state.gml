///@function set_wolf_state();
///@description Sets the Wolf current action (state) based on various positional variables
///				and player state variables.
function set_wolf_state() {
	// Check to see if the Wolf is on screen, and if so, mark it as such.
	if point_in_rectangle(x + (sprite_get_width(sprite_index) / 2), y + (sprite_get_height(sprite_index) / 2), viewX, viewY, viewX + viewW, viewY + viewH) {
		if obj_player.playerCurrentForm != forms.snowharedugin {
			canSeePlayer = true;
		}
		else {
			/* 
			   Check to see if the Wolf's current state is hunting, because if so, this would mean
			   the player recently dug in and I shouldn't mark the Wolf as "not seeing the player".
		   
			   Specifically, check to make sure the wolf isn't hunting for the Snow Hare in either
			   state, or the human, or small patrolling (which is looking for the dug in Snow Hare).
		   
			   This should never activate until after a Wolf has completed searching for the player,
			   because if the Wolf is on screen, it will always be in some sort of hunting state unless
			   the player has been dug in for a while.
			*/
			if ((wolfCurrentAction != wolfActionState.huntingharetop) && (wolfCurrentAction != wolfActionState.huntingharedugin) && (wolfCurrentAction != wolfActionState.huntinghuman) && (wolfCurrentAction != wolfActionState.smallpatrol)) {
				// If the wolf isn't hunting for the player in any way, then mark it as "not seeing
				// the player".
				canSeePlayer = false;
			}
		}
	}
	// Else if the Wolf isn't on screen, check to see if the Wolf can at least smell the player
	else {
		isOnScreen = false;
		// If the Wolf is not on screen yet, and the player has dug into the snow, it's too far away
		// and should not continue searching.
		if obj_player.playerCurrentForm == forms.snowharedugin {
			canSeePlayer = false;
			// If the Wolf isn't already patrolling, it needs to return to it's patrol route.
			if wolfCurrentAction != wolfActionState.bigpatrol {
				wolfCurrentAction = wolfActionState.returntopatrol;
				idleStateToReturnTo = wolfActionState.bigpatrol;
				targetToMoveToX = wolfRandomPatrolRouteX;
				targetToMoveToY = wolfRandomPatrolRouteY;
				wolfReturnToPatrolStart = false;
			}
		}
		// As long as the Wolf isn't both patrolling already and the player's current form is dug into snow,
		// check to see if the Wolf can smell the player in Snow Hare form, and if so, mark it as such
		else if point_distance(x, y, target.x, target.y) <= smellRange {
			if obj_player.playerCurrentForm == forms.snowharetop {
				canSeePlayer = true;
			}
			else {
				canSeePlayer = false;
			}
		}
		else {
			canSeePlayer = false;
		}
	}

	// If the Wolf can see (or smell) the player, adjust various variables.
	if canSeePlayer {
		// If the player is in human form
		if obj_player.playerCurrentForm == forms.human {
			currentMaxSpeed = maxWalkSpeed;
			// If the Wolf is in a pack, set variables differently than otherwise.
			if inPack {
				wolfCurrentAction = wolfActionState.huntinghuman;
			}
			else {
				wolfCurrentAction = wolfActionState.circlehuman;
			}
		}
		// Else if the player is in Snow Hare form on top of the snow
		else if obj_player.playerCurrentForm == forms.snowharetop {
			wolfCurrentAction = wolfActionState.huntingharetop;
		}
		// Else if the player is in Snow Hare form, dug into the snow, and the 
		// Wolf is confirmed to be on screen
		else if (obj_player.playerCurrentForm == forms.snowharedugin) && (isOnScreen) {
			// If the Wolf's current action is currently hunting a Snow Hare on top, then
			// this means it's the Wolf's first time being sent to this phase and I should
			// change the state.
			if wolfCurrentAction == wolfActionState.huntingharetop {
				wolfCurrentAction = wolfActionState.huntingharedugin;
			}
		}
	}
	// Else if the Wolf can't see the player
	else if (idleStateToReturnTo != wolfActionState.smallpatrol) && (idleStateToReturnTo != wolfActionState.bigpatrol) {
		if wolfCurrentAction != wolfActionState.bigpatrol {
			wolfCurrentAction = wolfActionState.returntopatrol;
			idleStateToReturnTo = wolfActionState.bigpatrol;
			targetToMoveToX = wolfRandomPatrolRouteX;
			targetToMoveToY = wolfRandomPatrolRouteY;
			wolfReturnToPatrolStart = false;
		}
	}
	
	// Finally, check to see if the Wolf has already reached the player's last known location and is
	// now searching for the dug in player, and the timer for that search has ran out
	if (wolfCurrentAction == wolfActionState.smallpatrol) && (searchingForDugInHareCurrentTimer <= 0) {
		canSeePlayer = false;
		wolfCurrentAction = wolfActionState.returntopatrol;
		idleStateToReturnTo = wolfActionState.bigpatrol;
		targetToMoveToX = wolfRandomPatrolRouteX;
		targetToMoveToY = wolfRandomPatrolRouteY;
		wolfReturnToPatrolStart = false;
	}
	
	/// Runs the correct action script based on the state set above.
	switch wolfCurrentAction {
		case wolfActionState.idle:
			wolf_idle();
			break;
		case wolfActionState.circlehuman:
			wolf_circle_human();
			break;
		case wolfActionState.huntinghuman:
			wolf_hunt_human();
			break;
		case wolfActionState.huntingharetop:
			wolf_hunt_hare_top();
			break;
		case wolfActionState.huntingharedugin:
			wolf_hunt_hare_dug_in();
			break;
		case wolfActionState.bigpatrol:
			wolf_big_patrol();
			break;
		case wolfActionState.smallpatrol:
			wolf_small_patrol();
			break;
		case wolfActionState.returntopatrol:
			wolf_return_to_patrol();
			break;
	}
}