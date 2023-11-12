/// @description Set Camera Variables
camera_set_view_size(view_camera[0], viewW, viewH);

// Set up camera variables before setting the position.
var x_, y_;
x_ = clamp(target.x - (viewW / 2), 0, room_width - viewW);
y_ = clamp(target.y - (viewH / 2), 0, room_height - viewH);
camera_set_view_pos(view_camera[0], x_, y_);


