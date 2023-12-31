/// @description Create Wolf Variables

// Global variable used to check if any wolves are on screen once, before it needs to be reset
// by an outside object on the next frame.
globalvar checkedIfOnScreen;
checkedIfOnScreen = false;

/// Targeting
target = obj_player.id;
inPack = false;
canSeePlayer = false;
isOnScreen = false;
rangeToKillPlayer = 48;

/// Movement
maxWalkSpeed = target.humanMaxMovementSpeed - 32;
maxRunSpeed = target.snowHareTopMaxMovementSpeed - 32;
currentMaxSpeed = maxWalkSpeed;
wolfAcceleration = currentMaxSpeed * 4;
currentSpeed = 0;
targetToMoveToX = -1;
targetToMoveToY = -1;
xVector = 0;
yVector = 0;

/// Circling around player variables
// Set it so that each Wolf always chooses to circle in one direction, but that direction
// is random and is set at the start of the game.
circleHumanClockwise = irandom_range(0, 1);
// Set the radius of the circle that the Wolf circles around the player equal to a random
// range between how long it would take the Wolf to reach the player in a little less than
// 1 to 2 seconds.
//circleRadius = irandom_range(maxWalkSpeed, maxWalkSpeed * 1.5);
circleRadius = maxWalkSpeed * 1.5;

/// Patrol Variables
// Big patrol route start. Never changes, always set to where the Wolf spawns.
wolfBigPatrolRouteStartX = x;
wolfBigPatrolRouteStartY = y;
// The random point to move to for it's next goal. Changes each time the Wolf
// reaches this point.
wolfBigPatrolRandomRouteRange = viewH / 3;
wolfSmallPatrolRandomRouteRange = viewH / 6;
wolfRandomPatrolRouteX = x + irandom_range((wolfBigPatrolRandomRouteRange * -1), wolfBigPatrolRandomRouteRange);
wolfRandomPatrolRouteY = y + irandom_range((wolfBigPatrolRandomRouteRange * -1), wolfBigPatrolRandomRouteRange);
// Controls whether the Wolf is moving to a random patrol route goal, or back
// to it's original route point before beginning the cycle anew.
wolfReturnToPatrolStart = false;
// The max amount of time the Wolf will idle at it's destination on patrol before
// resuming it's patrol.
wolfPatrolIdleTime = 2;

/// Smelling and Hearing
// Max timer given in seconds
searchingForDugInHareMaxTimer = 6;
searchingForDugInHareCurrentTimer = 0;
smellRange = room_height / 8;
hearingRange = 80;

/// Idle state variables, which are used often and exclusive to the Idle state
idleTimerStartTime = 0;
idleTimerCurrentTime = 0;
idleStateToReturnTo = noone;

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
wolfSprite[wolfMoveState.walk, wolfDirection.right] = spr_wolf_right;
wolfSprite[wolfMoveState.walk, wolfDirection.left] = spr_wolf_left;
wolfSprite[wolfMoveState.run, wolfDirection.right] = spr_wolf_right;
wolfSprite[wolfMoveState.run, wolfDirection.left] = spr_wolf_left;
wolfSprite[wolfMoveState.stand, wolfDirection.right] = spr_wolf_right;
wolfSprite[wolfMoveState.stand, wolfDirection.left] = spr_wolf_left;

/// Variables used to control sprites and states on the fly
wolfCurrentAction = wolfActionState.idle;
wolfCurrentMoveState = wolfMoveState.stand;
wolfCurrentDirection = wolfDirection.right;

// This is probably uneeded, but here I set the return state by default
// to returning to patrol path, in case anything bugs out.
idleStateToReturnTo = wolfActionState.returntopatrol;


