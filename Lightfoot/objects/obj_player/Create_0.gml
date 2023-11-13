/// @description Player Creation Event
/// Movement Speed Variables
// Speed variables given in pixels per second
currentMovementSpeed = 0;
maxActualMovementSpeed = 0;
actualAcceleration = 0;
/// Human Speed Variables
humanMaxMovementSpeed = 150;
humanAcceleration = humanMaxMovementSpeed * 4;
/// Snow Hare on top of snow variables
snowHareTopMaxMovementSpeed = 300;
snowHareTopAcceleration = snowHareTopMaxMovementSpeed * 10;
/// Snow Hare dug into snow variables
snowHareDugInMaxMovementSpeed = 50;
snowHareDugInAcceleration = snowHareDugInMaxMovementSpeed * 3;

/// Form states
// Cooldown here given in seconds
formMaxCooldown = 0.5;
formCooldown = 0;

// Variable used to store the player's last known location (the spot where they dug into the snow)
// after the player digs into the snow.
globalvar lastKnownX, lastKnownY, playerInSnowHareTopForm;
lastKnownX = x;
lastKnownY = y;
playerInSnowHaretopForm = false;

enum forms {
	human,
	snowharetop,
	snowharedugin
}
enum playerDirection {
	right,
	up,
	left,
	down
}

// Setting sprite based on states
playerSprite[forms.human, playerDirection.right] = spr_player_human_right;
playerSprite[forms.human, playerDirection.up] = spr_player_human_up;
playerSprite[forms.human, playerDirection.left] = spr_player_human_left;
playerSprite[forms.human, playerDirection.down] = spr_player_human_down;
playerSprite[forms.snowharetop, playerDirection.right] = spr_player_snow_hare_top_right;
playerSprite[forms.snowharetop, playerDirection.up] = spr_player_snow_hare_top_up;
playerSprite[forms.snowharetop, playerDirection.left] = spr_player_snow_hare_top_left;
playerSprite[forms.snowharetop, playerDirection.down] = spr_player_snow_hare_top_down;
playerSprite[forms.snowharedugin, playerDirection.right] = spr_player_snow_hare_dug_in_right;
playerSprite[forms.snowharedugin, playerDirection.up] = spr_player_snow_hare_dug_in_up;
playerSprite[forms.snowharedugin, playerDirection.left] = spr_player_snow_hare_dug_in_left;
playerSprite[forms.snowharedugin, playerDirection.down] = spr_player_snow_hare_dug_in_down;

playerCurrentForm = forms.human;
playerCurrentDirection = playerDirection.right;
playerCurrentDirectionAlreadySet = false;


