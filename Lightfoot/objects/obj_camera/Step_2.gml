/// @description Set Camera Variables
camera_set_view_size(view_camera[0], viewW, viewH);

// Set up camera variables before setting the position.
if room == GameRoom {
	var x_, y_;
	x_ = clamp(target.x - (viewW / 2) + (sprite_get_width(spr_player_human_right) / 2), 0, room_width - viewW);
	y_ = clamp(target.y - (viewH / 2) + (sprite_get_height(spr_player_human_right) / 2), 0, room_height - viewH);
}
else {
	var x_, y_;
	x_ = 0;
	y_ = 0;
}
camera_set_view_pos(view_camera[0], x_, y_);


