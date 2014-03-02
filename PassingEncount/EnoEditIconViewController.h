//
//  EnoEditIconViewController.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/02.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnoUIAsyncImageView.h"

@protocol EnoEditIconViewControllerDelegate <NSObject>

-(void)didPressCloseButton;
-(void)didPressDecisionButtonWithUrlstring:(NSString *)urlstring;

@end

@interface EnoEditIconViewController : UIViewController<
    UITextFieldDelegate
>

@property (nonatomic, weak) id<EnoEditIconViewControllerDelegate> delegate;

@end
