//
//  InGameGUILayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InGameGUILayer.h"
#import "GameManager.h"

@implementation InGameGUILayer
@synthesize scoreLabel;
@synthesize pauseButtonMenu;
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(void)pauseGame
{
    [[GameManager sharedGameManager] pauseGame];
}

-(id)init
{
    if (self = [super init]) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        scoreLabel = [CCLabelTTF labelWithString:@"Score 0" fontName:@"Noteworthy-Bold" fontSize:16];  
        [scoreLabel setAnchorPoint:ccp(1,1)];
        [scoreLabel setPosition:ccp(screenSize.width,screenSize.height)];
        [self addChild:scoreLabel];
        [self scheduleUpdate];
        
        NSString *pauseButtonImageFilename;
        int positionScale = 1;
        int xMargin = 0;
        int yMargin = 0;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            pauseButtonImageFilename = [NSString stringWithString:@"pauseOff-hd.png"];
            xMargin = 32;
            yMargin = 64;
            positionScale = 2;
        } else {
            pauseButtonImageFilename = [NSString stringWithString:@"pauseOff.png"];
        }
        pauseButtonMenu = [CCMenu menuWithItems:[CCMenuItemImage itemFromNormalImage:pauseButtonImageFilename
                                                                               selectedImage:pauseButtonImageFilename target:self
                                                                                    selector:@selector(pauseGame)], nil];
        [pauseButtonMenu setPosition:ccp(xMargin + 10 * positionScale, yMargin + 10 * positionScale)];
        [self addChild:pauseButtonMenu];
    }
    return self;
}

-(void)update:(ccTime)dt
{
    GameManager *gameManager = [GameManager sharedGameManager];
    if (gameManager.dirtyScore) {
        [gameManager setDirtyScore:NO];
        [scoreLabel setString:[NSString stringWithFormat:@"Score %d",gameManager.score]]; 
    }
}
@end
