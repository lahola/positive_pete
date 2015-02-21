//
//  CGame.m
//  Sabe
//
//  Created by Louis Ahola on 1/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CGame.h"
#import "CDataLoader.h"

@implementation CGame
-(void)dealloc
{
    [_currentLevel release];
    [super dealloc];
}

-(CLevel*)currentLevel
{
    return _currentLevel;
}

-(void)setCurrentLevel:(CLevel*)level
{
    [level retain];
    [_currentLevel release];
    _currentLevel = level;
    
    CCScene* scene = [level currentScene];
    NSAssert(scene, @"NULL current scene for a level!");

    CCDirector* director = [CCDirector sharedDirector];
    if (![director runningScene])
    {
        [director runWithScene:scene];
    }
    else
    {
        [director replaceScene:scene];
    }
}

-(void)start
{
    [[CDataLoader loader] loadPermanentData:@"Permanent.plist"];
    [self setCurrentLevel:[[CIntro alloc] init]];
}

static CGame* _theGame = nil;
+(CGame*)theGame
{
    @synchronized([CGame class])
    {
        if(!_theGame)
            _theGame = [[self alloc] init];
        return _theGame;
    }
    return nil;
}

-(id)init 
{
    if(self = [super init]) 
    {
        CCLOG(@"Game init");
    }
    NSAssert(self, (@"Could not initialize The Game!"));
    return self;
}

@end
