//
//  EnoPassingViewController.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/01.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoPassingViewController.h"

@interface EnoPassingViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation EnoPassingViewController

- (id)init
{
    self = [super initWithNibName:@"EnoPassingViewController" bundle:nil];
    
    if ( self ) {
        
        // hogehoge
        self.title = @"すれ違い";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableview
     registerNib:[UINib nibWithNibName:@"EnoPassingTableViewCell" bundle:nil]
     forCellReuseIdentifier:@"Cell"];
    
    self.tableview.dataSource = self;
    self.tableview.delegate   = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark - UITableViewDataSource

/**
 * セクションに含まれるセル数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == 0 ) {
        
        return 1;
    }
    else {
        
        return 5;
    }
}

/**
 * セルの内容を返す
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EnoPassingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if ( indexPath.section == 0 ) {
        
        EnoProfileInfo *profile     = [EnoNSUserDefaults getProfileModel];
        cell.nameLabel.text         = profile.name;
        cell.messageLabel.text      = profile.message;
        cell.timeLabel.text         = nil;
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:profile.iconUrlsitring]];
        cell.iconImageView.image = [UIImage imageWithData:data];
    }
    else {
        
    }
    
    return cell;
}

/**
 * テーブルのセクション数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

/**
 * ヘッダー
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ( section == 0 ) {
        
        return @"自分のプロフィール";
    }
    else {
        
        return @"すれ違ったひとたち";
    }
}

/**
 * セルの高さ
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

# pragma mark - UITableViewDelegate



@end
