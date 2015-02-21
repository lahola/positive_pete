//
//  ShutDownSite.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShutDownSite.h"
#import "GameManager.h"
#import "Constants.h"

@implementation ShutDownSite
@synthesize poweredUpAnim;
@synthesize poweredDownAnim;
-(void)dealloc
{
    [poweredUpAnim release];
    [poweredDownAnim release];
    [super dealloc];
}
-(void)changeState:(CharacterState)newState
{
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStatePoweredUp:
            CCLOG(@"ShutDownSite powered up!");
            action = [CCAnimate actionWithAnimation:poweredUpAnim 
                               restoreOriginalFrame:NO];
            [self body]->SetActive(true);
            break;
            
        case kStatePoweredDown:
            CCLOG(@"ShutDownSite powered down!");
            action = [CCAnimate actionWithAnimation:poweredDownAnim 
                               restoreOriginalFrame:NO];
            [[GameManager sharedGameManager] incrementScore:10];
            [self body]->SetActive(false);
            break;
         
        default:
            CCLOG(@"Unhandled shut down site state");
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}
-(void)initAnimations
{
    [self setPoweredUpAnim:[self loadPlistForAnimationWithName:@"poweredUpAnim"
                                                  andClassName:NSStringFromClass([self class])]];
    [self setPoweredDownAnim:[self loadPlistForAnimationWithName:@"poweredDownAnim"
                                                    andClassName:NSStringFromClass([self class])]];
}
-(id)init
{
    if (self = [super init]) {
        self.gameObjectType = kShutDownSiteType;
        self.characterState = kStatePoweredUp;
        [self initAnimations];
    }
    return self;
}
@end
