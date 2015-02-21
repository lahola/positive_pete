//
//  Constants.h
//  Positive Pete
//
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Positive_Pete_Constants_h
#define Positive_Pete_Constants_h

#define PTM_RATIO (50.0f)
#define ACCELERATION_OF_GRAVITY (-.2f)
#define CHARGE_FORCE_CONSTANT (0.04f)
#define LAUNCH_SPEED (0.0f)
#define PETE_ROTATION_SPEED (2.0f)

#define NEUTRAL_TIME_DURATION (3.0f)
#define REVERSE_TIME_DURATION (3.0f)
#define SPEED_TIME_DURATION (3.0f)

#define SPEED_POWERUP_CONSTANT (3.0f)

#define MAX_NUM_STARS 3

#define POWER_CHIP_SCORE 10

#define SFX_NOTLOADED NO
#define SFX_LOADED YES

#define PLAYSOUNDEFFECT(...) \
[[GameManager sharedGameManager] playSoundEffect:@#__VA_ARGS__]
#define STOPSOUNDEFFECT(...) \
[[GameManager sharedGameManager] stopSoundEffect:__VA_ARGS__]

#define BACKGROUND_TRACK_MAIN_MENU @"ThemeSong.mp3"

typedef enum {
    kNoSceneUninitialized,
    kMainMenuScene,
    kGameScene,
    kCreditsScene,
    kOptionsScene,
    kIntroScene,
    kLevelCompleteScene,
    kLevelSelectScene,
} SceneTypes;

typedef enum {
    kNoObject,
    kPeteType,
    kCannonType,
    kPositivePoleType,
    kNegativePoleType,
    kShutDownSiteType,
    kPowerChipType,
    kSpeedPadType,
    kReversPadType,
    kNeutralPadType,
} GameObjectType;

typedef enum {
    kFacingUp,
    kFacingRight,
    kFacingDown,
    kFacingLeft
} CannonDirection;

typedef enum {
    kStateReady,
    kStateIdle,
    kStateFiring,
    kStateReversed,
    kStateSpeed,
    kStateNeutral,
    kStateFired,
    kStatePoweredUp,
    kStatePoweredDown,
    kStatePickedUp,
    kStateAvailable,
} CharacterState;

typedef enum {
    kSetupPhaseState,
    kMovingPhaseState
} GameState;

#endif
