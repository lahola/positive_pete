//
//  OptionsButtonLayer.h
//  Positive Pete
//
//  Created by Louis Ahola on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface OptionsButtonLayer : CCLayer {
    CCMenuItemImage *musicButton;
    CCMenuItemImage *sfxButton;
    NSString *musicOnFilename;
    NSString *musicOffFilename;
    NSString *sfxOnFilename;
    NSString *sfxOffFilename;
    CCMenu *optionsMenu;
}
@property (nonatomic, retain) CCMenuItemImage *musicButton;
@property (nonatomic, retain) CCMenuItemImage *sfxButton;
@end
