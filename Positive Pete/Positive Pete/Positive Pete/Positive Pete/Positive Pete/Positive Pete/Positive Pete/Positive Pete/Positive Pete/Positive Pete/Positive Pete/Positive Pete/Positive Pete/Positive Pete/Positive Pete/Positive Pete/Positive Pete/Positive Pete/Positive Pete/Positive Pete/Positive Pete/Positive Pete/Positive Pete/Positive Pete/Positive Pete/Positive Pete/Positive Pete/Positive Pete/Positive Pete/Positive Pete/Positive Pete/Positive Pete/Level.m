//
//  Level.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level.h"

@implementation Level
@synthesize levelName;
@synthesize fileName;
@synthesize oneStarScore;
@synthesize twoStarScore;
@synthesize threeStarScore;
-(void)dealloc
{
    [levelName release];
    [fileName release];
    [super dealloc];
}
@end
