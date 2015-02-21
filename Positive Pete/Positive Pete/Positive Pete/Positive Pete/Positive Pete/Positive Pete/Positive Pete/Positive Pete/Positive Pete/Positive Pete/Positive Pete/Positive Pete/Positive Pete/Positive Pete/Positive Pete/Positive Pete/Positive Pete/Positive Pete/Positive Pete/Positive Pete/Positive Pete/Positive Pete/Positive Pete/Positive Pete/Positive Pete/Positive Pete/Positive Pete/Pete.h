//
//  Pete.h
//  Positive Pete
//
//  Created by Louis Ahola on 3/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCharacter.h"
#import "Box2D.h"
#import "Box2DSprite.h"
#import "Cannon.h"

@interface Pete : Box2DSprite {
    Cannon *cannon;
    CCParticleSystem *emitter;
    CCParticleSystem *positiveEmitter;
    CCParticleSystem *negativeEmitter;
}
@property (nonatomic, retain) Cannon *cannon;
@property (nonatomic, retain) CCParticleSystem *emitter;
@property (nonatomic, retain) CCParticleSystem *positiveEmitter;
@property (nonatomic, retain) CCParticleSystem *negativeEmitter;
-(void)changeState:(CharacterState)newState;
@end
