//
//  InGameGUILayer.h
//  Positive Pete
//
//  Created by Louis Ahola on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLayer.h"

@interface InGameGUILayer : CCLayer {
    CCLabelTTF *scoreLabel;
    CCMenu *pauseButtonMenu;
}
@property (nonatomic, retain) CCLabelTTF *scoreLabel;
@property (nonatomic, readonly) CCMenu *pauseButtonMenu;
@end
