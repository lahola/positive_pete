//
//  NeutralPad.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NeutralPad.h"

@implementation NeutralPad
@synthesize emitter;
-(void)changeState:(CharacterState)newState
{
    [self stopAllActions];
    id action = nil;
    [self setCharacterState:newState];
    
    switch (newState) {
        case kStateAvailable:
            [self body]->SetActive(true);
            [self setVisible:YES];
            break;
            
        case kStatePickedUp:
            [self body]->SetActive(false);
            [self setVisible:NO];
            [emitter setPosition:[self position]];
            [emitter resetSystem];
            break;
            
        default:
            break;
    }
    if (action != nil) {
        [self runAction:action];
    }
}
-(id)init
{
    if (self = [super init]) {
        self.gameObjectType = kNeutralPadType;
        self.characterState = kStateAvailable;
    }
    return self;
}
@end
