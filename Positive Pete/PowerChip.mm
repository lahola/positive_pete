//
//  PowerChip.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PowerChip.h"
#import "GameScene.h"
#import "GameManager.h"
#import "CCParticleSystem.h"

@implementation PowerChip
@synthesize emitter;
-(void)dealloc
{
    [emitter release];
    [super dealloc];
}
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
            [[GameManager sharedGameManager] incrementScore:POWER_CHIP_SCORE];
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
        self.gameObjectType = kPowerChipType;
        self.characterState = kStateAvailable;
    }
    return self;
}
@end
