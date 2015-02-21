//
//  CIntro.m
//  Sabe
//
//  Created by Louis Ahola on 8/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CIntro.h"

@implementation CIntro
-(id)init
{
    if (self = [super init])
    {
        [self setCurrentScene:[HelloWorldLayer scene]];
    }
    return self;
}
@end
