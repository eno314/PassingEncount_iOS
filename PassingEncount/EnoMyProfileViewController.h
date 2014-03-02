//
//  EnoMyProfileViewController.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/01.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnoUIAsyncImageView.h"
#import "EnoEditIconViewController.h"
#import "EnoProfileInfo.h"
#import "EnoNSUserDefaults.h"

@interface EnoMyProfileViewController : UIViewController<
    UITextFieldDelegate,
    UIGestureRecognizerDelegate, // 画面外のタップを取るために使う
    EnoEditIconViewControllerDelegate
>

- (id)initForOthers:(EnoProfileInfo *)profile;

@end
