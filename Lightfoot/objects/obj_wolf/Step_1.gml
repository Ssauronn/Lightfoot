/// @description Adjust Variables Before Step
if !gamePaused {
	if rectangle_in_rectangle(x, y, x + sprite_get_width(sprite_index), y + sprite_get_height(sprite_index), viewX, viewY, viewX + viewW, viewY + viewH) != 0 {
		isOnScreen = true;
	}
	else {
		isOnScreen = false;
	}
}


