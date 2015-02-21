//
//  PauseScreenGUILayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PauseScreenGUILayer.h"
#import "GameManager.h"
#import "cocos2d.h"

@implementation PauseScreenGUILayer
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(void)returnToGame
{
    [[GameManager sharedGameManager] unpauseGame];
}
-(void)goToMainMenu
{
    [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}
-(void)goToOptionsMenu
{
    [[GameManager sharedGameManager] runSceneWithID:kOptionsScene];
}
-(void)restartLevel
{
    [[GameManager sharedGameManager] reloadCurrentLevel];
}
-(id)init
{
    if (self = [super initWithColor:ccc4(200, 200, 200, 170) width:[[CCDirector sharedDirector] winSize].width/4 height:([[CCDirector sharedDirector] winSize].height/1.5)]) {
        NSString *returnImageFilename;
        NSString *mainMenuImageFilename;
        NSString *restartLevelImageFilename;
        NSString *optionsMenuImageFilename;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            returnImageFilename = [NSString stringWithString:@"resumeButton-hd.png"];
            mainMenuImageFilename = [NSString stringWithString:@"mainButton-hd.png"];
            restartLevelImageFilename = [NSString stringWithString:@"restartButton-hd.png"];
            optionsMenuImageFilename = [NSString stringWithString:@"optionsButton-hd.png"];
        } else {
            returnImageFilename = [NSString stringWithString:@"resumeButton.png"];
             mainMenuImageFilename = [NSString stringWithString:@"mainButton.png"];
            restartLevelImageFilename = [NSString stringWithString:@"restartButton.png"];
            optionsMenuImageFilename = [NSString stringWithString:@"optionsButton.png"];
        }
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCMenuItemImage *returnItem = [CCMenuItemImage itemFromNormalImage:returnImageFilename
                                                             selectedImage:returnImageFilename target:self
                                                                  selector:@selector(returnToGame)];
        CCMenuItemImage *mainMenuItem = [CCMenuItemImage itemFromNormalImage:mainMenuImageFilename
                                                             selectedImage:mainMenuImageFilename target:self
                                                                  selector:@selector(goToMainMenu)];
        CCMenuItemImage *optionsMenuItem = [CCMenuItemImage itemFromNormalImage:optionsMenuImageFilename
                                                               selectedImage:optionsMenuImageFilename target:self
                                                                    selector:@selector(goToOptionsMenu)];
        CCMenuItemImage *restartLevelMenuItem = [CCMenuItemImage itemFromNormalImage:restartLevelImageFilename
                                                               selectedImage:restartLevelImageFilename target:self
                                                                    selector:@selector(restartLevel)];
        CCMenu *pauseMenu = [CCMenu menuWithItems:returnItem,restartLevelMenuItem,optionsMenuItem,mainMenuItem, nil];
        [pauseMenu alignItemsVerticallyWithPadding:8];
        [pauseMenu setPosition:ccp(winSize.width/8,winSize.height/3)];
        

        [self addChild:pauseMenu];
    }
    return self;
}
@end
