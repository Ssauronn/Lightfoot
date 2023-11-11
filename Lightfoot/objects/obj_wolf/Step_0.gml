/// @description Adjust Variables
// Adjust targetting variables
if instance_exists(target) {
	target.x = target.x
	target.y = target.y;
}

/// Sets the Wolf's state based on it's position relative to the player and screen, and
/// based additional based on the player's current form.
set_wolf_state();

/// Moves the wolf based on variables set in set_wolf_state();
move_wolf(targetToMoveToX, targetToMoveToY);


