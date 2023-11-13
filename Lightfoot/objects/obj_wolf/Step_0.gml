/// @description Adjust Variables
if !gamePaused {
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
		set_wolf_state();
	}
	
	/// Moves the wolf based on variables set in set_wolf_state();
	move_wolf(targetToMoveToX, targetToMoveToY);
}
/// Kill player if it gets close enough.
if point_distance(x, y, obj_player.x, obj_player.y) < rangeToKillPlayer {
	playerDied = true;
	obj_ui.deathText = "You were eaten."
}


