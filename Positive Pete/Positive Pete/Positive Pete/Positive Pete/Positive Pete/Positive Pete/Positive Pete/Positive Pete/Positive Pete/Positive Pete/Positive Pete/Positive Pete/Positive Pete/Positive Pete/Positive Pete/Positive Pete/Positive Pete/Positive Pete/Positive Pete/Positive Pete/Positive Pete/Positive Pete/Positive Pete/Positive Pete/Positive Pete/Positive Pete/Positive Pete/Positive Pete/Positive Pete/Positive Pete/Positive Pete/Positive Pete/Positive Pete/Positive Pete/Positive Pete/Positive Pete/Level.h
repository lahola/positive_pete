//
//  Level.h
//  Positive Pete
//
//  Created by Louis Ahola on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject {
    NSString *levelName;
    NSString *fileName;
    unsigned int oneStarScore;
    unsigned int twoStarScore;
    unsigned int threeStarScore;
}
@property (nonatomic, retain) NSString *levelName;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, assign) unsigned int oneStarScore;
@property (nonatomic, assign) unsigned int twoStarScore;
@property (nonatomic, assign) unsigned int threeStarScore;
@end
