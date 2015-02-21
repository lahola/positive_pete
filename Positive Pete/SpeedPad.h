//
//  SpeedPad.h
//  Positive Pete
//
//  Created by Louis Ahola on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Box2DSprite.h"

@interface SpeedPad : Box2DSprite {
    CCParticleSystem *emitter;
}
@property (nonatomic, retain) CCParticleSystem *emitter;
-(void)changeState:(CharacterState)newState;
@end

