//
//  EnoProfileInfo.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/02.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoProfileInfo.h"

@implementation EnoProfileInfo

- (id)init
{
    self = [super init];
    
    if ( self ) {
        
        self.name           = nil;
        self.iconUrlsitring = nil;
        self.message        = nil;
    }
    
    return self;
}

@end
