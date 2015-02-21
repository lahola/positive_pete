//
//  CPListLoader.h
//  Sabe
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAnimation.h"

@interface CPListLoader : NSObject
+(NSDictionary*)readPList:(NSString*)fileName;
+(NSMutableArray*)loadAnimationsFromPList:(NSDictionary*)pList;
@end
