//
//  CCharacter.h
//  Sabe
//
//  Characters are physical entities with game states.
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CPhysicalEntity.h"

typedef enum
{
    kIdle,
    kSpawning,
    kDead,
} CharacterState;

@interface CCharacter : CPhysicalEntity
{
    
}
@end
