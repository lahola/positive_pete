//
//  Pole.m
//  Positive Pete
//
//  Created by Louis Ahola on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Pole.h"

@implementation Pole
-(void)dealloc
{
    [super dealloc];
}
-(void)changeState:(CharacterState)newState
{
    [self stopAllActions];
    id action = nil;
    
    switch (newState) {
        case kStateIdle:

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
    }
    return self;
}
@end
