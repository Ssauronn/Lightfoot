/// @description Adjust Variables
// Adjust targetting variables
if instance_exists(target) {
	target.x = target.x
	target.y = target.y;
}

/// Sets the Wolf's state based on it's position relative to the player and screen, and
/// based additional based on the player's current form.
// First, however, I check to make sure the player isn't within range of a Bonfire.
// Otherwise, reset the Wolf.
if isOnScreen || ((obj_player.playerCurrentForm == forms.snowharetop) && canSeePlayer) {
	var nearest_bonfire_to_player_ = find_nearest_bonfire(obj_player.x, obj_player.y).id;
	if (nearest_bonfire_to_player_ == noone) || (point_distance(obj_player.x, obj_player.y, nearest_bonfire_to_player_.x, nearest_bonfire_to_player_.y) > obj_ui.warmthDistance) {
		set_wolf_state();
	}
	// If the player is within range of a bonfire, then give up and return to patrolling.
	else {
	
	}
}


/// Moves the wolf based on variables set in set_wolf_state();
move_wolf(targetToMoveToX, targetToMoveToY);

show_debug_message(string(searchingForDugInHareCurrentTimer));


