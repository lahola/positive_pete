//
//  MainMenuBackgroundLayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenuBackgroundLayer.h"

@implementation MainMenuBackgroundLayer
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(id)init 
{
    self = [super init];
    
    if (self) {
        CCSprite *backgroundImage;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            backgroundImage = [CCSprite spriteWithFile:@"mainmenubackground-hd.png"];
        } else {
            backgroundImage = [CCSprite spriteWithFile:@"mainmenubackground.png"];
        }
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        [self addChild:backgroundImage];
    }
    
    return self;
}
@end
