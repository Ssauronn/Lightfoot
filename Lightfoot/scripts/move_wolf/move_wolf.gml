///@function move_wolf(target_x_, target_y_);
function move_wolf(x_, y_) {
	// Delta time
	var dt_ = delta_time / 1000000;
	
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
			currentMaxSpeed = maxWalkSpeed;
			break;
		case wolfActionState.bigpatrol:
			currentMaxSpeed = maxWalkSpeed / 3;
			break;
		case wolfActionState.smallpatrol:
			currentMaxSpeed = maxWalkSpeed / 4;
			break;
		case wolfActionState.returntopatrol:
			currentMaxSpeed = maxRunSpeed;
			break;
	}
	// Set the acceleration value for the Wolf based on it's current max speed allowed.
	wolfAcceleration = currentMaxSpeed * 4;
	
	/// Set variables for the sprite table
	// As long as the wolf isn't idling, set the Wolf direction facing equal to the direction
	// from the Wolf to the provided x_ and y_ values.
	if wolfCurrentAction != wolfActionState.idle {
		set_wolf_direction(x_, y_);
	}
	// Otherwise, if the Wolf is idle, don't move at all and just exit this movement function.
	else {
		currentMaxSpeed = 0;
		currentSpeed = 0;
		wolfAcceleration = 0;
		exit;
	}
	
	// After everything else is set, finally, add to the current speed using the acceleration
	// and then move the Wolf towards it's target using that speed.
	if currentSpeed < currentMaxSpeed {
		currentSpeed += wolfAcceleration * dt_;
	}
	if currentSpeed > currentMaxSpeed {
		currentSpeed = currentMaxSpeed;
	}
	// Add the minimum of either the current speed times the delta time, or max move speed,
	// so that a frame stutter doesn't blast the object forward.
	x += lengthdir_x(min(currentSpeed * dt_, currentMaxSpeed / room_speed), point_direction(x, y, x_, y_));
	y += lengthdir_y(min(currentSpeed * dt_, currentMaxSpeed / room_speed), point_direction(x, y, x_, y_));
}