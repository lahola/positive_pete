//
//  LevelCompleteLayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelCompleteLayer.h"
#import "GameManager.h"

@implementation LevelCompleteLayer
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0
                                              swallowsTouches:YES];
}
-(id)init
{
    if (self = [super init]) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        NSString *scoreString = [NSString stringWithFormat:@"Score %d",[GameManager sharedGameManager].score];
        scoreLabel = [CCLabelTTF labelWithString:scoreString fontName:@"Noteworthy-Bold" fontSize:32];  
        [scoreLabel setPosition:ccp(screenSize.width/2,screenSize.height*1/3)];
        [self addChild:scoreLabel z:0];
        
        textLabel = [CCLabelTTF labelWithString:@"LEVEL COMPLETE!" fontName:@"Noteworthy-Bold" fontSize:48];
        [textLabel setPosition:ccp(screenSize.width/2,screenSize.height*2/3)];
        [self addChild:textLabel z:1];
        
        [self registerWithTouchDispatcher];
    }
    return self;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{
    [[GameManager sharedGameManager] runSceneWithID:kLevelSelectScene];
    return TRUE;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event 
{
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event 
{
}


@end
