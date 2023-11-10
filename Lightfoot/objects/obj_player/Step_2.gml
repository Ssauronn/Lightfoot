/// @description Set Sprite
// Set sprite based on states
sprite_index = playerSprite[playerCurrentForm, playerCurrentDirection];

// Set the last known location to the player x and y as long as the player isn't dug in.
if playerCurrentForm != forms.snowharedugin {
	lastKnownX = x;
	lastKnownY = y;
}


