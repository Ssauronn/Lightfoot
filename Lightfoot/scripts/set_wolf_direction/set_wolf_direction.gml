///@function set_wolf_direction(target_x, target_y);
///@description Sets the wolf direction variable, used to set it's sprite,
///				based on the target variables provided.
function set_wolf_direction(x_, y_) {
	var wolf_direction_angle_;
	wolf_direction_angle_ = point_direction(x, y, x_, y_);
	// Set the direction the Wolf is facing based on which of the 4 directions the player is in
	if (wolf_direction_angle_ > 45) && (wolf_direction_angle_ <= 135) {
		wolfCurrentDirection = wolfDirection.up;
	}
	else if (wolf_direction_angle_ > 135) && (wolf_direction_angle_ <= 225) {
		wolfCurrentDirection = wolfDirection.left;
	}
	else if (wolf_direction_angle_ > 225) && (wolf_direction_angle_ <= 315) {
		wolfCurrentDirection = wolfDirection.down;
	}
	else {
		wolfCurrentDirection = wolfDirection.right;
	}
}