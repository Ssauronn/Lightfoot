///@function move_wolf(target_x_, target_y_);
function move_wolf(x_, y_) {
	// Set max movement speed based on the Wolf's current state
	switch wolfCurrentAction {
		case wolfActionState.idle:
			currentMaxSpeed = 0;
			currentSpeed = 0;
			break;
		case wolfActionState.circlehuman:
			currentMaxSpeed = maxWalkSpeed / 2;
			break;
		case wolfActionState.huntinghuman:
			currentMaxSpeed = maxWalkSpeed;
			break;
		case wolfActionState.huntingharetop:
			currentMaxSpeed = maxRunSpeed;
			break;
		case wolfActionState.huntingharedugin:
			currentMaxSpeed = maxRunSpeed;
			break;
		case wolfActionState.bigpatrol:
			currentMaxSpeed = maxWalkSpeed / 2;
			break;
		case wolfActionState.smallpatrol:
			currentMaxSpeed = maxWalkSpeed / 4;
			break;
		case wolfActionState.returntopatrol:
			currentMaxSpeed = maxRunSpeed;
			break;
	}
	
	/// Set variables for the sprite table
	// As long as the wolf isn't idling, or patrolling, then set the
	// Wolf direction equal to the player direction.
	if ((wolfCurrentAction != wolfActionState.idle) && (wolfCurrentAction != wolfActionState.huntingharedugin) && (wolfCurrentAction != wolfActionState.bigpatrol) && (wolfCurrentAction != wolfActionState.smallpatrol) && (wolfCurrentAction != wolfActionState.returntopatrol)) {
		
	}
}