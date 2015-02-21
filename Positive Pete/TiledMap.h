//
//  TileMap.h
//  Positive Pete
//
//  Created by Louis Ahola on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePhysics.h"
#import "CCTMXTiledMap.h"

@interface TiledMap : NSObject {
    int xScreenBuffer;
    int yScreenBuffer;
    CCTMXTiledMap *tiledMap;
}
@property (nonatomic,assign) int xScreenBuffer;
@property (nonatomic,assign) int yScreenBuffer;
@property (nonatomic,retain) CCTMXTiledMap *tiledMap;
-(void)initTiles:(GamePhysics*)physics;
@end
