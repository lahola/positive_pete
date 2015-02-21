//
//  CGame.h
//  Sabe
//
//  Created by Louis Ahola on 1/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CLevel.h"
#import "CIntro.h"

@interface CGame : NSObject
{
    CLevel* _currentLevel;
}
+(CGame*)theGame;
-(void)start;
-(CLevel*)currentLevel;
-(void)setCurrentLevel:(CLevel*)level;
@end
