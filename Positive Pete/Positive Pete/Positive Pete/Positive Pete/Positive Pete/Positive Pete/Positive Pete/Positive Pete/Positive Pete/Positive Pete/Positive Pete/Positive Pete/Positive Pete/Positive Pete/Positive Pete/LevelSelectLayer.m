//
//  LevelSelectLayer.m
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectLayer.h"
#import "GameManager.h"
#import "Constants.h"
#import "Level.h"
#import "cocos2d.h"

@implementation LevelSelectLayer
@synthesize beginningTouchLocation;
@synthesize lastTouchLocation;
@synthesize menuTouch;
-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
-(void)playLevel:(CCMenuItem *)sender
{
    [[GameManager sharedGameManager] setCurrentLevel:[sender tag]];
    [[GameManager sharedGameManager] runSceneWithID:kGameScene];
}
-(id)init
{
    if (self = [super init]) {
        int menuPadding;
        int imageSize;
        int menuItemSize;
        
        NSString *menuButtonOffFilename;
        NSString *menuButtonOnFilename;
        NSString *starFilename;
        NSString *starEmptyFilename;
        
        int fontSize;
        int iPadOffset;
        int iPadScale = 1;
        int iPadXMargin;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            menuPadding = 10;
            iPadScale = 2;
            menuItemSize = 64;
            imageSize = 74;
            menuButtonOffFilename = [NSString stringWithString:@"menuButtonOff-hd.png"];
            menuButtonOnFilename = [NSString stringWithString:@"menuButtonOn-hd.png"];
            starFilename = [NSString stringWithString:@"star-hd.png"];
            starEmptyFilename = [NSString stringWithString:@"starEmpty-hd.png"];
            fontSize = 32;
            iPadOffset = 64;
            iPadXMargin = 32;
        } else {
            menuPadding = 5;
            menuItemSize = 32;
            imageSize = 37;
            menuButtonOffFilename = [NSString stringWithString:@"menuButtonOff.png"];
            menuButtonOnFilename = [NSString stringWithString:@"menuButtonOn.png"];
            starFilename = [NSString stringWithString:@"star.png"];
            starEmptyFilename = [NSString stringWithString:@"starEmpty.png"];
            fontSize = 16;
            iPadOffset = 0;
            iPadXMargin = 0;
        }
        
        menuTouch = YES;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        unsigned int numLevels = [[GameManager sharedGameManager] numLevels];
        
        maxY = (((int)numLevels * menuItemSize) + (int)(((float)numLevels - 1.0f)/2 * menuPadding) - screenSize.height/2) + iPadOffset;
        minY = -(((int)numLevels * menuItemSize) + (int)(((float)numLevels - 1.0f)/2 * menuPadding) - screenSize.height/2) - iPadOffset;
        
        if (maxY < minY) {
            maxY = minY;
        }
        buttonMenu = [LevelSelectMenu menuWithItems:nil];
        levelNameMenu = [LevelSelectMenu menuWithItems:nil];
        scoreMenu = [LevelSelectMenu menuWithItems:nil];

        CCMenu *oneStarMenu = [LevelSelectMenu menuWithItems:nil];
        CCMenu *twoStarMenu = [LevelSelectMenu menuWithItems:nil];
        CCMenu *threeStarMenu = [LevelSelectMenu menuWithItems:nil];
        
        Level *level = nil;
        unsigned int levelScore = 0;
        bool levelAvailable = YES;
        NSString *levelNameString;
        NSString *scoreString;
        CCLabelTTF *levelNameLabel;
        CCLabelTTF *scoreLabel;
        CCMenuItemLabel *scoreItem;
        CCMenuItemLabel *levelNameItem;
        CCMenuItemImage *button;
        CCMenuItemImage *star;
        CCSprite *starSprite;
       for (int i = 1; i <= numLevels; i++) {
           
           button = [CCMenuItemImage itemFromNormalImage:menuButtonOffFilename
                                           selectedImage:menuButtonOnFilename
                                           disabledImage:nil
                                                  target:self
                                                selector:@selector(playLevel:)];
           [buttonMenu addChild:button];
           [button setTag:i];
           
           if (levelAvailable) {
               level = [[GameManager sharedGameManager] loadLevelFromPlist:i];
               levelScore = [[GameManager sharedGameManager] readScore:i];
               levelNameString = level.levelName;
               scoreString = [NSString stringWithFormat:@"%d",levelScore];
               
           } else {
               levelNameString = [NSString stringWithString:@" "];
               scoreString = [NSString stringWithString:@"?"];
               levelScore = 0;
               level = nil;
               [button setIsEnabled:NO];
           }
           
           levelNameLabel = [CCLabelTTF labelWithString:levelNameString fontName:@"Noteworthy-Bold" fontSize:fontSize];
           levelNameItem = [CCMenuItemLabel itemWithLabel:levelNameLabel];
           [levelNameItem setIsRelativeAnchorPoint:YES];
           [levelNameItem setAnchorPoint:ccp(0,.5)];
           [levelNameItem setIsEnabled:NO];
           [levelNameItem setDisabledColor:ccWHITE];
           [levelNameMenu addChild:levelNameItem];
           
            
           scoreLabel = [CCLabelTTF labelWithString:scoreString fontName:@"Noteworthy-Bold" fontSize:fontSize];
           scoreItem = [CCMenuItemLabel itemWithLabel:scoreLabel];
           [scoreItem setAnchorPoint:ccp(1,.5)];
           [scoreItem setIsEnabled:NO];
           [scoreItem setDisabledColor:ccWHITE];
           [scoreMenu addChild:scoreItem];
   
           if (levelAvailable && levelScore >= level.threeStarScore) {
               star = [CCMenuItemImage itemFromNormalImage:starFilename
                                             selectedImage:starFilename
                                             disabledImage:nil
                                                    target:self
                                                  selector:@selector(playLevel:)];
               starSprite = [CCSprite spriteWithFile:starFilename];
               
           } else {
               star = [CCMenuItemImage itemFromNormalImage:starEmptyFilename
                                             selectedImage:starEmptyFilename
                                             disabledImage:nil
                                                    target:self
                                                  selector:@selector(playLevel:)];
               starSprite = [CCSprite spriteWithFile:starEmptyFilename];
           }
           
           [star setDisabledImage:starSprite];
           [star setAnchorPoint:ccp(1,.5)];
           [star setIsEnabled:NO];
           [threeStarMenu addChild:star];
           
           if (levelAvailable && levelScore >= level.twoStarScore) {
               star = [CCMenuItemImage itemFromNormalImage:starFilename
                                             selectedImage:starFilename
                                             disabledImage:nil
                                                    target:self
                                                  selector:@selector(playLevel:)];
               starSprite = [CCSprite spriteWithFile:starFilename];
           } else {
               star = [CCMenuItemImage itemFromNormalImage:starEmptyFilename
                                             selectedImage:starEmptyFilename
                                             disabledImage:nil
                                                    target:self
                                                  selector:@selector(playLevel:)];
               starSprite = [CCSprite spriteWithFile:starEmptyFilename];
           }
           
           [star setDisabledImage:starSprite];
           [star setAnchorPoint:ccp(1,.5)];
           [star setIsEnabled:NO];
           [twoStarMenu addChild:star];
           
           if (levelAvailable && levelScore > 0) {
               star = [CCMenuItemImage itemFromNormalImage:starFilename
                                             selectedImage:starFilename
                                             disabledImage:nil
                                                    target:self
                                                  selector:@selector(playLevel:)];
               starSprite = [CCSprite spriteWithFile:starFilename];
               
           } else {
               star = [CCMenuItemImage itemFromNormalImage:starEmptyFilename
                                             selectedImage:starEmptyFilename
                                             disabledImage:nil
                                                    target:self
                                                  selector:@selector(playLevel:)];
               starSprite = [CCSprite spriteWithFile:starEmptyFilename];
           }
           
           [star setDisabledImage:starSprite];
           [star setAnchorPoint:ccp(1,.5)];
           [star setIsEnabled:NO];
           [oneStarMenu addChild:star];
           
           if (levelScore <= 0) {
               levelAvailable = false;
           }
        }
        
        [levelNameMenu alignItemsVerticallyWithPadding:menuPadding + imageSize];
        [levelNameMenu setAnchorPoint:ccp(.5,.5)];
        [levelNameMenu setPosition:ccp(iPadXMargin + (screenSize.width-(iPadXMargin*2))/20,
                                         screenSize.height/2)];
        [self addChild:levelNameMenu];

        
        [scoreMenu alignItemsVerticallyWithPadding:menuPadding + imageSize];
        [scoreMenu setAnchorPoint:ccp(.5,.5)];
        [scoreMenu setPosition:ccp(iPadXMargin + (screenSize.width-(iPadXMargin*2))*.95,
                                   screenSize.height/2)];
        [self addChild:scoreMenu];
        
        [buttonMenu alignItemsVerticallyWithPadding:menuPadding];
        [buttonMenu setAnchorPoint:ccp(.5,.5)];
        [buttonMenu setPosition:ccp(screenSize.width/2,
                                    screenSize.height/2)];
        
        [self addChild:buttonMenu];
        
        [oneStarMenu alignItemsVerticallyWithPadding:menuPadding];
        [oneStarMenu setAnchorPoint:ccp(.5,.5)];
        [oneStarMenu setPosition:ccp(iPadXMargin + (screenSize.width-(iPadXMargin*2))*.9,
                                    screenSize.height/2)];
        
        [self addChild:oneStarMenu];
        
        [twoStarMenu alignItemsVerticallyWithPadding:menuPadding];
        [twoStarMenu setAnchorPoint:ccp(.5,.5)];
        [twoStarMenu setPosition:ccp(iPadXMargin + (screenSize.width-(iPadXMargin*2))*.8,
                                    screenSize.height/2)];
        
        [self addChild:twoStarMenu];
        
        [threeStarMenu alignItemsVerticallyWithPadding:menuPadding];
        [threeStarMenu setAnchorPoint:ccp(.5,.5)];
        [threeStarMenu setPosition:ccp(iPadXMargin + (screenSize.width-(iPadXMargin*2))*.7,
                                    screenSize.height/2)];
        
        [self addChild:threeStarMenu];
        
        [self setPosition:ccp(self.position.x, minY)];
        
        [self registerWithTouchDispatcher];
    }
    return self;
}

- (void)registerWithTouchDispatcher 
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0
                                              swallowsTouches:YES];
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector]
                     convertToGL:touchLocation];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (touchLocation.y > 704 || touchLocation.y < 64) {
            [buttonMenu resetSelection];
            [buttonMenu setIsTouchEnabled:NO];
            self.menuTouch = NO;
            return TRUE;
        }
        
    }
    [self setBeginningTouchLocation:touchLocation];
    return TRUE;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation =
    [[CCDirector sharedDirector] convertToGL:touchLocation];
        
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (touchLocation.y > 704 || touchLocation.y < 64) {
            [buttonMenu resetSelection];
            [buttonMenu setIsTouchEnabled:NO];
            self.menuTouch = NO;
            return;
        }
    }
    
    if ([self menuTouch]) {

        float distance = sqrtf(powf(touchLocation.x - self.beginningTouchLocation.x,2.0f) + powf(touchLocation.y - self.beginningTouchLocation.y,2.0f));
        
        if (distance > 4) {
            [buttonMenu resetSelection];
            [buttonMenu setIsTouchEnabled:NO];
            self.menuTouch = NO;
            lastTouchLocation = touchLocation;
        }   
    } else {
        if (abs(touchLocation.y - self.lastTouchLocation.y) > 1) {
            [self setPosition:ccp(self.position.x, touchLocation.y - self.lastTouchLocation.y + self.position.y)];
            self.lastTouchLocation = touchLocation;
        }
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event 
{
    self.menuTouch = YES;
    [buttonMenu setIsTouchEnabled:YES];
    if (self.position.y < minY) {
        self.position = ccp(self.position.x, minY);
    } else if (self.position.y > maxY) {
        self.position = ccp(self.position.x, maxY);
    }
}

@end
