//
//  OptionsScene.m
//  Positive Pete
//
//  Created by Louis Ahola on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionsScene.h"
#import "OptionsButtonLayer.h"
#import "OptionsBackgroundLayer.h"

@implementation OptionsScene
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(id)init 
{
    self = [super init];
    if (self) {
        OptionsButtonLayer *buttonLayer = [OptionsButtonLayer node];
        OptionsBackgroundLayer *backgroundLayer = [OptionsBackgroundLayer node];
        
        [self addChild:buttonLayer z:5];
        [self addChild:backgroundLayer z:0];
    }
    return self;
}
@end