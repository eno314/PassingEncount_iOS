//
//  EnoNSUserDefaults.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/02.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnoProfileInfo.h"
#import "EnoPassingInfo.h"

@interface EnoNSUserDefaults : NSObject

/** プロフィールのセッター */
+ (void)setProfileJsonObj:(NSDictionary *)jsonObj;

/** プロフィールのゲッター */
+ (NSDictionary *)getProfileJsonObj;

/** プロフィールのモデルを渡したセッター */
+ (void)setProfileJsonObjWithModel:(EnoProfileInfo *)profile;

/**  プロフィールモデルのゲッター */
+ (EnoProfileInfo *)getProfileModel;

/** すれ違い一覧のセッター */
+ (void)setPassings:(NSArray *)passings;

/** すれ違いを追加 */
+ (void)addPassings:(EnoPassingInfo *)passing;

/** すれ違い一覧のゲッター */
+ (NSArray *)getPassings;

/** jsondataからセットする */
+ (void)addPassingsWithJsondata:(NSData *)jsondata;



@end
