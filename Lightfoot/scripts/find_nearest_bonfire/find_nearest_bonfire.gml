///@function find_nearest_bonfire(x, y);
///@description Find the nearest bonfire to the instance calling this function.
///				Returns the ID of the nearest bonfire, or noone if no bonfire exists.
function find_nearest_bonfire(x_, y_) {
	if instance_exists(obj_bonfire) {
		var origin_x_ = x;
		var origin_y_ = y;
		var closest_id_, closest_x_, closest_y_;
		closest_id_ = noone;
		with obj_bonfire {
			if closest_id_ == noone {
				closest_id_ = self.id;
				closest_x_ = self.x;
				closest_y_ = self.y;
			}
			else if point_distance(origin_x_, origin_y_, self.x, self.y) < point_distance(origin_x_, origin_y_, closest_x_, closest_y_) {
				closest_id_ = self.id;
				closest_x_ = self.x;
				closest_y_ = self.y;
			}
		}
		return closest_id_;
	}
	else return noone;
}