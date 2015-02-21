//
//  GameCharacter.h
//  Positive Pete
//
//  Created by Louis Ahola on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"
#import "Constants.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameCharacter : GameObject {
    CharacterState characterState;
}
-(void)changeState:(CharacterState)newState;
@property (nonatomic, assign) CharacterState characterState;
@end
