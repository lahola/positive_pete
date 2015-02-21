//
//  LevelSelectBackgroundLayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectBackgroundLayer.h"
#import "cocos2d.h"

@implementation LevelSelectBackgroundLayer
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(id)init
{
    if (self = [super initWithColor:(ccc4(150, 150, 150, 150))]) {
        CCSprite *backgroundImage;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            backgroundImage = [CCSprite spriteWithFile:@"mainmenubackground-hd.png"];
            [self changeWidth:960];
            [self changeHeight:640];
            [self setPosition:ccp(32,64)];
        } else {
            backgroundImage = [CCSprite spriteWithFile:@"mainmenubackground.png"];
        }
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [backgroundImage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
       // [self addChild:backgroundImage];
        
    }
    return self;
}
@end
