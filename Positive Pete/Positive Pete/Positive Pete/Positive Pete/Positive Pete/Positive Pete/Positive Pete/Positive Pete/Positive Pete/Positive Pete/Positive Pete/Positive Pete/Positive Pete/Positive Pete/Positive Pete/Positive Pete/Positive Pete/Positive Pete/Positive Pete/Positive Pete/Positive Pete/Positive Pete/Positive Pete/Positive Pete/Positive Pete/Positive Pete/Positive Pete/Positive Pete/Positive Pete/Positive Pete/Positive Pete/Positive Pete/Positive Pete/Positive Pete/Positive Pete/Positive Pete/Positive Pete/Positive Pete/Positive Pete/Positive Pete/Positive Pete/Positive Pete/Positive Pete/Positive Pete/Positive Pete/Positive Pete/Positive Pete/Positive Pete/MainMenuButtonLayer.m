//
//  MainMenuButtonLayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "cocos2d.h"
#import "GameManager.h"
#import "MainMenuButtonLayer.h"

@implementation MainMenuButtonLayer
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(void)displaySceneSelection 
{
    //[[GameManager sharedGameManager] setCurrentLevel:1];
    //[[GameManager sharedGameManager] runSceneWithID:kGameScene];
    [[GameManager sharedGameManager] runSceneWithID:kLevelSelectScene];
}
-(void)displaySettings 
{
    [[GameManager sharedGameManager] runSceneWithID:kOptionsScene];
}
-(id)init 
{
    self = [super init];
    
    if (self) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        NSString *levelSelectOnFilename;
        NSString *levelSelectOffFilename;
        NSString *optionsOnFilename;
        NSString *optionsOffFilename;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            levelSelectOnFilename = [NSString stringWithString:@"playon-hd.png"];
            levelSelectOffFilename = [NSString stringWithString:@"playoff-hd.png"];
            optionsOnFilename = [NSString stringWithString:@"optionson-hd.png"];
            optionsOffFilename = [NSString stringWithString:@"optionsoff-hd.png"];
        } else {
            levelSelectOnFilename = [NSString stringWithString:@"playon.png"];
            levelSelectOffFilename = [NSString stringWithString:@"playoff.png"];
            optionsOnFilename = [NSString stringWithString:@"optionson.png"];
            optionsOffFilename = [NSString stringWithString:@"optionsoff.png"];
        }
        
        CCMenuItemImage *playGameButton = [CCMenuItemImage itemFromNormalImage:levelSelectOffFilename
                                                                 selectedImage:levelSelectOnFilename
                                                                 disabledImage:nil
                                                                        target:self
                                                                      selector:@selector(displaySceneSelection)];
        CCMenuItemImage *settingsButton = [CCMenuItemImage itemFromNormalImage:optionsOffFilename
                                                                selectedImage:optionsOnFilename
                                                                disabledImage:nil
                                                                       target:self
                                                                     selector:@selector(displaySettings)];

        CCMenu *mainMenu = [CCMenu menuWithItems:playGameButton, settingsButton, nil];
        [mainMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
        [mainMenu setPosition:ccp(screenSize.width * 2,
                                  screenSize.height / 2)];
        id moveAction = [CCMoveTo actionWithDuration:1.2f
                                            position:ccp(screenSize.width * 0.75,
                                                         screenSize.height/2)];
        id moveEffect = [CCEaseIn actionWithAction:moveAction rate:5.0f];
        [mainMenu runAction:moveEffect];
        [self addChild:mainMenu z:0];
    }
    return self;
}
@end
