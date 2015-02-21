//
//  CDataLoader.h
//  Sabe
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CObject.h"
#import "CLevel.h"
#import "CCharacter.h"

@interface CDataLoader : NSObject
+(CDataLoader*)loader;
-(void)loadCharacterData:(NSString*)fileName;
-(void)loadMapData:(NSString*)fileName;
@end
