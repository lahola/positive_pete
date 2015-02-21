//
//  Cannon.m
//  Positive Pete
//
//  Created by Louis Ahola on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Cannon.h"
#import "Constants.h"

@implementation Cannon
@synthesize direction;
@synthesize readyAnim;
@synthesize firedAnim;
@synthesize firingAnim;
@synthesize initialVelocity;
-(void)dealloc
{
    [readyAnim release];
    [firedAnim release];
    [firingAnim release];
    [super dealloc];
}
-(void)changeState:(CharacterState)newState {
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStateReady:
            CCLOG(@"Cannon in ready state");
            action = [CCAnimate actionWithDuration:.7 animation:readyAnim 
                               restoreOriginalFrame:NO];
            break;
            
        case kStateFiring:
            CCLOG(@"Cannon is firing");
            action = [CCAnimate actionWithDuration:.7 animation:firingAnim 
                               restoreOriginalFrame:NO];
            break;
            
        case kStateFired:
            CCLOG(@"Cannon has fired");
            action = [CCAnimate actionWithDuration:.7 animation:firedAnim 
                               restoreOriginalFrame:NO];
            break;

        default:
            CCLOG(@"Unhandled state %d in RadarDish", newState);
            break;
    }
    if (action != nil) {
        id actionToRun = [CCRepeatForever actionWithAction:action];
        [self runAction:actionToRun];
    }
}
-(void)initAnimations
{
    [self setReadyAnim:[self loadPlistForAnimationWithName:@"readyAnim"
                                       andClassName:NSStringFromClass([self class])]];
    [self setFiringAnim:[self loadPlistForAnimationWithName:@"firingAnim"
                                       andClassName:NSStringFromClass([self class])]];
    [self setFiredAnim:[self loadPlistForAnimationWithName:@"firedAnim"
                                       andClassName:NSStringFromClass([self class])]];
}
-(id)init
{
    if((self = [super init])) {
        gameObjectType = kCannonType;
        [self initAnimations];
        [self setInitialVelocity:50.0f];
    }
    return self;
}
@end
