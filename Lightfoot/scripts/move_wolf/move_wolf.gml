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
		case wolfActionState.huntingharetop:
			currentMaxSpeed = maxRunSpeed * 0.85;
			break;
		case wolfActionState.huntingharedugin:
			currentMaxSpeed = maxWalkSpeed * 0.75;
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
	// Separate check and setting for hunting the human based on whether the Wolf is in a pack
	// or not.
	if wolfCurrentAction == wolfActionState.huntinghuman {
		if inPack {
			currentMaxSpeed = maxRunSpeed;
		}
		else {
			currentMaxSpeed = maxWalkSpeed;
		}
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
	
	// X and Y vector to move the Wolf. These are adjusted by avoidance from other Wolves.
	var x_vector_ = lengthdir_x(min(currentSpeed * dt_, currentMaxSpeed / room_speed), point_direction(x, y, x_, y_));
	var y_vector_ = lengthdir_y(min(currentSpeed * dt_, currentMaxSpeed / room_speed), point_direction(x, y, x_, y_));
	
	// Check for nearest wolf object by temporarily shifting the Wolf away from it's position,
	// then checking for an instance of the nearest Wolf object to it's original position,
	// finally followed by moving back to it's original position.
	// This doesn't execute if the Wolf is patrolling, to avoid weird quirks in pathfinding.
	var nearest_object_, original_x_;
	original_x_ = x;
	var distance_to_check_for_ = (sprite_get_width(sprite_index) * 1.5) + 1;
	x += distance_to_check_for_;
	nearest_object_ = instance_nearest(original_x_, y, object_index);
	// If the nearest object found is not itself, then that means it should execute avoidance code.
	if nearest_object_ != id {
		var point_direction_to_nearest_ = point_direction(nearest_object_.x, nearest_object_.y, original_x_, y);
		var point_distance_to_nearest_ = point_distance(original_x_, y, nearest_object_.x, nearest_object_.y);
		x_vector_ += (lengthdir_x(lerp(0, (distance_to_check_for_ - point_distance_to_nearest_), 0.5), point_direction_to_nearest_)) / room_speed;
		y_vector_ += (lengthdir_y(lerp(0, (distance_to_check_for_ - point_distance_to_nearest_), 0.5), point_direction_to_nearest_)) / room_speed;
	}
	x = original_x_;
	
	/// Finally, after setting the initial movement vectors and then adjusting for object avoidance,
	/// move the object.
	// Add the minimum of either the current speed times the delta time, or max move speed,
	// so that a frame stutter doesn't blast the object forward.
	xVector = x_vector_;
	yVector = y_vector_;
	x += xVector;
	y += yVector;
}