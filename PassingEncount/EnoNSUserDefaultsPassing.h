//
//  EnoNSUserDefaultsPassing.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/14.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnoNSUserDefaultsPassing : NSObject

/** すれ違い一覧のセッター */
+ (void)setPassings:(NSArray *)passings;

/** すれ違い一覧のゲッター */
+ (NSArray *)getPassings;

/** すれ違った人を追加する */
+ (void)addPassingWithId:(NSInteger)userid;

@end
