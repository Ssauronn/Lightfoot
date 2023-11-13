/// @description Initialize Variables
/// Pausing Game
globalvar gamePaused;
globalvar playerDied;
gamePaused = false;
playerDied = false;

// Death Values
playerDiedTimerStartTime = 2 * room_speed;
playerDiedTimerCurrentTime = 0;
percentToFadeToDeathScreen = 0;

/// Freeze Bar Values
freezeBarActive = true;
// How many seconds it'll take the freeze bar, while freezing, to decay
freezeBarMaxValue = 45;
freezeBarCurrentValue = freezeBarMaxValue;
freezeBarDecays = true;
freezeBarHitZero = false;
// The distance in pixels the player needs to be within to be warm
warmthDistance = 320;
// The time, in seconds, it would take a fully depleted bar to replenish
// while standing within range of a bonfire.
warmthRegeneration = 2;
objectiveCount = 0;

/// Sound muted
soundMute = false;

/// Menu values
buttonHeldDown = false;
quitGameButtonPressed = false;
splashscreenActive = false;
splashscreenOccured = false;
splashscreenFadeInTimerStartTime = 2 * room_speed;
splashscreenFadeInTimerCurrentTime = 0;
splashscreenIdleTimerStartTime = 2 * room_speed;
splashscreenIdleTimerCurrentTime = 0;
percentToFadeSplashScreen = 0;
mainMenuActive = false;
mainMenuSelectionScreenActive = false;
startGameButtonX = 0;
startGameButtonY = 0;
startGameSmallButtonScale = 0.75;
startGameSmallButtonX = 0;
startGameSmallButtonFirstY = 0;
startGameSmallButtonSecondY = 0;
startGameButtonClickedOn = 0;
mainMenuSettingsScreenActive = false;
mainMenuControlsScreenActive = false;
pauseMenuActive = false;
deathScreenActive = false;
deathText = "You Froze to Death."

/// Tutorial values
// Whether or not tutorials should run in the first place, set by the player in settings
tutorialsActive = true;
// The divider for this timer is how many characters should appear on screen per second.
dialogueCharacterAppearTimerStart = room_speed / 60;
dialogueCharacterFastAsFuck = false;
dialogueCharacterAppearTimerCurrentTime = 0;
dialogueCharacterCount = -1;
gameStartTimer = 2;
openingTutorialComplete = false;
firstWolfSeenTutorialComplete = false;
firstWolfSeenInPackTutorialComplete = false;
firstTimeDugInSnowTutorialComplete = false;
firstTimeWolfCanHearTutorialComplete = false;
firstTimeEscapingWolvesTutorialComplete = false;
firstTimeFindingNewBonfireTutorialComplete = false;
lastBonfireReachedComplete = false;
firstTimeAlmostFrozenTutorialComplete = false;
dialogueTreeMaxChain = 1;
dialogueTreeCurrentChain = 1;

/// Tutorial ds_grid, containing all info for each tutorial popup
// x, 0, 0, 0 = the number the dialogue is in the chain
// 0, x, 0, 0 = the total number of dialogue popups in the chain
// 0, 0, x, 0 = the icon that should flash, if any
// 0, 0, 0, x = the dialogue string
tutorialsGrid = ds_grid_create(4, 20);
#region Opening Tutorial
ds_grid_add(tutorialsGrid, 0, 0, 1);
ds_grid_add(tutorialsGrid, 1, 0, 5);
ds_grid_add(tutorialsGrid, 2, 0, noone);
ds_grid_add(tutorialsGrid, 3, 0, "... Uh oh.");
ds_grid_add(tutorialsGrid, 0, 1, 2);
ds_grid_add(tutorialsGrid, 1, 1, 5);
ds_grid_add(tutorialsGrid, 2, 1, "Freeze");
ds_grid_add(tutorialsGrid, 3, 1, "I'm going to FREEZE to death if I don't make it to Druid Gonlord's house in time.");
ds_grid_add(tutorialsGrid, 0, 2, 3);
ds_grid_add(tutorialsGrid, 1, 2, 5);
ds_grid_add(tutorialsGrid, 2, 2, "Bonfire");
ds_grid_add(tutorialsGrid, 3, 2, "I see a light in the distance. Perhaps that's him?");
ds_grid_add(tutorialsGrid, 0, 3, 4);
ds_grid_add(tutorialsGrid, 1, 3, 5);
ds_grid_add(tutorialsGrid, 2, 3, noone);
ds_grid_add(tutorialsGrid, 3, 3, "I should be careful though... There's wolves outside.");
ds_grid_add(tutorialsGrid, 0, 4, 5);
ds_grid_add(tutorialsGrid, 1, 4, 5);
ds_grid_add(tutorialsGrid, 2, 4, noone);
ds_grid_add(tutorialsGrid, 3, 4, "(Use 'WASD' to move.)");
#endregion
#region First time seeing a wolf
ds_grid_add(tutorialsGrid, 0, 5, 1);
ds_grid_add(tutorialsGrid, 1, 5, 1);
ds_grid_add(tutorialsGrid, 2, 5, noone);
ds_grid_add(tutorialsGrid, 3, 5, "Wolves aren't very brave on their own. But they're dangerous in a pack. I should watch out.");
#endregion
#region First time seeing a pack of wolves
ds_grid_add(tutorialsGrid, 0, 6, 1);
ds_grid_add(tutorialsGrid, 1, 6, 3);
ds_grid_add(tutorialsGrid, 2, 6, noone);
ds_grid_add(tutorialsGrid, 3, 6, "More wolves. I need to move faster than this.");
ds_grid_add(tutorialsGrid, 0, 7, 2);
ds_grid_add(tutorialsGrid, 1, 7, 3);
ds_grid_add(tutorialsGrid, 2, 7, noone);
ds_grid_add(tutorialsGrid, 3, 7, "My Druid form is a Snow Hare... a WOLF'S PRIMARY PREY. But at least it's faster than this.");
ds_grid_add(tutorialsGrid, 0, 8, 3);
ds_grid_add(tutorialsGrid, 1, 8, 3);
ds_grid_add(tutorialsGrid, 2, 8, noone);
ds_grid_add(tutorialsGrid, 3, 8, "Time to RUN!!! (LEFT CLICK to turn into a SNOW HARE)");
#endregion
#region When any wolf gets close enough to be a threat the first time
ds_grid_add(tutorialsGrid, 0, 9, 1);
ds_grid_add(tutorialsGrid, 1, 9, 2);
ds_grid_add(tutorialsGrid, 2, 9, noone);
ds_grid_add(tutorialsGrid, 3, 9, "They're closing in on me, and they can SMELL me! I can't outrun all of them. I need to hide!");
ds_grid_add(tutorialsGrid, 0, 10, 2);
ds_grid_add(tutorialsGrid, 1, 10, 2);
ds_grid_add(tutorialsGrid, 2, 10, noone);
ds_grid_add(tutorialsGrid, 3, 10, "(Press SPACEBAR to dig into the snow. Make sure to dig away from where the wolves last saw you!)");
#endregion
#region When any wolf gets close enough to hear a dug in rabbit the first
ds_grid_add(tutorialsGrid, 0, 11, 1);
ds_grid_add(tutorialsGrid, 1, 11, 1);
ds_grid_add(tutorialsGrid, 2, 11, noone);
ds_grid_add(tutorialsGrid, 3, 11, "They can't find me as long as they don't walk on top of me, or HEAR me. I should STAY STILL.");
#endregion
#region When all threats have disappeared while the player is dug in
ds_grid_add(tutorialsGrid, 0, 12, 1);
ds_grid_add(tutorialsGrid, 1, 12, 3);
ds_grid_add(tutorialsGrid, 2, 12, noone);
ds_grid_add(tutorialsGrid, 3, 12, "The Wolves have given up... for now. I should return to HUMAN form and continue my journey.");
ds_grid_add(tutorialsGrid, 0, 13, 2);
ds_grid_add(tutorialsGrid, 1, 13, 3);
ds_grid_add(tutorialsGrid, 2, 13, noone);
ds_grid_add(tutorialsGrid, 3, 13, "(Swap between HUMAN form and SNOW HARE form any time with LEFT CLICK.)");
ds_grid_add(tutorialsGrid, 0, 14, 3);
ds_grid_add(tutorialsGrid, 1, 14, 3);
ds_grid_add(tutorialsGrid, 2, 14, noone);
ds_grid_add(tutorialsGrid, 3, 14, "(DIG into the snow while in SNOW HARE FORM by pressing SPACE BAR.)");
#endregion
#region When the player finds a bonfire after leaving the first one they were at
ds_grid_add(tutorialsGrid, 0, 15, 1);
ds_grid_add(tutorialsGrid, 1, 15, 2);
ds_grid_add(tutorialsGrid, 2, 15, noone);
ds_grid_add(tutorialsGrid, 3, 15, "I'll be safe and warm, for now.");
ds_grid_add(tutorialsGrid, 0, 16, 2);
ds_grid_add(tutorialsGrid, 1, 16, 2);
ds_grid_add(tutorialsGrid, 2, 16, "Bonfire");
ds_grid_add(tutorialsGrid, 3, 16, "I see another light in the distance. Perhaps that's the Druid's house...");
#endregion
#region When the player reaches the last bonfire
ds_grid_add(tutorialsGrid, 0, 17, 1);
ds_grid_add(tutorialsGrid, 1, 17, 1);
ds_grid_add(tutorialsGrid, 2, 17, noone);
ds_grid_add(tutorialsGrid, 3, 17, "Oh, thank the Earth Mother. I'm safe!");
#endregion
#region When the player drops to low frozen status the first time
ds_grid_add(tutorialsGrid, 0, 18, 1);
ds_grid_add(tutorialsGrid, 1, 18, 1);
ds_grid_add(tutorialsGrid, 2, 18, "Freeze");
ds_grid_add(tutorialsGrid, 3, 18, "I'm so COLD...");
#endregion


