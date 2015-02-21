//
//  Cannon.h
//  Positive Pete
//
//  Created by Louis Ahola on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "GameObject.h"
#import "CCSprite.h"
#import "GameCharacter.h"
#import "cocos2d.h"
#import <Foundation/Foundation.h>
#import "Constants.h"
#import "Box2DSprite.h"

@interface Cannon : Box2DSprite {
    CannonDirection direction;
    CCAnimation *readyAnim;
    CCAnimation *firingAnim;
    CCAnimation *firedAnim;
    float initialVelocity;
}
-(void)changeState:(CharacterState)newState;
@property (nonatomic, assign) CannonDirection direction;
@property (nonatomic, retain) CCAnimation *readyAnim;
@property (nonatomic, retain) CCAnimation *firingAnim;
@property (nonatomic, retain) CCAnimation *firedAnim;
@property (nonatomic, assign) float initialVelocity;
@end
