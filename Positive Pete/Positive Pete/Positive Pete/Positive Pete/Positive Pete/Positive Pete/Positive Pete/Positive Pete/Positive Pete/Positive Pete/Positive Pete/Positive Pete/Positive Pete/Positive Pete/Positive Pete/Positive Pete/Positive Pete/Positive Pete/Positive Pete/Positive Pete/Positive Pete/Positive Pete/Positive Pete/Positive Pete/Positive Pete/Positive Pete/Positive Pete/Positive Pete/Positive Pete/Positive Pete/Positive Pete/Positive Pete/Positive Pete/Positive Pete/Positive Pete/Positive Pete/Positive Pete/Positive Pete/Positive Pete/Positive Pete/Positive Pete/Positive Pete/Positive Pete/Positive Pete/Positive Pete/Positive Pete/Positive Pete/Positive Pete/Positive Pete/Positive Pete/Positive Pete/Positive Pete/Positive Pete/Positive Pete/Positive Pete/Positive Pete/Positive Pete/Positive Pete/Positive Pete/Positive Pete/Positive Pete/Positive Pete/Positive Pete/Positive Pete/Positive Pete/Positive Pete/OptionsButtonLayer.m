//
//  OptionsButtonLayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "cocos2d.h"
#import "GameManager.h"
#import "OptionsButtonLayer.h"

@implementation OptionsButtonLayer
@synthesize musicButton;
@synthesize sfxButton;
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [sfxButton release];
    [musicButton release];
    [super dealloc];
}
-(void)mainMenu
{
    [[GameManager sharedGameManager] saveSoundPreferences];
    [[GameManager sharedGameManager] runSceneWithID:kMainMenuScene];
}
-(void)soundOn
{
    [sfxButton setNormalImage:[CCSprite spriteWithFile:sfxOnFilename]];
    [[GameManager sharedGameManager] setSoundMuted:NO];
}
-(void)soundOff
{
    [sfxButton setNormalImage:[CCSprite spriteWithFile:sfxOffFilename]];
    [[GameManager sharedGameManager] setSoundMuted:YES];
}
-(void)musicOn
{
    [musicButton setNormalImage:[CCSprite spriteWithFile:musicOnFilename]];
    [[GameManager sharedGameManager] setSoundMuted:NO];
}
-(void)musicOff 
{
    [musicButton setNormalImage:[CCSprite spriteWithFile:musicOffFilename]];
    [[GameManager sharedGameManager] setSoundMuted:YES];
}
-(id)init 
{
    self = [super init];
    
    if (self) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        NSString *mainMenuOnFilename;
        NSString *mainMenuOffFilename;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            musicOnFilename = [NSString stringWithString:@"musicOn-hd.png"];
            musicOffFilename = [NSString stringWithString:@"musicOff-hd.png"];
            sfxOnFilename = [NSString stringWithString:@"sfxOn-hd.png"];
            sfxOnFilename = [NSString stringWithString:@"sfxOff-hd.png"];
            mainMenuOnFilename = [NSString stringWithString:@"mainMenuButtonOn-hd.png"];
            mainMenuOffFilename = [NSString stringWithString:@"mainMenuButtonOff-hd.png"];
        } else {
            musicOnFilename = [NSString stringWithString:@"musicOn.png"];
            musicOffFilename = [NSString stringWithString:@"musicOff.png"];
            sfxOnFilename = [NSString stringWithString:@"sfxOn.png"];
            sfxOnFilename = [NSString stringWithString:@"sfxOff.png"];
            mainMenuOnFilename = [NSString stringWithString:@"mainMenuButtonOn.png"];
            mainMenuOffFilename = [NSString stringWithString:@"mainMenuButtonOff.png"];
        }
        
        bool musicMuted = [[GameManager sharedGameManager] musicMuted];
        bool soundMuted = [[GameManager sharedGameManager] soundMuted];
        
        if (!musicMuted) {
            musicButton = [CCMenuItemImage itemFromNormalImage:musicOnFilename
                                                                 selectedImage:nil
                                                                 disabledImage:nil
                                                                        target:self
                                                                      selector:@selector(musicOn)];
        } else {
            musicButton = [CCMenuItemImage itemFromNormalImage:musicOffFilename
                                               selectedImage:nil
                                               disabledImage:nil
                                                      target:self
                                                    selector:@selector(musicOff)];
        }
        
        if (!soundMuted) {
            sfxButton = [CCMenuItemImage itemFromNormalImage:sfxOnFilename
                                               selectedImage:nil
                                               disabledImage:nil
                                                      target:self
                                                    selector:@selector(soundOn)];
        } else {
            sfxButton = [CCMenuItemImage itemFromNormalImage:sfxOffFilename
                                                selectedImage:nil
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(soundOff)];
        }
        
        CCMenuItemImage *mainMenuButton = [CCMenuItemImage itemFromNormalImage:mainMenuOffFilename
                                                                 selectedImage:mainMenuOnFilename
                                                                 disabledImage:nil
                                                                        target:self
                                                                      selector:@selector(mainMenu)];
        
        optionsMenu = [CCMenu menuWithItems:musicButton, sfxButton, mainMenuButton, nil];
        

        [optionsMenu alignItemsVerticallyWithPadding:screenSize.height * 0.059f];
        [optionsMenu setPosition:ccp(screenSize.width * 2,
                                  screenSize.height / 2)];
        id moveAction = [CCMoveTo actionWithDuration:1.2f
                                            position:ccp(screenSize.width * 0.75,
                                                         screenSize.height/2)];
        id moveEffect = [CCEaseIn actionWithAction:moveAction rate:5.0f];
        [optionsMenu runAction:moveEffect];
        [self addChild:optionsMenu z:0];
    }
    return self;
}
@end
