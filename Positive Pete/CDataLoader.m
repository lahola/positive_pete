//
//  CDataLoader.m
//  Sabe
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CDataLoader.h"
#import "CPListLoader.h"
#import "CObjectManager.h"
#import "GameConfig.h"

@implementation CDataLoader
-(void)loadCharacterData:(NSString *)fileName
{
    
}

static CDataLoader* _dataLoader = nil;
-(void)dealloc
{
    _dataLoader = nil;
    [super dealloc];
}
+(CDataLoader*)loader
{
    @synchronized([CDataLoader class])
    {
        if (_dataLoader == nil)
            _dataLoader = [[CDataLoader alloc] init];
        return _dataLoader;
    }
    return nil;
}
@end
