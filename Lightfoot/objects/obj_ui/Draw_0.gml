///@description Draw To World
// Delta Time
var dt_ = delta_time / 1000000;

// Bonfire Icon
var current_objective_, bonfire_to_move_to_;
bonfire_to_move_to_ = noone;
current_objective_ = objectiveCount;
with obj_bonfire {
	if objective == current_objective_ {
		bonfire_to_move_to_ = id;
		break;
	}
}
// If the next bonfire to move to exists, and it's not on screen, then draw the icon.
if (bonfire_to_move_to_ != noone) && (!rectangle_in_rectangle(bonfire_to_move_to_.x, bonfire_to_move_to_.y, bonfire_to_move_to_.x + bonfire_to_move_to_.sprite_width, bonfire_to_move_to_.y + bonfire_to_move_to_.sprite_height, viewX, viewY, viewX + viewW, viewY + viewH)) {
	var bicon_x_ = obj_player.x + lengthdir_x(viewW / 2, point_direction(obj_player.x, obj_player.y, bonfire_to_move_to_.x, bonfire_to_move_to_.y));
	bicon_x_ = clamp(bicon_x_, viewX + 32, viewX + viewW - 64);
	var bicon_y_ = obj_player.y + lengthdir_y(viewW / 2, point_direction(obj_player.x, obj_player.y, bonfire_to_move_to_.x, bonfire_to_move_to_.y));
	bicon_y_ = clamp(bicon_y_, viewY + 32, viewY + viewH - 64);
	var sprite_scale_ = min(0.5, (warmthDistance / point_distance(obj_player.x, obj_player.y, bonfire_to_move_to_.x, bonfire_to_move_to_.y)));
	sprite_scale_ = clamp(sprite_scale_, 0.2, 0.5);
	draw_sprite_ext(spr_bonfire, 0, bicon_x_, bicon_y_, sprite_scale_, sprite_scale_, 0, c_white, 1);
}

