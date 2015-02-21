//
//  GameCharacter.m
//  Positive Pete
//
//  Created by Louis Ahola on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCharacter.h"

@implementation GameCharacter
@synthesize characterState;
-(void)changeState:(CharacterState)newState
{
    //OVERRIDE THIS METHOD
}
-(id)init
{
    if((self = [super init])) {
        characterState = kStateReady;
    }
    return self;
}
@end
