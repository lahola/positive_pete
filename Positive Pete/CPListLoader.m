//
//  CPListLoader.m
//  Sabe
//
//  Created by Louis Ahola on 8/29/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CPListLoader.h"
#import "cocos2d.h"

@implementation CPListLoader

+(NSDictionary*)readPList:(NSString*)fileName
{
    NSString* rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                         NSUserDomainMask, YES) objectAtIndex:0];
    NSString* pListPath = [rootPath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:pListPath])
    {
        pListPath = [[NSBundle mainBundle] pathForResource:@"Permanent" ofType:@"plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:pListPath])
        {
            NSAssert(false, @"Could not find the given plist file!");
        }
    }

    NSDictionary* plistDictionary = [NSDictionary dictionaryWithContentsOfFile:pListPath];

    if (plistDictionary == nil)
    {
        NSAssert(false, @"Could not load the plist dictionary!"); 
    }
    
    return plistDictionary;
}

+(NSMutableArray*)loadAnimationsFromPList:(NSDictionary*)pList
{
    NSMutableArray* animations = [[[NSMutableArray alloc] init] autorelease];
    
    NSDictionary* element;
    for (NSString* key in [pList allKeys])
    {
        element = [pList objectForKey:key];
        if (element == nil)
        {   
            // We only want to load animations so
            // if this is not a dictionary forget it
            continue;
        }
        
        CAnimation* animation = [[CAnimation alloc] init];
        [animation setName:key];
        
        float delay = [[element objectForKey:@"delay"] floatValue];
        [animation setDelay:delay];
        
        NSMutableArray* frames = [[NSMutableArray alloc] init];
        for (NSString *frameNumber in [[element objectForKey:@"frames"] componentsSeparatedByString:@","])
        {
            [frames addObject:frameNumber];
        }
        [animation setFrames:frames];
        [frames release];
        
        [animations addObject:animation];
        [animation release];
    }
    
    return animations;
}
@end
