//
//  GameBackgroundLayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameBackgroundLayer.h"

@implementation GameBackgroundLayer
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(id)init {
    
    self = [super initWithColor:ccc4(150, 150, 150, 150)];
    
    if (self) {
//        CCSprite *backgroundImage;
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            backgroundImage = [CCSprite spriteWithFile:@"GameBackgroundiPhone-hd.png"];
//        } else {
//            backgroundImage = [CCSprite spriteWithFile:@"GameBackgroundiPhone.png"];
//        }
//        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        [backgroundImage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
//        
//        [self addChild:backgroundImage z:0 tag:0];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [self changeWidth:960];
            [self changeHeight:640];
            [self setPosition:ccp(32,64)];
        }
    }
    
    return self;
}
@end
