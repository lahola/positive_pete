//
//  CObject.h
//  Sabe
//
//  Objects are the building blocks of the engine.
//  Everything is an object.  An object has a name.
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameConfig.h"

typedef enum
{
    kObject,
    kEntity,
    kAnimation,
    kLevel,
} CObjectType;

@interface CObject : NSObject
{
    NSString* _name;
    NSString* _ns;
    CObjectType _objectType;
}
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* ns;
@property(nonatomic, assign) CObjectType objectType;
@end
