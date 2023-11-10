/// @description Change Variables

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

// Move player and set direction for sprite setting
if vertical_ != 0 {
	// Move the player
	y += lengthdir_y(currentMovementSpeed * dt_, point_direction(0, 0, 0, vertical_));
	// Then set direction enum, which will affect sprite setting
	if !playerCurrentDirectionAlreadySet {
		switch vertical_ {
			case 1:
				playerCurrentDirection = playerDirection.down;
				break;
			case -1:
				playerCurrentDirection = playerDirection.up;
				break;
		}
	}
}
if horizontal_ != 0 {
	// Move the player
	x += lengthdir_x(currentMovementSpeed * dt_, point_direction(0, 0, horizontal_, 0));
	// Then set direction enum, which will affect sprite setting
	if !playerCurrentDirectionAlreadySet {
		switch horizontal_ {
			case 1:
				playerCurrentDirection = playerDirection.right;
				break;
			case -1:
				playerCurrentDirection = playerDirection.left;
				break;
		}
	}
}

// This check sets a variable which prevents the sprite from changing during movement
// once it's set, keeping the sprite constant while moving.
if currentMovementSpeed != 0 {
	playerCurrentDirectionAlreadySet = true;
}
else {
	playerCurrentDirectionAlreadySet = false;
}
// Here I check to make sure the sprite isn't directly opposite of the current movement
// direction. If it is, I reset the aforementioned variable to allow for a single resetting
// of the player sprite.
if (horizontal_ == 1) && ((playerCurrentDirection == playerDirection.left) || (vertical_ = 0)) {
	playerCurrentDirection = playerDirection.right;
}
if (horizontal_ == -1) && ((playerCurrentDirection == playerDirection.right) || (vertical_ = 0)) {
	playerCurrentDirection = playerDirection.left;
}
if (vertical_ == 1) && ((playerCurrentDirection == playerDirection.up) || (horizontal_ == 0)) {
	playerCurrentDirection = playerDirection.down;
}
if (vertical_ == -1) && ((playerCurrentDirection == playerDirection.down) || (horizontal_ == 0)) {
	playerCurrentDirection = playerDirection.up;
}


