//
//  MainMenuScene.m
//  Positive Pete
//
//  Created by Louis Ahola on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "MainMenuBackgroundLayer.h"
#import "MainMenuButtonLayer.h"

@implementation MainMenuScene
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(id)init 
{
    self = [super init];
    if (self) {
        MainMenuButtonLayer *buttonLayer = [MainMenuButtonLayer node];
        MainMenuBackgroundLayer *backgroundLayer = [MainMenuBackgroundLayer node];
        
        [self addChild:buttonLayer z:5];
        [self addChild:backgroundLayer z:0];
    }
    return self;
}
@end
