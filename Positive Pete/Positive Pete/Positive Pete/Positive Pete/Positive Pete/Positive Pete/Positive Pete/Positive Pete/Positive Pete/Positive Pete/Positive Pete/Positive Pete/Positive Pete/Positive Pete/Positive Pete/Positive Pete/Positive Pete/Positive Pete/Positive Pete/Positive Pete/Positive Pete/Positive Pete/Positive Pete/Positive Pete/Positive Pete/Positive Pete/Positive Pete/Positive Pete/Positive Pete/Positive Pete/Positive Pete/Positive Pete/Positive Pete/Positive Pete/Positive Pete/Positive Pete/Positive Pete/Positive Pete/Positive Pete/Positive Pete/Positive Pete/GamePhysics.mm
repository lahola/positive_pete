//
//  GamePhysics.m
//  Positive Pete
//
//  Created by Louis Ahola on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePhysics.h"
#import "Constants.h"

@implementation GamePhysics
@synthesize world;
-(void)dealloc
{   
    if(world) {
        delete world;
        world = NULL;
    }
    if(contactListener) {
        delete contactListener;
        contactListener = NULL;
    }
    [super dealloc];
}
-(void)createTileBodyAt:(CGPoint)location
               friction:(float32)friction
            restitution:(float32)restitution
                density:(float32)density
                  width:(int)width 
{
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,
                              location.y/PTM_RATIO);
    bodyDef.allowSleep = true;
    b2Body *body = world->CreateBody(&bodyDef);
    
    b2FixtureDef fixtureDef;
    
    b2PolygonShape shape;
    shape.SetAsBox(width/2/PTM_RATIO, 
                   width/2/PTM_RATIO);
    fixtureDef.shape = &shape;
    
    fixtureDef.density = density;
    fixtureDef.friction = friction;
    fixtureDef.restitution = restitution;
    
    body->CreateFixture(&fixtureDef);    
}


-(b2Body*)createBodyAtLocation:(CGPoint)location
                     forSprite:(Box2DSprite*)sprite
                      friction:(float32)friction
                   restitution:(float32)restitution
                       density:(float32)density
                         isBox:(BOOL)isBox 
                      bodyType:(b2BodyType)bodyType
                     canRotate:(BOOL)canRotate
{
    b2BodyDef bodyDef;
    bodyDef.type = bodyType;
    bodyDef.fixedRotation = !canRotate;
    
    bodyDef.position = b2Vec2(location.x/PTM_RATIO,
                              location.y/PTM_RATIO);
    bodyDef.allowSleep = false;
    bodyDef.bullet = true;
    b2Body *body = world->CreateBody(&bodyDef);
    body->SetUserData(sprite);
    sprite.body = body;
    
    b2FixtureDef fixtureDef;
    
    if (isBox) {
        b2PolygonShape shape;
        shape.SetAsBox(sprite.contentSize.width/2/iPadContentScale/PTM_RATIO, 
                       sprite.contentSize.height/2/iPadContentScale/PTM_RATIO);
        fixtureDef.shape = &shape;
    } else {
        b2CircleShape shape;
        shape.m_radius = sprite.contentSize.width/2/iPadContentScale/PTM_RATIO;
        fixtureDef.shape = &shape;
    }
    
    fixtureDef.density = density;
    fixtureDef.friction = friction;
    fixtureDef.restitution = restitution;
    
    body->CreateFixture(&fixtureDef);
    
    return body;
}


-(void)setupWorld
{   
    b2Vec2 gravity = b2Vec2(0.0f, 0.0f);//ACCELERATION_OF_GRAVITY);
    bool doSleep = true;
    world = new b2World(gravity, doSleep);
}

- (void)createGround 
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float xMargin = 0.0f;
    float ipadRatio = 1.0f;
    float yMargin = 0.0f;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        xMargin = 32.0f;
        yMargin = 64.0f;
        ipadRatio = 2.0f;
    }
    b2Vec2 lowerLeft = b2Vec2(0.0f, 0.0f);
    b2Vec2 lowerRight = b2Vec2(((winSize.width-xMargin*2)/ipadRatio)/PTM_RATIO,
                               0.0f);
    b2Vec2 upperRight = b2Vec2(((winSize.width-xMargin*2)/ipadRatio)/PTM_RATIO,
                               ((winSize.height-yMargin*2)/ipadRatio)/PTM_RATIO);
    b2Vec2 upperLeft = b2Vec2(0.0f,
                              ((winSize.height-yMargin*2)/ipadRatio)/PTM_RATIO);
    b2BodyDef groundBodyDef;
    groundBodyDef.type = b2_staticBody;
    groundBodyDef.position.Set(0, 0);
    groundBody = world->CreateBody(&groundBodyDef);
    b2PolygonShape groundShape;
    b2FixtureDef groundFixtureDef;
    groundFixtureDef.shape = &groundShape;
    groundFixtureDef.density = 0.0;
    groundShape.SetAsEdge(lowerLeft, lowerRight);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(lowerRight, upperRight);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(upperRight, upperLeft);
    groundBody->CreateFixture(&groundFixtureDef);
    groundShape.SetAsEdge(upperLeft, lowerLeft);
    groundBody->CreateFixture(&groundFixtureDef);
}

-(void)initContactListener
{
    contactListener = new ContactListener();
    world->SetContactListener(contactListener);
}

-(id)init 
{
    self = [super init];
    
    if (self) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            iPadContentScale = 2.0f;
        } else {
            iPadContentScale = 1.0f;
        }
        
        [self setupWorld];
        [self initContactListener];
        [self createGround];
    }
    
    return self;
}
@end
