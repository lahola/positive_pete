//
//  LevelSelectScene.h
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCScene.h"
#import "LevelSelectLayer.h"
#import "LevelSelectBackgroundLayer.h"

@interface LevelSelectScene : CCScene {
    LevelSelectLayer *levelSelectLayer;
    LevelSelectBackgroundLayer *levelSelectBackgroundLayer;
}
@end
