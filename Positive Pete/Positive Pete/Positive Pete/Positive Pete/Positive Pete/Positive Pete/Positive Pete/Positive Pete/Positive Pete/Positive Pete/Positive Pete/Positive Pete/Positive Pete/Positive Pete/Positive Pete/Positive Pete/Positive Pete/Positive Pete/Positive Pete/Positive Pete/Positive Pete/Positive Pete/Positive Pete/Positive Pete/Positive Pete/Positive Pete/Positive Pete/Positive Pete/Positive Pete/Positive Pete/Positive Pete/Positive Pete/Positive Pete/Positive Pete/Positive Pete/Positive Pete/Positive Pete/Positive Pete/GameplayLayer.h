//
//  GameplayLayer.h
//  Positive Pete
//
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Cannon.h"
#import "Box2D.h"
#import "Box2DSprite.h"
#import "CCLayer.h"
#import "Pete.h"
#import "TiledMap.h"
#import "GamePhysics.h"

@interface GameplayLayer : CCLayer {
    CCSpriteBatchNode *sceneSpriteBatchNode;
    TiledMap *tiledMap;
    Pete *pete;
    Cannon *cannon;
    NSMutableArray *charges;
    NSMutableArray *sites;
    NSMutableArray *chips;
    NSMutableArray *bodiesClicked;
    NSMutableArray *powerUps;
    b2Body *selectedBody;
    b2Vec2 touchOffset;
    GameState gameState;
    GamePhysics *physics;
    float xMargin;
    float yMargin;
    float iPadConstant;
}
@property (nonatomic,retain) Pete *pete;
@property (nonatomic,assign) GameState gameState;
@end
