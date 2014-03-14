//
//  EnoNSUserDefaultsProfile.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/14.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnoProfileInfo.h"

@interface EnoNSUserDefaultsProfile : NSObject

/** プロフィールのセッター */
+ (void)setProfileJsonObj:(NSDictionary *)jsonObj;

/** プロフィールのゲッター */
+ (NSDictionary *)getProfileJsonObj;

/** プロフィールのモデルを渡したセッター */
+ (void)setProfileJsonObjWithModel:(EnoProfileInfo *)profile;

/**  プロフィールモデルのゲッター */
+ (EnoProfileInfo *)getProfileModel;

@end
