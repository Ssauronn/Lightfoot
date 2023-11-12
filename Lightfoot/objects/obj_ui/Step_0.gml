/// @description Adjust UI Values
/// Setting delta time
var dt_ = delta_time / 1000000;

#region Freeze Bar
// Count down Freeze Bar timer if the player is freezing
var error_ = false;
var nearest_bonfire_ = find_nearest_bonfire(obj_player.x, obj_player.y).id;
var bonfire_x_ = nearest_bonfire_.x;
var bonfire_y_ = nearest_bonfire_.y;

// Check to see if the player isn't currently a Snow Hare on top of the snow, and isn't
// within a specific range of a bonfire, and if that's the case, then tick down the Freeze Bar.
if (obj_player.playerCurrentForm != forms.snowharetop) && (abs(point_distance(obj_player.x, obj_player.y, bonfire_x_, bonfire_y_)) > warmthDistance) {
	if freezeBarActive && freezeBarDecays {
		if (freezeBarCurrentValue > 0) {
			freezeBarCurrentValue -= min(dt_, 1 / room_speed);
		}
		else if !freezeBarHitZero {
			freezeBarHitZero = true;
		}
	}
}
// If the player is within range of a bonfire, mark it as such, and change objectives if needed.
else if (abs(point_distance(obj_player.x, obj_player.y, bonfire_x_, bonfire_y_)) <= warmthDistance) {
	if nearest_bonfire_.objective == objectiveCount {
		objectiveCount++;
	}
	if freezeBarCurrentValue < freezeBarMaxValue {
		freezeBarCurrentValue += min(freezeBarMaxValue - freezeBarCurrentValue, dt_ * (freezeBarMaxValue / warmthRegeneration));
	}
}
#endregion


