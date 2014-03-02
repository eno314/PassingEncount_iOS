//
//  EnoNSUserDefaults.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/02.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoNSUserDefaults.h"

#define KEY_PROFILE  @"NSUserDefaultsKeyProfile"
#define KEY_PASSINGS @"NSUserDefaultsKeyPassings"


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
                               @"iconUrlString": profile.iconUrlstring,
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

+ (void)setPassings:(NSArray *)passings
{
    [[NSUserDefaults standardUserDefaults] setObject:passings forKey:KEY_PASSINGS];
}

+ (void)addPassings:(NSDictionary *)jsonObj
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

+ (NSArray *)getPassings
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_PASSINGS];
}

+ (void)addPassingsWithJsondata:(NSData *)jsondata
{
    NSMutableDictionary *jsonObj = [NSJSONSerialization
                                    JSONObjectWithData:jsondata
                                    options:NSJSONReadingMutableContainers
                                    error:nil];
    
    if ( jsonObj ) {
        /*
        EnoPassingInfo *passing = [[EnoPassingInfo alloc] init];
        
        passing.userid        = [jsonObj objectForKey:@"userid"];
        passing.name          = [jsonObj objectForKey:@"name"];
        passing.iconUrlstring = [jsonObj objectForKey:@"iconUrlstring"];
        passing.message       = [jsonObj objectForKey:@"message"];
        
        // すれ違った時間は現在時間を突っ込む
        passing.passinged     = [NSDate date];
         */
        [jsonObj setObject:[NSDate date] forKey:@"passinged"];
        
        [self addPassings:[jsonObj copy]];
    }
}

@end
