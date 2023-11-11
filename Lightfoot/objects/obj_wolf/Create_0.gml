/// @description Create Wolf Variables

// Global variable used to check if any wolves are on screen once, before it needs to be reset
// by an outside object on the next frame.
globalvar checkedIfOnScreen;
checkedIfOnScreen = false;

/// Targeting
target = obj_player.id;
targetX = target.x;
targetY = target.y;
inPack = false;
canSeePlayer = false;
isOnScreen = false;
targetLastKnownLocationX = target.x;
targetLastKnownLocationY = target.y;
hasReachedLastKnownLocation = false;

/// Movement
maxWalkSpeed = target.humanMaxMovementSpeed + 64;
maxRunSpeed = target.snowHareTopMaxMovementSpeed + 64;
currentMaxSpeed = maxWalkSpeed;
currentSpeed = 0;
patrolRouteStartX = -1;
patrolRouteStartY = -1;

/// Smelling and Hearing
// Max timer given in seconds
searchingForDugInHareMaxTimer = 6;
searchingForDugInHareCurrentTimer = 0;
smellRange = room_height / 4;
hearingRange = 2 * sprite_get_width(spr_player_human_up);

/// States
enum wolfActionState {
	idle,
	circlehuman,
	huntinghuman,
	huntingharetop,
	huntingharedugin,
	bigpatrol,
	smallpatrol,
	returntopatrol
}

enum wolfMoveState { 
	walk,
	run,
	stand
}

enum wolfDirection {
	right,
	up,
	left,
	down
}

/// Sprite table
wolfSprite[wolfMoveState.walk, wolfDirection.right] = spr_wolf;
wolfSprite[wolfMoveState.walk, wolfDirection.up] = spr_wolf;
wolfSprite[wolfMoveState.walk, wolfDirection.left] = spr_wolf;
wolfSprite[wolfMoveState.walk, wolfDirection.down] = spr_wolf;
wolfSprite[wolfMoveState.run, wolfDirection.right] = spr_wolf;
wolfSprite[wolfMoveState.run, wolfDirection.up] = spr_wolf;
wolfSprite[wolfMoveState.run, wolfDirection.left] = spr_wolf;
wolfSprite[wolfMoveState.run, wolfDirection.down] = spr_wolf;
wolfSprite[wolfMoveState.stand, wolfDirection.right] = spr_wolf;
wolfSprite[wolfMoveState.stand, wolfDirection.up] = spr_wolf;
wolfSprite[wolfMoveState.stand, wolfDirection.left] = spr_wolf;
wolfSprite[wolfMoveState.stand, wolfDirection.down] = spr_wolf;

/// Variables used to control sprites and states on the fly
wolfCurrentAction = wolfActionState.idle;
wolfCurrentMoveState = wolfMoveState.stand;
wolfCurrentDirection = wolfDirection.right;


