/// A collection of functions containing every possible state the Wolf can be set to.
/// Does not set any sprite setting variables, because those are done externally.

///@function wolf_idle();
///@description State for Wolf idling.
function wolf_idle() {
	// Set delta time
	var dt_ = delta_time;
	
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
			wolfReturnToPatrolStart = !wolfReturnToPatrolStart;
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
		}
	}
}


///@function wolf_circle_human();
///@description State for Wolf circling the Human form (only 1 on screen).
function wolf_circle_human() {
	// Set delta time
	var dt_ = delta_time;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.walk;
	
}


///@function wolf_hunt_human();
///@description State for Wolf hunting the Human form (more than 1 on screen).
function wolf_hunt_human() {
	// Set delta time
	var dt_ = delta_time;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.walk;
	
}


///@function wolf_hunt_hare_top();
///@description State for Wolf hunting the Snow Hare while it's on top of the snow.
function wolf_hunt_hare_top() {
	// Set delta time
	var dt_ = delta_time;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.run;
	
}


///@function wolf_hunt_hare_dug_in();
///@description State for Wolf hunting the Snow Hare while it's dug into the snow.
function wolf_hunt_hare_dug_in() {
	// Set delta time
	var dt_ = delta_time;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.run;
	
	// Firstly, set variables used by move_wolf() function, called after this function is in
	// the Wolf step event.
	
	
	// If the point distance between the player's last known location and the Wolf is
	// less than the distance it'll take the Wolf to reach that location in half a second,
	// change to small patrol state, which slowly patrols around it's current position,
	// looking for the player.
	if point_distance(x, y, lastKnownX, lastKnownY) <= (currentMovementSpeed / 2) {
		hasReachedLastKnownLocation = true;
		searchingForDugInHareCurrentTimer = searchingForDugInHareMaxTimer;
		wolfCurrentAction = wolfActionState.smallpatrol;
	}
}


///@function wolf_big_patrol();
///@description State for Wolf patrolling.
function wolf_big_patrol() {
	// Set delta time
	var dt_ = delta_time;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.walk;
	
}


///@function wolf_small_patrol();
///@description State for Wolf searching for a dug in Snow Hare after reaching it's last known
///				location.
function wolf_small_patrol() {
	// Set delta time
	var dt_ = delta_time;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.run;
	
	// Firstly, set variables used by move_wolf() function, called after this function is in
	// the Wolf step event.
	
	// Count down the wolf timer if the timer is still above 0
	if searchingForDugInHareCurrentTimer >= 0 {
		searchingForDugInHareCurrentTimer -= dt_;
	}
	// If the timer runs out, set the Wolf to return back to it's normal patrol route.
	else {
		canSeePlayer = false;
		hasReachedLastKnownLocation = false;
		wolfCurrentAction = wolfActionState.returntopatrol;
		idleStateToReturnTo = wolfActionState.returntopatrol;
		wolfReturnToPatrolStart = true;
	}
}


///@function wolf_return_to_patrol();
///@description State for Wolf returning to patrol path after losing track of player.
function wolf_return_to_patrol() {
	// Set delta time
	var dt_ = delta_time;
	
	// Set the move state for the Wolf, which sets the sprite
	wolfCurrentMoveState = wolfMoveState.run;
	
}


