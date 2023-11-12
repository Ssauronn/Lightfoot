///@function parse_string(string_to_parse_, start_x_);
function parse_string(string_to_parse_, start_x_) {
	var string_to_return_ = "";
	var i = 1;
	for (i = start_x_; i <= dialogueCharacterCount; i++) {
		string_to_return_ += string_char_at(string_to_parse_, i);
	}
	return string_to_return_;
}