//
//  CObjectManager.m
//  Sabe
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CObjectManager.h"

@implementation CObjectManager
-(void)dealloc
{
    [_objects release];
    [super dealloc];
}

-(bool)addObject:(CObject *)object withKey:(NSString *)key
{
    [object retain];
    [key retain];
    NSAssert([_objects objectForKey:key] == nil, @"Key already found in object manager!");
    [_objects setValue:object forKey:key];
    [key release];
    [object release];
    return true;
}

-(bool)removeObjectWithKey:(NSString *)key
{
    NSAssert([_objects objectForKey:key] != nil, @"Key not found in the dictionary!");
    [key retain];
    [_objects removeObjectForKey:key];
    [key release];
    return true;
}

static CObjectManager* _objectManager = nil;
+(CObjectManager*)manager
{
    @synchronized([CObjectManager class])
    {
        if(!_objectManager)
             _objectManager = [[self alloc] init];
        return _objectManager;
    }
    return nil;
}

-(id)init
{
    if (self = [super init])
    {
        _objects = [[NSMutableDictionary alloc] init];
    }
    else
    {
        NSAssert(false, @"Could not initialize the object manager!");
    }
    return self;
}
@end
