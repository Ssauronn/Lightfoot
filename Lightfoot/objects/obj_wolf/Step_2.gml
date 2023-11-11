/// @description Adjust Variables After Step
// Check to see if any other wolves can see the player, and if so, mark the Wolf as in a pack.
if canSeePlayer {
	var self_id_ = id;
	if !checkedIfOnScreen {
		checkedIfOnScreen = true;
		with obj_wolf {
			if canSeePlayer {
				if self.id != self_id_ {
					inPack = true;
					self_id_.inPack = true;
				}
			}
		}
	}
}


