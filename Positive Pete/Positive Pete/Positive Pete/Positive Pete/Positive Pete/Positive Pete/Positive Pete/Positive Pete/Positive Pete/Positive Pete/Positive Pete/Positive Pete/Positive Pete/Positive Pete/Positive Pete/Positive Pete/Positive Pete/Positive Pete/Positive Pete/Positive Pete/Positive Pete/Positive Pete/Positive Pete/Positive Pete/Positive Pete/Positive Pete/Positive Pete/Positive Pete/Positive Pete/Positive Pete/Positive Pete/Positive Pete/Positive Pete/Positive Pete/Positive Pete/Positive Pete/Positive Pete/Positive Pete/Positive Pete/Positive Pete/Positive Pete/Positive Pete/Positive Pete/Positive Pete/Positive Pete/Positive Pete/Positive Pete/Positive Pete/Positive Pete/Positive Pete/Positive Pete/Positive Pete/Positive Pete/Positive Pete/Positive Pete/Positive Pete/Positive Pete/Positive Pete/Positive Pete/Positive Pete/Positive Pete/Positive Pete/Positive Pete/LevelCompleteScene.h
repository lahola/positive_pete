//
//  LevelCompleteScene.h
//  Positive Pete
//
//  Created by Louis Ahola on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCScene.h"
#import "LevelCompleteLayer.h"

@interface LevelCompleteScene : CCScene {
    LevelCompleteLayer *levelCompleteLayer;
}
@property (nonatomic,readonly) LevelCompleteLayer *levelCompleteLayer;
@end
