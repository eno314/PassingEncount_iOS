//
//  EnoLocalNotificationManager.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/13.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnoLocalNotificationManager : NSObject

@property (nonatomic, strong) NSData   *fireDate;    // 通知する日時
@property (nonatomic, strong) NSString *message;     // 通知に表示するメッセージ
@property (nonatomic, strong) NSString *buttonText;  // ボタンのテキスト
@property (nonatomic)         NSInteger badgeNumber; // バッチで表示する数

- (void)setNotification;

/** すぐに通知するノーティッフィケーションのセット */
+ (void)setNotificationNowWithMessage:(NSString *)message
                           ButtonText:(NSString *)buttonText
                          BadgeNumber:(NSInteger)badgeNumber;

@end
