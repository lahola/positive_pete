//
//  ShutDownSite.h
//  Positive Pete
//
//  Created by Louis Ahola on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Box2DSprite.h"

@interface ShutDownSite : Box2DSprite {
    CCAnimation *poweredUpAnim;
    CCAnimation *poweredDownAnim;
}
-(void)changeState:(CharacterState)newState;
@property(nonatomic, retain) CCAnimation *poweredUpAnim;
@property(nonatomic, retain) CCAnimation *poweredDownAnim;
@end
