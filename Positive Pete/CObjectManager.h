//
//  CObjectManager.h
//  Sabe
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CObject.h"

@interface CObjectManager : NSObject
{
    NSMutableDictionary* _objects;
}
+(CObjectManager*)manager;
-(bool)addObject:(CObject*)object withKey:(NSString*)key;
-(bool)removeObjectWithKey:(NSString*)key;
@end
