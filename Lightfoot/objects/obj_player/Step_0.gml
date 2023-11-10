/// @description Change Variables
// Set sprite based on states
sprite_index = playerSprite[playerCurrentForm, playerCurrentDirection];

// Check for inputs to move player
var right_ = 0;
var up_ = 0;
var left_ = 0;
var down_ = 0;
if keyboard_check(ord("D")) {
	right_ = 1;
}
else {
	right_ = 0;
}
if keyboard_check(ord("W")) {
	up_ = 1;
}
else {
	up_ = 0;
}
if keyboard_check(ord("A")) {
	left_ = 1;
}
else {
	left_ = 0;
}
if keyboard_check(ord("S")) {
	down_ = 1;
}
else {
	down_ = 0;
}

// Move the player based on inputs
var horizontal_ = right_ - left_;
var vertical_ = down_ - up_;
var dt_ = delta_time / 1000000;
if right_ || up_ || left_ || down_ {
	if currentMovementSpeed < maxMovementSpeed {
		currentMovementSpeed += min(maxMovementSpeed - currentMovementSpeed, acceleration * dt_);
	}
	if currentMovementSpeed > maxMovementSpeed {
		currentMovementSpeed = maxMovementSpeed;
	}
}
else {
	currentMovementSpeed = 0;
}

if horizontal_ != 0 {
	// Move player
	x += lengthdir_x(currentMovementSpeed * dt_, point_direction(0, 0, horizontal_, 0));
	// Then set direction enum, which will affect sprite setting
	switch horizontal_ {
		case 1:
			playerCurrentDirection = playerDirection.right;
			break;
		case -1:
			playerCurrentDirection = playerDirection.left;
			break;
	}
}
if vertical_ != 0 {
	y += lengthdir_y(currentMovementSpeed * dt_, point_direction(0, 0, 0, vertical_));
	// Then set direction enum, which will affect sprite setting
	switch vertical_ {
		case 1:
			playerCurrentDirection = playerDirection.down;
			break;
		case -1:
			playerCurrentDirection = playerDirection.up;
			break;
	}
}


