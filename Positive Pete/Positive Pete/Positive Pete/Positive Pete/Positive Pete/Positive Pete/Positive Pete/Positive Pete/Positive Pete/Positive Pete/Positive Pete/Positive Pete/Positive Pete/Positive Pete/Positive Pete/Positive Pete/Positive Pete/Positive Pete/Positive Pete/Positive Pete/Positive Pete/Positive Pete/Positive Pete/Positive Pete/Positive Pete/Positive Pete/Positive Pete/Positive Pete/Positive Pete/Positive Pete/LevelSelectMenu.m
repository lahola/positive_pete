//
//  LevelSelectMenu.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectMenu.h"
#import "CCTouchDispatcher.h"
#import "CCDirector.h"
#import "cocos2d.h"

@implementation LevelSelectMenu
-(id)init
{
    if (self = [super init]) {
        
    }
    return self;
}
-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:NO];
}
-(void)resetSelection
{
	[selectedItem_ unselected];
	selectedItem_ = nil;
	state_ = kCCMenuStateWaiting;
}
@end
