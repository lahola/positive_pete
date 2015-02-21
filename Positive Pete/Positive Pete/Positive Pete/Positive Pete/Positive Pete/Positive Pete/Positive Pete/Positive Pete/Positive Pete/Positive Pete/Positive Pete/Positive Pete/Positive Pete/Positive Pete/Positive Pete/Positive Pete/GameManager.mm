//
//  GameManager.m
//  Positive Pete
//
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"
#import "GameScene.h"
#import "MainMenuScene.h"
#import "LevelCompleteScene.h"
#import "LevelSelectScene.h"
#import "OptionsScene.h"

@implementation GameManager
@synthesize pixelToPointRatio;
@synthesize score;
@synthesize numLevels;
@synthesize currentLevel;
@synthesize dirtyScore;
@synthesize levelDataFile;
@synthesize soundMuted;
@synthesize musicMuted;
static GameManager* _sharedGameManager = nil;

+(GameManager*)sharedGameManager {
    @synchronized([GameManager class])
    {
        if(!_sharedGameManager)
            [[self alloc] init];
        return _sharedGameManager;
    }
    return nil;
}

+(id)alloc
{
    @synchronized ([GameManager class])
    {
        NSAssert(_sharedGameManager == nil,
                 @"Attempted to allocate a second instance of the Game Manager singleton");
        _sharedGameManager = [super alloc];
        return _sharedGameManager;
    }
    return nil;
}
-(void)dealloc
{
    [levelDataFile release];
    [super dealloc];
}

-(Level*)loadLevelFromPlist:(int)levelNumber
{
    NSString *fullFileName = [self levelDataFile];
    NSString *plistPath;
    
    // 1: Get the Path to the plist file
    NSString *rootPath = 
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                         NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] 
                     pathForResource:fullFileName ofType:@"plist"];
    }
    
    // 2: Read in the plist file
    NSDictionary *plistDictionary = 
    [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // 3: If the plistDictionary was null, the file was not found.
    if (plistDictionary == nil) {
        CCLOG(@"Error reading plist: %@.plist", self.levelDataFile);
        return nil; // No Plist Dictionary or file found
    }
    
    // 4: Get just the mini-dictionary for this animation
    
    NSDictionary *levelData = 
    [plistDictionary objectForKey:[NSString stringWithFormat:@"Level %d",levelNumber]];
    if (levelData == nil) {
        CCLOG(@"Could not locate level Data for level:%d",levelNumber);
        return nil;
    }
    
    Level *level = [[Level alloc] autorelease];
    
    level.levelName = [levelData objectForKey:@"levelName"];
    level.fileName = [levelData objectForKey:@"fileName"];
    level.oneStarScore = [[levelData objectForKey:@"oneStarScore"] unsignedIntValue];
    level.twoStarScore = [[levelData objectForKey:@"twoStarScore"] unsignedIntValue];
    level.threeStarScore = [[levelData objectForKey:@"twoStarScore"] unsignedIntValue];
    
    return level;   
}

-(unsigned int)loadNumLevels
{
    NSString *fullFileName = [self levelDataFile];
    NSString *plistPath;
    
    // 1: Get the Path to the plist file
    NSString *rootPath = 
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                         NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] 
                     pathForResource:fullFileName ofType:@"plist"];
    }
    
    // 2: Read in the plist file
    NSDictionary *plistDictionary = 
    [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // 3: If the plistDictionary was null, the file was not found.
    if (plistDictionary == nil) {
        CCLOG(@"Error reading plist: %@.plist", self.levelDataFile);
        return nil; // No Plist Dictionary or file found
    }
    
    // 4: Get just the mini-dictionary for this animation
    
    unsigned int numberOfLevels = [[plistDictionary objectForKey:@"numLevels"] unsignedIntValue];
    return numberOfLevels;
}

-(void)pauseGame
{
    GameScene *runningScene = (GameScene*)[[CCDirector sharedDirector] runningScene];
    
    if (runningScene) 
        [runningScene pauseScene];
}

-(void)unpauseGame
{
    GameScene *runningScene = (GameScene*)[[CCDirector sharedDirector] runningScene];
    
    if (runningScene) 
        [runningScene unpauseScene];
}

-(void)incrementScore:(unsigned int)amount
{
    score += amount;
    dirtyScore = YES;
}

-(void)resetScore
{
    score = 0;
    dirtyScore = YES;
}

-(void)saveScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    unsigned int oldScore = (unsigned int)[defaults integerForKey:[NSString stringWithFormat:@"%d",currentLevel]];
    
    if (oldScore < score) {
        [defaults setInteger:score forKey:[NSString stringWithFormat:@"%d",currentLevel]];
        [defaults synchronize];
    }
}

-(unsigned int)readScore:(int)level
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    unsigned int levelScore = (unsigned int)[defaults integerForKey:[NSString stringWithFormat:@"%d",level]];
    return levelScore;
}

-(void)resetLevels
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    for (int i = 1; i <= numLevels; i++) {
        [defaults setInteger:0 forKey:[NSString stringWithFormat:@"%d",i]];
    }
    [defaults synchronize];
}

-(void)loadSoundPreferences
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    soundMuted = (bool)[defaults boolForKey:[NSString stringWithString:@"soundMuted"]];
    musicMuted = (bool)[defaults boolForKey:[NSString stringWithString:@"musicMuted"]];
}

-(void)saveSoundPreferences
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:soundMuted forKey:[NSString stringWithString:@"soundMuted"]];
    [defaults setBool:musicMuted forKey:[NSString stringWithString:@"musicMuted"]];
}

-(void)reloadCurrentLevel
{
    //GameScene *scene = (GameScene*)[[CCDirector sharedDirector] runningScene];
    //[scene dealloc];ß
    [self runSceneWithID:kGameScene];
}

-(void)runSceneWithID:(SceneTypes)sceneID {
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    switch(sceneID) {
        case kMainMenuScene:
            sceneToRun = [MainMenuScene node];
            break;
        
        case kOptionsScene:
            sceneToRun = [OptionsScene node];
            break;
            
        case kGameScene:
            [self resetScore];
            sceneToRun = [GameScene node];
            break;
            
        case kLevelCompleteScene:
            sceneToRun = [LevelCompleteScene node];
            break;
            
        case kLevelSelectScene:
            sceneToRun = [LevelSelectScene node];
            break;
            
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if(sceneToRun == nil) {
        currentScene = oldScene;
        return;
    }

    if ([[CCDirector sharedDirector] runningScene] == nil) {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
    } else {
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
}

-(id)init {
    self = [super init];
    if(self != nil) {
        CCLOG(@"Game Manager Singleton, init");
        currentScene = kNoSceneUninitialized;
        score = 0;
        dirtyScore = NO;
        currentLevel = 0;
        self.levelDataFile = [NSString stringWithFormat:@"levelDataFile"];
        self.numLevels = [self loadNumLevels];
        [self loadSoundPreferences];
    }
    return self;
}
@end
