//
//  GameplayLayer.m
//  Positive Pete
// 
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameplayLayer.h"
#import "GameManager.h"
#import "Constants.h"
#import "Cannon.h"
#import "SimpleQueryCallback.h"
#import "Box2DSprite.h"
#import "GameScene.h"
#import "ShutDownSite.h"

@implementation GameplayLayer
@synthesize pete;
@synthesize gameState;
-(void)dealloc
{
    [sceneSpriteBatchNode removeAllChildrenWithCleanup:YES];
    [self removeAllChildrenWithCleanup:YES];
    [pete release];
    [tiledMap release];
    [charges release];
    [chips release];
    [sites release];
    [physics release];
    [bodiesClicked release];
    [powerUps release];
    [super dealloc];
}

-(void)initTileMap
{        
    tiledMap = [[TiledMap alloc] init];
}

-(void)initTiles
{
    [self initTileMap];
    [tiledMap initTiles:physics];
    [self addChild:[tiledMap tiledMap]];
}

-(void)initObjects
{
    float pixelToPointRatio = [[GameManager sharedGameManager] pixelToPointRatio];
    int xBuffer = tiledMap.xScreenBuffer;
    int yBuffer = tiledMap.yScreenBuffer;
    xMargin = xBuffer;
    yMargin = yBuffer;
    NSMutableDictionary *obj;
    CCTMXObjectGroup *objGroup = [tiledMap.tiledMap objectGroupNamed:@"Object Layer 1"];
    
    for (obj in [objGroup objects]) {
        // dividing by 2 because hd is fuckin up coordinatess
        int x = [[obj valueForKey:@"x"] intValue]/2;
        int y = [[obj valueForKey:@"y"] intValue]/2;
        
        NSString *type = [obj valueForKey:@"type"];
        
        if (type && [type isEqualToString:@"launcher"]) {
            NSAssert(cannon == nil, @"Cannon already created!");
            cannon = [Cannon spriteWithSpriteFrameName:@"launcher_1.png"];
            [cannon setPosition:ccp((pixelToPointRatio*x)+xBuffer, (pixelToPointRatio*y)+yBuffer)];
            [cannon changeState:kStateReady];
            [cannon setGameObjectType:kCannonType];
            cannon.body = [physics createBodyAtLocation:ccp((cannon.position.x-xBuffer)/iPadConstant,(cannon.position.y-yBuffer)/iPadConstant) forSprite:cannon friction:1.0 restitution:0.0 density:1.0 isBox:YES bodyType:b2_kinematicBody canRotate:NO];
            [sceneSpriteBatchNode addChild:cannon];
        } else if (type && [type isEqualToString:@"negativePole"]) {
            Box2DSprite *pole = [Box2DSprite spriteWithSpriteFrameName:@"negativepole.png"];
            [pole setPosition:ccp((pixelToPointRatio*x)+xBuffer, (pixelToPointRatio*y)+yBuffer)];
            //[pole changeState:kStateIdle];
            [pole setGameObjectType:kNegativePoleType];
            pole.body = [physics createBodyAtLocation:ccp((pole.position.x-xBuffer)/iPadConstant,(pole.position.y - yBuffer)/iPadConstant) forSprite:pole friction:0.0f restitution:0.0f density:1.0f isBox:NO bodyType:b2_kinematicBody canRotate:NO];
            //[sceneSpriteBatchNode addChild:pole];
            [charges addObject:pole];
        } else if (type && [type isEqualToString:@"positivePole"]) {
            Box2DSprite *pole = [Box2DSprite spriteWithSpriteFrameName:@"positivepole.png"];
            [pole setPosition:ccp((pixelToPointRatio*x)+xBuffer, (pixelToPointRatio*y)+yBuffer)];
            //[pole changeState:kStateIdle];
            [pole setGameObjectType:kPositivePoleType];
            pole.body = [physics createBodyAtLocation:ccp((pole.position.x-xBuffer)/iPadConstant,(pole.position.y-yBuffer)/iPadConstant) forSprite:pole friction:0.0f restitution:0.0f density:1.0f isBox:NO bodyType:b2_kinematicBody canRotate:NO];
            //[sceneSpriteBatchNode addChild:pole];
            [charges addObject:pole];
        } else if (type && [type isEqualToString:@"shutDownSite"]) {
            ShutDownSite *shutDownSite = [ShutDownSite spriteWithSpriteFrameName:@"shutDownSite_1.png"];
            [shutDownSite setPosition:ccp((pixelToPointRatio*x)+xBuffer, (pixelToPointRatio*y)+yBuffer)];
            shutDownSite.body = [physics createBodyAtLocation:ccp((shutDownSite.position.x-xBuffer)/iPadConstant,(shutDownSite.position.y-yBuffer)/iPadConstant) forSprite:shutDownSite friction:0.0f restitution:0.0f density:0.0f isBox:YES bodyType:b2_kinematicBody canRotate:NO];
            [sceneSpriteBatchNode addChild:shutDownSite];
            [sites addObject:shutDownSite];
        } else if (type && [type isEqualToString:@"powerChip"]) {
            PowerChip *powerChip = [PowerChip spriteWithSpriteFrameName:@"powerchip.png"];
            [powerChip setPosition:ccp((pixelToPointRatio*x)+xBuffer, (pixelToPointRatio*y)+yBuffer)];
            powerChip.body = [physics createBodyAtLocation:ccp((powerChip.position.x-xBuffer)/iPadConstant,(powerChip.position.y-yBuffer)/iPadConstant) forSprite:powerChip friction:0.0f restitution:0.0f density:0.0f isBox:YES bodyType:b2_kinematicBody canRotate:NO];
            [sceneSpriteBatchNode addChild:powerChip];
            [chips addObject:powerChip];
            
            [powerChip setEmitter:[ARCH_OPTIMAL_PARTICLE_SYSTEM
                                   particleWithFile:@"powerChipEmitter.plist"]];
            [[powerChip emitter] stopSystem];
            [self addChild:[powerChip emitter] z:0];
        } else if (type && [type isEqualToString:@"speedPad"]) {
            SpeedPad *speedPad = [SpeedPad spriteWithSpriteFrameName:@"speedPad_1.png"];
            [speedPad setPosition:ccp((pixelToPointRatio*x)+xBuffer, (pixelToPointRatio*y)+yBuffer)];
            speedPad.body = [physics createBodyAtLocation:ccp((speedPad.position.x-xBuffer)/iPadConstant,(speedPad.position.y-yBuffer)/iPadConstant) forSprite:speedPad friction:0.0f restitution:0.0f density:0.0f isBox:YES bodyType:b2_kinematicBody canRotate:NO];
            [sceneSpriteBatchNode addChild:speedPad];
            [powerUps addObject:speedPad];
        } else if (type && [type isEqualToString:@"neutralPad"]) {
            NeutralPad *neutralPad = [NeutralPad spriteWithSpriteFrameName:@"neutralPad_1.png"];
            [neutralPad setPosition:ccp((pixelToPointRatio*x)+xBuffer, (pixelToPointRatio*y)+yBuffer)];
            neutralPad.body = [physics createBodyAtLocation:ccp((neutralPad.position.x-xBuffer)/iPadConstant,(neutralPad.position.y-yBuffer)/iPadConstant) forSprite:neutralPad friction:0.0f restitution:0.0f density:0.0f isBox:YES bodyType:b2_kinematicBody canRotate:NO];
            [sceneSpriteBatchNode addChild:neutralPad];
            [powerUps addObject:neutralPad];
        } else if (type && [type isEqualToString:@"reversePad"]) {
            ReversePad *reversePad = [ReversePad spriteWithSpriteFrameName:@"reversePad_1.png"];
            [reversePad setPosition:ccp((pixelToPointRatio*x)+xBuffer, (pixelToPointRatio*y)+yBuffer)];
            reversePad.body = [physics createBodyAtLocation:ccp((reversePad.position.x-xBuffer)/iPadConstant,(reversePad.position.y-yBuffer)/iPadConstant) forSprite:reversePad friction:0.0f restitution:0.0f density:0.0f isBox:YES bodyType:b2_kinematicBody canRotate:NO];
            [sceneSpriteBatchNode addChild:reversePad];
            [powerUps addObject:reversePad];
        }
    }
}

-(void)initCharges
{
    for (Box2DSprite *pole in charges) {
        [sceneSpriteBatchNode addChild:pole];
    }
}

-(void)initPete
{
    NSAssert(cannon != nil, @"NO CANNON WAS DEFINED!");
    pete = [[Pete spriteWithSpriteFrameName:@"pete.png"] retain];
    [pete setPosition:cannon.position];
    pete.body = [physics createBodyAtLocation:ccp((pete.position.x - xMargin)/iPadConstant,(pete.position.y - yMargin)/iPadConstant)
                                    forSprite:pete friction:0.0f restitution:0.0f density:1.0 isBox:NO 
                                     bodyType:b2_dynamicBody canRotate:YES];
    [pete body]->SetActive(false);
    [sceneSpriteBatchNode addChild:pete];
}

-(id)init 
{
    self = [super init];
    if (self != nil) {
        gameState = kSetupPhaseState;
        
        bodiesClicked = [[NSMutableArray alloc] init];    
        physics = [[GamePhysics alloc] init];
        chips = [[NSMutableArray alloc] init];
        sites = [[NSMutableArray alloc] init];
        charges = [[NSMutableArray alloc] init];
        powerUps = [[NSMutableArray alloc] init];
        
        [self initTiles];
        
        CCParticleSystem *negativeEmitter = [ARCH_OPTIMAL_PARTICLE_SYSTEM
                                   particleWithFile:@"peteNegativeEmitter-hd.plist"];
        CCParticleSystem *positiveEmitter = [ARCH_OPTIMAL_PARTICLE_SYSTEM
                                             particleWithFile:@"petePositiveEmitter-hd.plist"];
        [positiveEmitter stopSystem];
        [negativeEmitter stopSystem];
        [self addChild:negativeEmitter];
        [self addChild:positiveEmitter];
                
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            iPadConstant = 2.0f;
            [[CCSpriteFrameCache sharedSpriteFrameCache] 
             addSpriteFramesWithFile:@"spritesheet-hd.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode 
                               batchNodeWithFile:@"spritesheet-hd.png"];
        } else {
            [[CCSpriteFrameCache sharedSpriteFrameCache] 
             addSpriteFramesWithFile:@"spritesheet.plist"];
            sceneSpriteBatchNode = [CCSpriteBatchNode 
                               batchNodeWithFile:@"spritesheet.png"];
            iPadConstant = 1.0f;
        }
        [self initObjects];
        [self initCharges];
        [self initPete];
        [pete setPositiveEmitter:positiveEmitter];
        [pete setNegativeEmitter:negativeEmitter];
        [pete setEmitter:positiveEmitter];
        [self addChild:sceneSpriteBatchNode];
        [self scheduleUpdate];
        self.isTouchEnabled = YES;
        
        [[pete emitter] setPosition:pete.position];
    }
    return self; 
}

- (void)registerWithTouchDispatcher 
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 
                                              swallowsTouches:YES];
}

-(void)applyChargeForces:(ccTime)dt
{
    if (pete.characterState == kStateReady) {
        return;
    }
    float distance;
    float xDist, yDist;
    Box2DSprite *charge;
    for (charge in charges) {
        xDist = (charge.body->GetPosition().x - pete.body->GetPosition().x);
        yDist = (charge.body->GetPosition().y - pete.body->GetPosition().y);
        distance = pow(pow(xDist,2.0f) + pow(yDist,2.0f), .5f);
        b2Vec2 unit(xDist / distance,yDist / distance);
        unit *= CHARGE_FORCE_CONSTANT/pow(distance,2.0f);
  
        if (charge.gameObjectType == kPositivePoleType) {
            unit *= -1.0f;
        }
        
        if (pete.characterState == kStateReversed) {
            unit *= -1.0f;
        } else if (pete.characterState == kStateSpeed) {
            unit *= SPEED_POWERUP_CONSTANT;
        } else if (pete.characterState == kStateNeutral) {
            unit *= 0.0f;
        }
        
        b2Vec2 acceleration(unit.x/dt,unit.y/dt);
        pete.body->ApplyForce(pete.body->GetMass() * acceleration, pete.body->GetWorldCenter());
    }
}

-(void)updateSpritePositions:(b2World*)world
{
    for(b2Body *b = world->GetBodyList(); b != NULL; b = b->GetNext()) {
        if (b->GetUserData() != NULL && b->GetType() != b2_staticBody) {
            Box2DSprite *sprite = (Box2DSprite*)b->GetUserData();
            sprite.position = ccp(b->GetPosition().x * PTM_RATIO * iPadConstant + xMargin,
                                  b->GetPosition().y * PTM_RATIO * iPadConstant + yMargin);
            sprite.rotation = CC_RADIANS_TO_DEGREES(sprite.body->GetAngle());
        }
    }
}

-(void)checkForLevelComplete
{
    for (ShutDownSite *site in sites) {
        if (site.characterState == kStatePoweredUp) {
            return;
        }
    }
    [[GameManager sharedGameManager] runSceneWithID:kLevelCompleteScene];
}

-(void)update:(ccTime)dt 
{
    b2World *world = [physics world];
    
    [self applyChargeForces:dt];
    
    int32 velocityIterations = 5;
    int32 positionIterations = 5;
    world->Step(dt, velocityIterations, positionIterations);
    [self checkForLevelComplete];
    [self updateSpritePositions:world];
}

-(void)launchPete
{
    b2Vec2 launchVec = b2Vec2(LAUNCH_SPEED, 0.0f);
    [cannon changeState:kStateFired];
    pete.body->SetActive(true);
    pete.body->SetLinearVelocity(launchVec);
    self.gameState = kMovingPhaseState;
    [pete changeState:kStateFired];
}

-(void)resetPete
{
    //Reset Cannon
    [cannon changeState:kStateReady];
    
    //Reset Pete
    pete.body->SetActive(false);
    pete.position = cannon.position;
    pete.rotation = 0.0f;
    pete.body->SetTransform(b2Vec2((pete.position.x-xMargin)/PTM_RATIO/iPadConstant,
                                   (pete.position.y-yMargin)/PTM_RATIO/iPadConstant), 0.0f);
    
    pete.body->SetLinearVelocity(b2Vec2(0.0f,0.0f));
    
    [pete changeState:kStateReady];
    
    for (ShutDownSite *site in sites) {
        [site changeState:kStatePoweredUp];
    }
    
    for (PowerChip *chip in chips) {
        [chip changeState:kStateAvailable];
    }
    
    for (Box2DSprite *powerUp in powerUps) {
        [powerUp changeState:kStateAvailable];
    }
    
    [[GameManager sharedGameManager] resetScore];
    self.gameState = kSetupPhaseState;
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{
    b2World *world = [physics world];
    CGPoint touchLocation = [touch locationInView:[touch view]];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];

        if (touchLocation.y > screenSize.height - yMargin || touchLocation.y < yMargin || 
            touchLocation.x < xMargin || touchLocation.x > screenSize.width - xMargin) {
            selectedBody = NULL;
            return TRUE;
        } 
    }
    
    touchLocation = [[CCDirector sharedDirector]
                     convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    b2Vec2 locationWorld =
    b2Vec2((touchLocation.x-xMargin)/PTM_RATIO/iPadConstant, (touchLocation.y - yMargin)/PTM_RATIO/iPadConstant);
    
    b2AABB aabb;
    b2Vec2 delta = b2Vec2(10.0/PTM_RATIO/iPadConstant, 10.0/PTM_RATIO/iPadConstant);
    aabb.lowerBound = locationWorld - delta;
    aabb.upperBound = locationWorld + delta;
    [bodiesClicked removeAllObjects];
    SimpleQueryCallback callback(locationWorld,bodiesClicked);
    world->QueryAABB(&callback, aabb);

    GameObject *objectTouched;
    b2Body *objectTouchedBody;
    
    if (callback.fixtureFound) {
        if ([bodiesClicked count] > 1) {
            if (self.gameState == kSetupPhaseState) {
                for (NSValue *bodyPointer in bodiesClicked) {
                    b2Body *clickedBody = (b2Body*)[bodyPointer pointerValue];
                    if (GameObject *obj = (GameObject*)clickedBody->GetUserData()) {
                        if (obj.gameObjectType == kPositivePoleType || obj.gameObjectType == kNegativePoleType) {
                            objectTouched = obj;
                            touchOffset = b2Vec2(locationWorld - clickedBody->GetPosition());
                            objectTouchedBody = clickedBody;
                            break;
                        }
                    }
                }
            } else if (self.gameState == kMovingPhaseState) {
                for (NSValue *bodyPointer in bodiesClicked) {
                    b2Body *clickedBody = (b2Body*)[bodyPointer pointerValue];
                    if (GameObject *obj = (GameObject*)clickedBody->GetUserData()) {
                        if (obj.gameObjectType == kCannonType) {
                            objectTouched = obj;
                            touchOffset = b2Vec2(locationWorld - clickedBody->GetPosition());
                            objectTouchedBody = clickedBody;
                            break;
                        }
                    }
                }
            }
        } else {
             objectTouchedBody = callback.fixtureFound->GetBody();
            objectTouched = (GameObject*)objectTouchedBody->GetUserData();
            touchOffset = b2Vec2(locationWorld - objectTouchedBody->GetPosition());
        }

        if (objectTouched) {
            if ([objectTouched gameObjectType] == kCannonType) {
                selectedBody = NULL;
                switch (gameState) {
                    case kSetupPhaseState:
                        [self launchPete];
                        break;
                    case kMovingPhaseState:
                        [self resetPete];
                        
                    default:
                        break;
                }
            } else if ([objectTouched gameObjectType] == kPositivePoleType ||
                       [objectTouched gameObjectType] == kNegativePoleType) {
                switch (gameState) {
                    case kSetupPhaseState:
                        selectedBody = objectTouchedBody;
                        break;
                        
                    default:
                        break;
                }
            }    
        }
    }
    return TRUE;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInView:[touch view]];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];

        if (touchLocation.y > screenSize.height - yMargin || touchLocation.y < yMargin || 
            touchLocation.x < xMargin || touchLocation.x > screenSize.width - xMargin) {
            selectedBody = NULL;
            return;
        }
    }
    touchLocation =
    [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    b2Vec2 locationWorld = b2Vec2((touchLocation.x-xMargin)/PTM_RATIO/iPadConstant,
                                  (touchLocation.y-yMargin)/PTM_RATIO/iPadConstant);
    locationWorld -= touchOffset;
    if (selectedBody) {
        //selectedBody->SetAwake(true);
        selectedBody->SetTransform(locationWorld, 0.0f);
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event 
{
    selectedBody = NULL;
}

@end
