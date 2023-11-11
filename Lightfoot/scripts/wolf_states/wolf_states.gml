/// A collection of functions containing every possible state the Wolf can be set to.
/// Does not set any sprite setting variables, because those are done externally.

///@function wolf_idle();
///@description State for Wolf idling.
function wolf_idle() {
	// Set delta time
	var dt_ = delta_time / 1000000;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.stand;
	
	// Set variables used by move_wolf() function, called after this function is in
	// the Wolf step event.
	targetToMoveToX = x;
	targetToMoveToY = y;
	
	// If the Wolf's original state is searching for the hidden player (dug into the snow)
	// after it's already reached the player's last known location, then continue to count
	// that timer down.
	if idleStateToReturnTo == wolfActionState.smallpatrol {
		// Count down the wolf timer if the timer is still above 0
		if searchingForDugInHareCurrentTimer >= 0 {
			searchingForDugInHareCurrentTimer -= dt_;
		}
		// If the timer runs out, since we're in the idle state, return back to the patrol
		// state, which can then handle the rest correctly.
		else {
			idleTimerCurrentTime = 0;
		}
	}
	
	// Finally, count down idle timer and return to the original state if the Wolf is done idling.
	// This can be set to 0 in previous code in the same frame to force the below code to execute,
	// in case for example outside timers hit 0 before the idle timer hits 0.
	if idleTimerCurrentTime > 0 {
		idleTimerCurrentTime -= dt_;
	}
	else {
		wolfCurrentAction = idleStateToReturnTo;
		// If the current action now is to patrol, inverse the patrol route
		if (wolfCurrentAction == wolfActionState.bigpatrol) || (wolfCurrentAction == wolfActionState.smallpatrol) {
			// Set target variables depending on whether the current action is to return to a big
			// patrol, a small patrol, or to begin a big or small patrol to a new point.
			if !wolfReturnToPatrolStart {
				switch wolfCurrentAction {
					case wolfActionState.bigpatrol:
						wolfRandomPatrolRouteX = x + irandom_range((wolfBigPatrolRandomRouteRange * -1), wolfBigPatrolRandomRouteRange);
						wolfRandomPatrolRouteY = y + irandom_range((wolfBigPatrolRandomRouteRange * -1), wolfBigPatrolRandomRouteRange);
						break;
					case wolfActionState.smallpatrol:
						wolfRandomPatrolRouteX = x + irandom_range((wolfSmallPatrolRandomRouteRange * -1), wolfSmallPatrolRandomRouteRange);
						wolfRandomPatrolRouteY = y + irandom_range((wolfSmallPatrolRandomRouteRange * -1), wolfSmallPatrolRandomRouteRange);
						break;
				}
				targetToMoveToX = wolfRandomPatrolRouteX;
				targetToMoveToY = wolfRandomPatrolRouteY;
			}
			else {
				switch wolfCurrentAction {
					case wolfActionState.bigpatrol:
						targetToMoveToX = wolfBigPatrolRouteStartX;
						targetToMoveToY = wolfBigPatrolRouteStartY;
						break;
					case wolfActionState.smallpatrol:
						targetToMoveToX = lastKnownX;
						targetToMoveToY = lastKnownY;
						break;
				}
			}
			// After I use wolfReturnToPatrolStart to set the above target variables, reverse
			// the value of this variable, so that next time, it reverses it's action.
			wolfReturnToPatrolStart = !wolfReturnToPatrolStart;
		}
	}
}


///@function wolf_circle_human();
///@description State for Wolf circling the Human form (only 1 on screen).
function wolf_circle_human() {
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.walk;

	if !inPack {
		// Set the target to move to equal to a point tangental to the circle
		// the Wolf will be circling the player in, in the direction set at
		// the beginning of the game by circleHumanClockwise.
		if circleHumanClockwise {
			var point_direction_ = point_direction(x, y, obj_player.x, obj_player.y) + 90;
			if point_direction_ >= 360 {
				point_direction_ -= 360;
			}
		}
		else {
			var point_direction_ = point_direction(x, y, obj_player.x, obj_player.y) - 90;
			if point_direction_ < 0 {
				point_direction_ += 360;
			}
		}
		// After properly adjusting the point direction, set the target point to a coordinate
		// tangental to the circle in the direction it's assigned to rotate in.
		var dir_x_ = lengthdir_x(circleRadius, point_direction(obj_player.x, obj_player.y, x, y));
		var dir_y_ = lengthdir_y(circleRadius, point_direction(obj_player.x, obj_player.y, x, y));
		var tangent_dir_x_ = lengthdir_x((maxWalkSpeed / 60), point_direction_);
		var tangent_dir_y_ = lengthdir_y((maxWalkSpeed / 60), point_direction_);
		targetToMoveToX = (obj_player.x + dir_x_) + tangent_dir_x_;
		targetToMoveToY = (obj_player.y + dir_y_) + tangent_dir_y_;
		// Check to see if the target is out of bounds, and if so, make sure that's fixed.
		if sign(targetToMoveToX) == -1 {
			if circleHumanClockwise {
				targetToMoveToX = 0;
				targetToMoveToY = 0;
			}
			else {
				targetToMoveToX = 0;
				targetToMoveToY = room_height;
			}
		}
		else if sign(targetToMoveToY) == -1 {
			if circleHumanClockwise {
				targetToMoveToX = room_width;
				targetToMoveToY = 0;
			}
			else {
				targetToMoveToX = 0;
				targetToMoveToY = 0;
			}
		}
		else if targetToMoveToX > room_width {
			if circleHumanClockwise {
				targetToMoveToX = room_width;
				targetToMoveToY = room_height;
			}
			else {
				targetToMoveToX = room_width;
				targetToMoveToY = 0;
			}
		}
		else if targetToMoveToY > room_height {
			if circleHumanClockwise {
				targetToMoveToX = 0;
				targetToMoveToY = room_height;
			}
			else {
				targetToMoveToX = room_width;
				targetToMoveToY = room_height;
			}
		}

		// Set the target to move to equal to the center of the circle if the
		// distance to the player is greater than that circle. This is done AFTER
		// the above section to allow for a buffer in case the player moves, to prevent
		// really weird looking movement every time the player moves anywhere.
		var circle_min_distance_ = circleRadius - 32;
		var circle_max_distance_ = circleRadius + 32;
		// If the current coordinate to move to is outside of a bounding circle
		// around the radius at which the Wolf should circle the player, move to
		// the closest point on that exact circle.
		var point_distance_target_to_move_to_ = point_distance(obj_player.x, obj_player.y, targetToMoveToX, targetToMoveToY);
		if ((point_distance_target_to_move_to_ > circle_max_distance_) || (point_distance_target_to_move_to_ < circle_min_distance_)) && ((targetToMoveToX != 0) && (targetToMoveToY != 0)) {
			targetToMoveToX = obj_player.x + dir_x_;
			targetToMoveToY = obj_player.y + dir_y_;
			show_debug_message("Moving TO CIRCLE");
		}
		else {
			show_debug_message("Moving AROUND Player");
		}
	}
	else {
		wolfCurrentAction = wolfActionState.huntinghuman;
		targetToMoveToX = obj_player.x;
		targetToMoveToY = obj_player.y;
	}
}


///@function wolf_hunt_human();
///@description State for Wolf hunting the Human form (more than 1 on screen).
function wolf_hunt_human() {
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.walk;
	targetToMoveToX = obj_player.x;
	targetToMoveToY = obj_player.y;
}


///@function wolf_hunt_hare_top();
///@description State for Wolf hunting the Snow Hare while it's on top of the snow.
function wolf_hunt_hare_top() {
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.run;
	targetToMoveToX = obj_player.x;
	targetToMoveToY = obj_player.y;
}


///@function wolf_hunt_hare_dug_in();
///@description State for Wolf hunting the Snow Hare while it's dug into the snow.
function wolf_hunt_hare_dug_in() {
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.run;
	
	// Set variables used by move_wolf() function, called after this function is in
	// the Wolf step event.
	targetToMoveToX = lastKnownX;
	targetToMoveToY = lastKnownY;
	
	// If the point distance between the player's last known location and the Wolf is
	// less than the distance it'll take the Wolf to reach that location in 1/5 of a second,
	// change to small patrol state, which slowly patrols around it's current position,
	// looking for the player.
	if point_distance(x, y, lastKnownX, lastKnownY) <= (currentSpeed / 5) {
		hasReachedLastKnownLocation = true;
		searchingForDugInHareCurrentTimer = searchingForDugInHareMaxTimer;
		wolfRandomPatrolRouteX = lastKnownX + irandom_range((wolfSmallPatrolRandomRouteRange * -1), wolfSmallPatrolRandomRouteRange);
		wolfRandomPatrolRouteY = lastKnownY + irandom_range((wolfSmallPatrolRandomRouteRange * -1), wolfSmallPatrolRandomRouteRange);
		wolfCurrentAction = wolfActionState.smallpatrol;
		wolfCurrentMoveState = wolfMoveState.walk;
		wolfReturnToPatrolStart = false;
	}
}


///@function wolf_big_patrol();
///@description State for Wolf patrolling.
function wolf_big_patrol() {
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.walk;
	
	// If the Wolf gets within range of the target patrol route to move to, idle for a moment.
	if point_distance(x, y, targetToMoveToX, targetToMoveToY) < (currentMaxSpeed / 5) {
		wolfCurrentMoveState = wolfMoveState.stand;
		idleStateToReturnTo = wolfCurrentAction;
		wolfCurrentAction = wolfActionState.idle;
		idleTimerCurrentTime = irandom_range(0, wolfPatrolIdleTime);
	}
	
	// I don't set targetToMoveToX and targetToMoveToY in this function because I want those
	// variables to only be set once, at the beginning when the state is first sent to big
	// patrol state.
}


///@function wolf_small_patrol();
///@description State for Wolf searching for a dug in Snow Hare after reaching it's last known
///				location.
function wolf_small_patrol() {
	// Set delta time
	var dt_ = delta_time / 1000000;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.walk;
	
	// If the Wolf gets within range of the target patrol route to move to, idle for a moment.
	if point_distance(x, y, targetToMoveToX, targetToMoveToY) < (currentMaxSpeed / (room_speed / 5)) {
		wolfCurrentMoveState = wolfMoveState.stand;
		idleStateToReturnTo = wolfCurrentAction;
		wolfCurrentAction = wolfActionState.idle;
		wolfReturnToPatrolStart = !wolfReturnToPatrolStart;
		idleTimerCurrentTime = irandom_range(1, wolfPatrolIdleTime);
	}
	
	// I don't set targetToMoveToX and targetToMoveToY in this function because I want those
	// variables to only be set once, at the beginning when the state is first sent to big
	// patrol state.
	
	// Count down the wolf timer if the timer is still above 0
	if (searchingForDugInHareCurrentTimer >= 0) && (isOnScreen) {
		searchingForDugInHareCurrentTimer -= dt_;
	}
	// If the timer runs out, set the Wolf to return back to it's normal patrol route.
	else {
		canSeePlayer = false;
		hasReachedLastKnownLocation = false;
		wolfCurrentAction = wolfActionState.returntopatrol;
		// Here I do in fact set targetToMoveToX and targetToMoveToY because this will
		// only execute once, at the start of the return to the patrol route.
		targetToMoveToX = wolfRandomPatrolRouteX;
		targetToMoveToY = wolfRandomPatrolRouteY;
		idleStateToReturnTo = wolfActionState.returntopatrol;
		wolfReturnToPatrolStart = true;
		searchingForDugInHareCurrentTimer = 0;
	}
}


///@function wolf_return_to_patrol();
///@description State for Wolf returning to patrol path after losing track of player.
function wolf_return_to_patrol() {
	// Set delta time
	var dt_ = delta_time / 1000000;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.run;
	
	// Set the target to move to variables
	targetToMoveToX = wolfBigPatrolRouteStartX;
	targetToMoveToY = wolfBigPatrolRouteStartY;
}


