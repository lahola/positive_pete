//
//  GamePhysics.h
//  Positive Pete
//
//  Created by Louis Ahola on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
#import "ContactListener.h"
#import "Box2DSprite.h"

@interface GamePhysics : NSObject {
    b2World *world;
    b2Body *groundBody;
    ContactListener *contactListener;
    int iPadContentScale;
}

@property (nonatomic, readonly) b2World *world;

-(b2Body*)createBodyAtLocation:(CGPoint)location
                     forSprite:(Box2DSprite*)sprite
                      friction:(float32)friction
                   restitution:(float32)restitution
                       density:(float32)density
                         isBox:(BOOL)isBox 
                      bodyType:(b2BodyType)bodyType
                     canRotate:(BOOL)canRotate;

-(void)createTileBodyAt:(CGPoint)location
               friction:(float32)friction
            restitution:(float32)restitution
                density:(float32)density
                  width:(int)width;
@end
