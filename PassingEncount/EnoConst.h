//
//  EnoConst.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/02.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnoConst : NSObject

/** プロフィールのプリファレンスキー */
+ (NSString *)NSUserDefaultsKeyProfile;

/** すれ違い通信用のサービスUUID */
+ (NSString *)serviceUUID;

/** すれ違い通信サービスのプロフィール特性のUUID*/
+ (NSString *)characteristicUUID;

@end
