/// @description Set Sprite
// Set sprite based on states
sprite_index = playerSprite[playerCurrentForm, playerCurrentDirection];

// Set the last known location to the player x and y as long as the player isn't dug in.
if playerCurrentForm != forms.snowharedugin {
	lastKnownX = x;
	lastKnownY = y;
}

// Adjust the global variable used to check if a Wolf is on screen. I do this on the
// player object and not a Wolf object because I want this check to only execute once
// per frame.
checkedIfOnScreen = false;


