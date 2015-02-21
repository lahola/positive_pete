//
//  LevelSelectLayer.h
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "LevelSelectMenu.h"

@interface LevelSelectLayer : CCLayer {
    LevelSelectMenu *buttonMenu;
    LevelSelectMenu *levelNameMenu;
    LevelSelectMenu *scoreMenu;
    CGPoint beginningTouchLocation;
    CGPoint lastTouchLocation;
    bool menuTouch;
    int minY;
    int maxY;
}
@property (nonatomic, assign) CGPoint beginningTouchLocation;
@property (nonatomic, assign) CGPoint lastTouchLocation;
@property (nonatomic, assign) bool menuTouch;
@end
