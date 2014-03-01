//
//  EnoTabBarController.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/01.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoTabBarController.h"

@interface EnoTabBarController ()

@end

@implementation EnoTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if ( self ) {
        
        UIViewController       *passingVC   = [[EnoPassingViewController alloc] init];
        UINavigationController *passingNavi = [[UINavigationController alloc]
                                               initWithRootViewController:passingVC];
        
        UIViewController       *myProfileVC   = [[EnoMyProfileViewController alloc] init];
        UINavigationController *myProfileNavi = [[UINavigationController alloc]
                                                 initWithRootViewController:myProfileVC];
        
        self.viewControllers = @[ passingNavi, myProfileNavi ];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
