//
//  EnoPassingInfo.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/02.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnoPassingInfo : NSObject

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconUrlstring;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDate   *passinged;

@end
