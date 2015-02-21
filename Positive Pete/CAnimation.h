//
//  CAnimation.h
//  Sabe
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CObject.h"

@interface CAnimation : CObject
{
    float _delay;
    NSArray* _frames;
}
@property(nonatomic, assign) float delay;
@property(nonatomic, retain) NSArray* frames;
@end
