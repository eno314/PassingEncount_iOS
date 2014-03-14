//
//  EnoNSUserDefaultsProfile.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/14.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoNSUserDefaultsProfile.h"

#define KEY_PROFILE  @"NSUserDefaultsKeyProfile"

#define ICON_DEFAULT @"https://abs.twimg.com/sticky/default_profile_images/default_profile_2_bigger.png"

@implementation EnoNSUserDefaultsProfile

/**
 * プロフィールのセッター
 */
+ (void)setProfileJsonObj:(NSDictionary *)jsonObj
{
    [[NSUserDefaults standardUserDefaults] setObject:jsonObj forKey:KEY_PROFILE];
}

/**
 * プロフィールのゲッター（jsonObjectで返す）
 */
+ (NSDictionary *)getProfileJsonObj
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_PROFILE];
}

/**
 * プロフィールのモデルを渡したセッター
 */
+ (void)setProfileJsonObjWithModel:(EnoProfileInfo *)profile
{
    NSDictionary *jsonObj = @{ @"name"         : profile.name,
                               @"iconUrlString": profile.iconUrlstring,
                               @"message"      : profile.message };
    
    [self setProfileJsonObj:jsonObj];
}

/**
 * プロフィールをモデルで取得する
 */
+ (EnoProfileInfo *)getProfileModel
{
    EnoProfileInfo *profile = [[EnoProfileInfo alloc] init];
    
    NSDictionary *jsonObj = [self getProfileJsonObj];
    
    if ( jsonObj ) {
        // プリファレンスからjsonを取ってくる
        profile.name           = [jsonObj objectForKey:@"name"];
        profile.iconUrlstring = [jsonObj objectForKey:@"iconUrlString"];
        profile.message        = [jsonObj objectForKey:@"message"];
    }
    else {
        
        profile.name           = @"ほげほげ";
        profile.iconUrlstring = ICON_DEFAULT;
        profile.message        = @"ふがふが";
    }
    
    return profile;
}

@end
