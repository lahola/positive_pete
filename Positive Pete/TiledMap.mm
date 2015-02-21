//
//  TileMap.m
//  Positive Pete
//
//  Created by Louis Ahola on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TiledMap.h"
#import "GameManager.h"

@implementation TiledMap
@synthesize xScreenBuffer;
@synthesize yScreenBuffer;
@synthesize tiledMap;
-(void)dealloc
{
    [tiledMap release];
    [super dealloc];
}
-(void)initTiles:(GamePhysics *)physics
{
    //int tileWidth = self.tiledMap.tileSize.width/2;
    int xBuffer = self.xScreenBuffer;
    int yBuffer = self.yScreenBuffer;
    
    CCTMXLayer *tiledLayer = [self.tiledMap layerNamed:@"Tile Layer 1"];
    NSDictionary *dict;
    int gid;
    for (int row = 0; row < self.tiledMap.mapSize.height; row++) {
        for (int col = 0; col < self.tiledMap.mapSize.width; col++) {
            gid = [tiledLayer tileGIDAt:ccp(col,row)];
            dict = [self.tiledMap propertiesForGID:gid];
            NSString *collidable = [dict objectForKey:@"Collidable"];
            if (collidable && [collidable isEqualToString:@"True"]) {
                CCSprite *sprite = [tiledLayer tileAt:ccp(col,row)];
                
                int tileWidth = sprite.boundingBox.size.width/2;
                int tileHeight = sprite.boundingBox.size.height/2;
                
                int ipadConstant = 1;
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    ipadConstant = 2;
                }
                
                tileWidth /= ipadConstant;
                tileHeight /= ipadConstant;
                
                [sprite setPosition:ccp(sprite.position.x + xBuffer, sprite.position.y + yBuffer)];
                NSString *color = [dict objectForKey:@"Color"];
                if ([color isEqualToString:@"Blue"]) {
                    [physics createTileBodyAt:ccp((sprite.position.x-xBuffer)/ipadConstant + tileWidth,
                                                  (sprite.position.y-yBuffer)/ipadConstant + tileHeight)
                                     friction:0.5f 
                                  restitution:0.5f 
                                      density:1.0f
                                        width:tileWidth*2];
                } else if ([color isEqualToString:@"Green"]) {
                    [physics createTileBodyAt:ccp(((sprite.position.x-xBuffer)/ipadConstant) + tileWidth,
                                                  ((sprite.position.y-yBuffer)/ipadConstant) + tileHeight)
                                     friction:0.0f 
                                  restitution:0.0f 
                                      density:1.0f
                                        width:tileWidth*2];
                } else if ([color isEqualToString:@"Yellow"]) {
                    [physics createTileBodyAt:ccp((sprite.position.x-xBuffer)/ipadConstant + tileWidth,
                                                  (sprite.position.y-yBuffer)/ipadConstant + tileHeight)
                                     friction:1.0f 
                                  restitution:1.0f 
                                      density:1.0f
                                        width:tileWidth*2];
                    
                } else if ([color isEqualToString:@"Purple"]) {
                    [physics createTileBodyAt:ccp((sprite.position.x-xBuffer)/ipadConstant + tileWidth,
                                                  (sprite.position.y-yBuffer)/ipadConstant + tileHeight)
                                     friction:1.0f 
                                  restitution:0.0f 
                                      density:1.0f
                                        width:tileWidth*2];
                }
            }
        }
    }
}
-(id)init
{
    self = [super init];
    
    if (self) {
        int currentLevel = [[GameManager sharedGameManager] currentLevel];
        Level *level = [[GameManager sharedGameManager] loadLevelFromPlist:currentLevel];
        NSString *tilemapFilename;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            tilemapFilename = [NSString stringWithFormat:@"%@-hd.tmx",[level fileName]];
            self.tiledMap = [CCTMXTiledMap 
                                 tiledMapWithTMXFile:tilemapFilename];
            self.xScreenBuffer = 32;
            self.yScreenBuffer = 64;
        } else {
            tilemapFilename = [NSString stringWithFormat:@"%@.tmx",[level fileName]];
            self.tiledMap = [CCTMXTiledMap 
                                 tiledMapWithTMXFile:tilemapFilename];
            self.xScreenBuffer = 0;
            self.yScreenBuffer = 0;
        }
    }
    return self;
}
@end
