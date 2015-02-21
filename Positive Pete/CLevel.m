//
//  CLevel.m
//  Sabe
//
//  Created by Louis Ahola on 8/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CLevel.h"

@implementation CLevel
@synthesize currentScene = _currentScene;
-(void)dealloc
{
    [_currentScene release];
    [super dealloc];
}

-(id)init
{
    if (self = [super init])
    {
        // Do stuff
    }
    else
    {
        NSAssert(NO, @"Could not initialize the level!");
    }
    return self;
}
@end
