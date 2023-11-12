///@function play_dialogue(_string);
function play_dialogue(_string) {
	// Draw background for dialogue box
	var box_width_ = (viewW * 2) / sprite_get_width(spr_dialogue_background);
	var box_height_ = ((viewH * 2) / 6) / sprite_get_height(spr_dialogue_background);
	draw_sprite_ext(spr_dialogue_background, 0, 0, viewH * 2, box_width_, box_height_, 0, c_white, 1);
	
	// Skip forward to the end of dialogue if the player wants to skip the dialogue.
	if (keyboard_check_pressed(vk_space)) || (mouse_check_button_pressed(mb_left)) || (mouse_check_button_pressed(mb_right)) {
		var skipping_dialogue_ = false;
		// If the player hasn't skipped yet, then skip the dialogue
		if (!dialogueCharacterFastAsFuck) && ((dialogueCharacterCount < string_length(_string))) {
			skipping_dialogue_ = true;
			dialogueCharacterFastAsFuck = true;
			dialogueCharacterCount = string_length(_string);
		}
		// If the player is done with dialogue, then move to the next dialogue option.
		if (dialogueCharacterCount >= string_length(_string)) && (!skipping_dialogue_) {
			dialogueTreeCurrentChain++;
			dialogueCharacterAppearTimerCurrentTime = dialogueCharacterAppearTimerStart;
			dialogueCharacterFastAsFuck = false;
			dialogueCharacterCount = 1;
		}
	}
	// Draw another character in the string each time the character timer allows
	if !dialogueCharacterFastAsFuck {
		if dialogueCharacterAppearTimerCurrentTime <= 0 {
			dialogueCharacterAppearTimerCurrentTime = dialogueCharacterAppearTimerStart;
			dialogueCharacterCount++;
		}
		else {
			dialogueCharacterAppearTimerCurrentTime--;
		}
	}
	var string_x_start_ = 128;
	var string_y_start_ = ((viewH * 2) - (viewH * 2) / 6) + 32;
	var string_x_scale_ = 5;
	var string_y_scale_ = 5;
	var current_draw_string_ = parse_string(_string, 1);
	// Seperate the string into two lines if the string is longer than the width of the dialogue box.
	if string_length(current_draw_string_) > 50 {
		var space_to_cut_at_ = 50;
		while (string_char_at(current_draw_string_, space_to_cut_at_) != " ") && (space_to_cut_at_ > 0) {
			space_to_cut_at_--;
		}
		if space_to_cut_at_ != 0 {
			var line_2_ = parse_string(current_draw_string_, space_to_cut_at_ + 1);
			var dialogue_character_count_storage_ = dialogueCharacterCount;
			dialogueCharacterCount = space_to_cut_at_;
			var line_1_ = parse_string(current_draw_string_, 1);
			dialogueCharacterCount = dialogue_character_count_storage_;
			string_y_start_ -= 10;
			draw_text_ext_transformed(string_x_start_, string_y_start_, line_1_, 3, viewW * 2, string_x_scale_, string_y_scale_, 0);
			string_y_start_ += (string_height(line_1_) * string_y_scale_) - 15;
			draw_text_ext_transformed(string_x_start_, string_y_start_, line_2_, 3, viewW * 2, string_x_scale_, string_y_scale_, 0);
		}
	}
	else {
		draw_text_ext_transformed(string_x_start_, string_y_start_, current_draw_string_, 3, viewW * 2, string_x_scale_, string_y_scale_, 0);
	}
}