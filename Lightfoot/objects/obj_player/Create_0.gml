/// @description Player Creation Event
// Movement Speed Variables
maxMovementSpeed = 250;
currentMovementSpeed = 0;
acceleration = 1000;

// Form states
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

playerSprite[forms.human, playerDirection.right] = spr_player;
playerSprite[forms.human, playerDirection.up] = spr_player_human_up;
playerSprite[forms.human, playerDirection.left] = spr_player;
playerSprite[forms.human, playerDirection.down] = spr_player;
playerSprite[forms.snowharetop, playerDirection.right] = spr_player;
playerSprite[forms.snowharetop, playerDirection.up] = spr_player;
playerSprite[forms.snowharetop, playerDirection.left] = spr_player;
playerSprite[forms.snowharetop, playerDirection.down] = spr_player;
playerSprite[forms.snowharedugin, playerDirection.right] = spr_player;
playerSprite[forms.snowharedugin, playerDirection.up] = spr_player;
playerSprite[forms.snowharedugin, playerDirection.left] = spr_player;
playerSprite[forms.snowharedugin, playerDirection.down] = spr_player;

playerCurrentForm = forms.human;
playerCurrentDirection = playerDirection.right;


