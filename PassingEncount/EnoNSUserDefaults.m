//
//  EnoNSUserDefaults.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/02.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoNSUserDefaults.h"

#define KEY_PROFILE  @"NSUserDefaultsKeyProfile"
#define ICON_DEFAULT @"https://abs.twimg.com/sticky/default_profile_images/default_profile_2_bigger.png"

@implementation EnoNSUserDefaults

+ (void)setProfileJsonObj:(NSDictionary *)jsonObj
{
    [[NSUserDefaults standardUserDefaults] setObject:jsonObj forKey:KEY_PROFILE];
}

+ (NSDictionary *)getProfileJsonObj
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_PROFILE];
}

+ (void)setProfileJsonObjWithModel:(EnoProfileInfo *)profile
{
    NSDictionary *jsonObj = @{ @"name"         : profile.name,
                               @"iconUrlString": profile.iconUrlsitring,
                               @"message"      : profile.message };
    
    [self setProfileJsonObj:jsonObj];
}

+ (EnoProfileInfo *)getProfileModel
{
    EnoProfileInfo *profile = [[EnoProfileInfo alloc] init];
    
    NSDictionary *jsonObj = [self getProfileJsonObj];
    
    if ( jsonObj ) {
        // プリファレンスからjsonを取ってくる
        profile.name           = [jsonObj objectForKey:@"name"];
        profile.iconUrlsitring = [jsonObj objectForKey:@"iconUrlString"];
        profile.message        = [jsonObj objectForKey:@"message"];
    }
    else {
        
        profile.name           = @"ほげほげ";
        profile.iconUrlsitring = ICON_DEFAULT;
        profile.message        = @"ふがふが";
    }
    
    return profile;
}

@end
