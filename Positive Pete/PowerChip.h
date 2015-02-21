//
//  PowerChip.h
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Box2DSprite.h"
#import "CCParticleSystem.h"

@interface PowerChip : Box2DSprite {
    CCParticleSystem *emitter;
}
@property (nonatomic, retain) CCParticleSystem *emitter;
-(void)changeState:(CharacterState)newState;
@end
