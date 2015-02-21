//
//  Pete.m
//  Positive Pete
//
//  Created by Louis Ahola on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"
#import "Pete.h"

@implementation Pete
@synthesize cannon;
@synthesize emitter;
@synthesize positiveEmitter;
@synthesize negativeEmitter;
-(void)dealloc
{
    [positiveEmitter release];
    [negativeEmitter release];
    [emitter release];
    [cannon release];
    [super dealloc];
}
-(void)changeState:(CharacterState)newState
{
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStateReady:
            [self.emitter stopSystem];
            [self setOpacity:255];
            break;
        case kStateFired:
            [self.emitter stopSystem];
            self.emitter = positiveEmitter;
            [self.emitter resetSystem];
            [self.emitter setPosition:self.position];
            [self setOpacity:255];
            break;
            
        case kStateReversed:
            [self.emitter stopSystem];
            self.emitter = negativeEmitter;
            [self.emitter resetSystem];
            action = [CCDelayTime actionWithDuration:REVERSE_TIME_DURATION];
            [self setOpacity:100];
            break;
            
        case kStateNeutral:
            [self setOpacity:100];
            action = [CCDelayTime actionWithDuration:NEUTRAL_TIME_DURATION];
            break;
            
        case kStateSpeed:
            [self setOpacity:100];
            action = [CCDelayTime actionWithDuration:SPEED_TIME_DURATION];
            break;
            
        default:
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}
                      
-(void)update:(ccTime)dt
{
    if ([self numberOfRunningActions] == 0 && self.characterState == kStateReversed) {
        [self changeState:kStateFired];
    } else if ([self numberOfRunningActions] == 0 && self.characterState == kStateNeutral) {
        [self changeState:kStateFired];
    } else if ([self numberOfRunningActions] == 0 && self.characterState == kStateSpeed) {
        [self changeState:kStateFired];
    }
    
    [[self emitter] setPosition:[self position]];
}

-(id)init
{
    self = [super init];
    if (self != nil) {
        self.gameObjectType = kPeteType;
        self.characterState = kStateReady;
        [self scheduleUpdate];
    }
    return self;
}
@end
