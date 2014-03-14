//
//  EnoNSUserDefaultsPassing.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/14.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoNSUserDefaultsPassing.h"

#define KEY_PASSINGS @"NSUserDefaultsKeyPassings"

@implementation EnoNSUserDefaultsPassing

/**
 * すれ違い一覧のセッター
 */
+ (void)setPassings:(NSArray *)passings
{
    [[NSUserDefaults standardUserDefaults] setObject:passings forKey:KEY_PASSINGS];
}

/**
 * すれ違い一覧のゲッター
 */
+ (NSArray *)getPassings
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_PASSINGS];
}

/**
 * すれ違い一覧へ追加
 */
+ (void)addPassingWithId:(NSInteger)userid
{
    NSDictionary *jsonObj = @{@"id"       : [NSNumber numberWithInt:userid],
                              @"passinged": [NSDate date]};
    
    [self p_addPassings:jsonObj];
}

/**
 * すれ違い一覧に追加する
 */
+ (void)p_addPassings:(NSDictionary *)jsonObj
{
    NSArray *passings = [self getPassings];
    
    if ( passings ) {
        
        NSMutableArray *newPassings = [passings mutableCopy];
        [newPassings insertObject:jsonObj atIndex:0];
        [self setPassings:[newPassings copy]];
    }
    else {
        
        [self setPassings:@[jsonObj]];
    }
}

@end
