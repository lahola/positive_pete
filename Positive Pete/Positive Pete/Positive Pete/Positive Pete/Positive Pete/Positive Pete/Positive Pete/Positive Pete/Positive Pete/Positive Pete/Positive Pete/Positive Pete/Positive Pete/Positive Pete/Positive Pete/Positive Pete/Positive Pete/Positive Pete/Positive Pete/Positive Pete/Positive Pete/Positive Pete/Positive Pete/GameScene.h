//
//  GameScene.h
//  Positive Pete
//
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameplayLayer.h"
#import "GameBackgroundLayer.h"
#import "InGameGUILayer.h"
#import "CCScene.h"
#import "PauseScreenGUILayer.h"

@interface GameScene : CCScene {
    InGameGUILayer *guiLayer;
    GameBackgroundLayer *backgroundLayer;
    GameplayLayer *gameplayLayer;
    PauseScreenGUILayer *pauseScreenLayer;
}
-(void)pauseScene;
-(void)unpauseScene;
@end
