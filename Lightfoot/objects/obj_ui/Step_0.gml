/// @description Adjust UI Values
/// Setting delta time
var dt_ = delta_time / 1000000;

#region Freeze Bar
// Count down Freeze Bar timer if the player is freezing
var error_ = false;
if find_nearest_bonfire(obj_player.x, obj_player.y) != noone {
	var bonfire_x_ = find_nearest_bonfire(obj_player.x, obj_player.y).x;
	var bonfire_y_ = find_nearest_bonfire(obj_player.x, obj_player.y).y;
}
else {
	error_ = true;
}

// Check to see if the player isn't currently a Snow Hare on top of the snow, and isn't
// within a specific range of a bonfire, and if that's the case, then tick down the Freeze Bar.
if (obj_player.playerCurrentForm != forms.snowharedugin) && (abs(point_distance(obj_player.x, obj_player.y, bonfire_x_, bonfire_y_)) > warmthDistance) {
	if freezeBarActive && freezeBarDecays {
		if (freezeBarCurrentValue > 0) {
			freezeBarCurrentValue -= dt_;
		}
		else if !freezeBarHitZero {
			freezeBarHitZero = true;
		}
	}
}
else if (abs(point_distance(obj_player.x, obj_player.y, bonfire_x_, bonfire_y_)) <= warmthDistance) {
	if freezeBarCurrentValue < freezeBarMaxValue {
		freezeBarCurrentValue += min(freezeBarMaxValue - freezeBarCurrentValue, dt_ * (freezeBarMaxValue / warmthRegeneration));
	}
}
#endregion


