//
//  LevelSelectScene.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectScene.h"
#import "cocos2d.h"
#import "LeftBoarderLayer.h"
#import "TopBoarderLayer.h"

@implementation LevelSelectScene
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(id)init
{
    if (self = [super init]) {
        levelSelectBackgroundLayer = [LevelSelectBackgroundLayer node];
        [self addChild:levelSelectBackgroundLayer z:0];

        levelSelectLayer = [LevelSelectLayer node];
        [self addChild:levelSelectLayer z:5];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            //LEFT CLIP
            CCLayer *leftClip = [LeftBoarderLayer node];
            leftClip.position = ccp(0,0);
            
            CCLayer *rightClip = [LeftBoarderLayer node];
            rightClip.position = ccp(992,0);
            
            CCLayer *topClip = [TopBoarderLayer node];
            topClip.position = ccp(0,704);
            
            CCLayer *bottomClip = [TopBoarderLayer node];
            bottomClip.position = ccp(0,0);
            
            [self addChild:topClip z:14];
            [self addChild:bottomClip z:15];
            [self addChild:leftClip z:16];
            [self addChild:rightClip z:17];
            
        }
    }
    return self;
}
@end
