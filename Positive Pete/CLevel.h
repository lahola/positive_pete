//
//  CLevel.h
//  Sabe
//
//  Created by Louis Ahola on 8/25/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CLevel : NSObject 
{
    CCScene* _currentScene;
}
@property(nonatomic, retain) CCScene* currentScene;
@end
