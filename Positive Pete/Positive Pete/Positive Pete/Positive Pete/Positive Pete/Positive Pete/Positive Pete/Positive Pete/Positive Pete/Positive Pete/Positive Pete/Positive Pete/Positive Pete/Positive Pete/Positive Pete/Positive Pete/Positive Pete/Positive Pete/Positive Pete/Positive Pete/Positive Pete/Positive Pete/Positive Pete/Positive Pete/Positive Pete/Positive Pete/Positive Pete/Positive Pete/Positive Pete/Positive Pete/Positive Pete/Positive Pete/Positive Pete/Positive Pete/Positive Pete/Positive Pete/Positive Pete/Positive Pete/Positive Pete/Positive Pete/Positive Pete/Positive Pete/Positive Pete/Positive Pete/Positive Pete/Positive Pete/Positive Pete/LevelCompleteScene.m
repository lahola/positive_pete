//
//  LevelCompleteScene.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelCompleteScene.h"
#import "GameManager.h"

@implementation LevelCompleteScene 
@synthesize levelCompleteLayer;
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(id)init
{
    if (self = [super init]) {
        [[GameManager sharedGameManager] saveScore];
        
        levelCompleteLayer = [LevelCompleteLayer node];
        [self addChild:levelCompleteLayer];
    }
    return self;
}
@end
