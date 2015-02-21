//
//  Box2DSprite.h
//  Positive Pete
//
//  Created by Louis Ahola on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "Box2D.h"
#import "GameCharacter.h"

@interface Box2DSprite : GameCharacter {
    b2Body *body;
}
@property (assign) b2Body *body;
@end
