//
//  GameScene.m
//  Positive Pete
//
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
-(void)dealloc
{
    [pauseScreenLayer release];
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

-(void)pauseScene
{
    [self pauseSchedulerAndActions];
    [[guiLayer pauseButtonMenu] setIsTouchEnabled:NO];
    [gameplayLayer setIsTouchEnabled:NO];
    [self addChild:pauseScreenLayer z:15];
}

-(void)unpauseScene
{
    [self removeChild:pauseScreenLayer cleanup:NO];
    [[guiLayer pauseButtonMenu] setIsTouchEnabled:YES];
    [gameplayLayer setIsTouchEnabled:YES];
    [self resumeSchedulerAndActions];
}

-(id)init {
    self = [super init];
    if (self) {
        guiLayer = [[InGameGUILayer alloc] init];
        backgroundLayer = [[GameBackgroundLayer alloc] init];
        gameplayLayer = [[GameplayLayer alloc] init];
        pauseScreenLayer = [[PauseScreenGUILayer alloc] init];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [pauseScreenLayer setIsRelativeAnchorPoint:YES];
        [pauseScreenLayer setAnchorPoint:ccp(.5,.5)];
        [pauseScreenLayer setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        [self addChild:guiLayer z:10];
        [self addChild:gameplayLayer z:5];
        [self addChild:backgroundLayer z:0];
        
        [guiLayer release];
        [backgroundLayer release];
        [gameplayLayer release];
    }
    return self;
}
@end
