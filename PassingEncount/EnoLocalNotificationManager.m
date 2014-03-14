//
//  EnoLocalNotificationManager.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/13.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoLocalNotificationManager.h"

@implementation EnoLocalNotificationManager

- (id)init
{
    self = [super init];
    
    if ( self ) {
        // 初期化
        
    }
    
    return self;
}

- (void)setNotification
{
    // 設定されているローカル通知をすべてキャンセルする
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.alertBody                  = self.message;
    localNotification.applicationIconBadgeNumber = self.badgeNumber;
    localNotification.alertAction                = self.buttonText;
    //localNotification.fireDate                   = self.fireDate;
    localNotification.repeatInterval             = NSCalendarUnitDay; // 繰り返し間隔
    
    // 設定したローカル通知の内容を登録する
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

+ (void)setNotificationNowWithMessage:(NSString *)message
                           ButtonText:(NSString *)buttonText
                          BadgeNumber:(NSInteger)badgeNumber
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.alertBody                  = message;
    localNotification.applicationIconBadgeNumber = badgeNumber;
    localNotification.alertAction                = buttonText;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}

@end
