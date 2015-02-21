//
//  GameManager.h
//  Positive Pete
//
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"
#import "Level.h"
#import <Foundation/Foundation.h>

@interface GameManager : NSObject {
    SceneTypes currentScene;
    int currentLevel;
    float pixelToPointRatio;
    unsigned int score;
    bool dirtyScore;
    unsigned int numLevels;
    NSString *levelDataFile;
    bool soundMuted;
    bool musicMuted;
}
@property (nonatomic,assign) float pixelToPointRatio;
@property (nonatomic,assign) unsigned int numLevels;
@property (nonatomic,assign) unsigned int score;
@property (nonatomic,assign) bool dirtyScore;
@property (nonatomic,assign) int currentLevel;
@property (nonatomic,retain) NSString *levelDataFile;
@property (nonatomic,assign) bool soundMuted;
@property (nonatomic,assign) bool musicMuted;
+(GameManager*)sharedGameManager;
-(Level*)loadLevelFromPlist:(int)levelNumber;
-(unsigned int)readScore:(int)level;
-(void)runSceneWithID:(SceneTypes)sceneID;
-(void)incrementScore:(unsigned int)amount;
-(void)resetScore;
-(void)saveScore;
-(void)pauseGame;
-(void)unpauseGame;
-(void)reloadCurrentLevel;
-(void)saveSoundPreferences;
@end
