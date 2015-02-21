//
//  OptionsBackgroundLayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCDirector.h"
#import "cocos2d.h"
#import "OptionsBackgroundLayer.h"

@implementation OptionsBackgroundLayer
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
