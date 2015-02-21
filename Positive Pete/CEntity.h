//
//  CEntity.h
//  Sabe
//
//  Entities are objects with Componenents and Sprites
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CObject.h"
#import "cocos2d.h"

@interface CEntity : CObject
{
    NSArray* _animations;
    NSMutableArray* _components;
    CCSprite* _sprite;
}
@property(nonatomic, retain) NSArray* animations;
@property(nonatomic, retain) NSMutableArray* components;
@property(nonatomic, retain) CCSprite* sprite;
@end
