///@description Draw To World
if room == GameRoom {
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
}
// Draw Menu stuff if we're in the menu room
else {
	var x_scale_ = sprite_get_width(spr_splash_screen) / viewW;
	var y_scale_ = sprite_get_height(spr_splash_screen) / viewH;
	if splashscreenActive {
		draw_sprite_ext(spr_splash_screen, 0, viewX, viewY, x_scale_, y_scale_, 0, c_white, percentToFadeSplashScreen);
	}
	// After the splash screen has been played, draw the main menu
	else if mainMenuActive {
		// If the mouse button (left) is NOT currently held down, then shift the button slightly up and to the left
		// with the background sprite remaining at original position, to give the illusion of a 3D press on a button
		var button_x_adjust_ = 0;
		var button_y_adjust_ = 0;
		if !buttonHeldDown {
			button_x_adjust_ = -64;
			button_y_adjust_ = -64;
		}
		if mainMenuSelectionScreenActive {
			
		}
		else if mainMenuSettingsScreenActive {
			
		}
		else if mainMenuControlsScreenActive {
			
		}
	}
}

