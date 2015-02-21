//
//  GameObject.h
//  Positive Pete
//
//  Created by Louis Ahola on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSprite.h"

@interface GameObject : CCSprite {
    GameObjectType gameObjectType;
}
@property (nonatomic, assign) GameObjectType gameObjectType;
-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName andClassName:(NSString*)className;
@end
