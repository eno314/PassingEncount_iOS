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

@property (nonatomic, strong) NSArray *passings;

@end

@implementation EnoPassingViewController

- (id)init
{
    self = [super initWithNibName:@"EnoPassingViewController" bundle:nil];
    
    if ( self ) {
        
        // hogehoge
        self.title = @"すれ違い";
        
        self.passings = [EnoNSUserDefaults getPassings];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    // 画面切り替え時に最新にしておく
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)p_makeMyProfileCell:(EnoPassingTableViewCell *)cell
{
    EnoProfileInfo *profile = [EnoNSUserDefaults getProfileModel];
    cell.nameLabel.text     = profile.name;
    cell.messageLabel.text  = profile.message;
    cell.timeLabel.text     = nil;
    
    NSData *data             = [NSData dataWithContentsOfURL:[NSURL URLWithString:profile.iconUrlstring]];
    cell.iconImageView.image = [UIImage imageWithData:data];
    
    return cell;
}

- (UITableViewCell *)p_makePassingedCell:(EnoPassingTableViewCell *)cell AtRow:(NSInteger)row
{
    NSDictionary *passing  = [self.passings objectAtIndex:row];
    cell.nameLabel.text    = [passing objectForKey:@"name"];
    cell.messageLabel.text = [passing objectForKey:@"message"];
    
    NSDate *passinged   = [passing objectForKey:@"passinged"];
    cell.timeLabel.text = passinged.description;
    
    NSString *imageUrlstring = [passing objectForKey:@"iconUrlstring"];
    NSData   *imageData      = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlstring]];
    cell.iconImageView.image = [UIImage imageWithData:imageData];
    
    return cell;
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
    
    if ( self.passings ) {
            
        return [self.passings count];
    }
        
    return 0;
}

/**
 * セルの内容を返す
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EnoPassingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if ( indexPath.section == 0 ) {
        
        return [self p_makeMyProfileCell:cell];
    }
    
    return [self p_makePassingedCell:cell AtRow:indexPath.row];
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

# pragma mark - UITableViewDelegate

/**
 * セルの高さ
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

/**
 * セルタップ時、すれ違った人だったら詳細プロフィールページへ
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog( @"tableView didSelect" );
    
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.section == 0 ) {
        
        return;
    }
    
    NSDictionary *passing  = [self.passings objectAtIndex:indexPath.row];
    
    EnoProfileInfo *profile = [[EnoProfileInfo alloc] init];
    profile.userid          = [passing objectForKey:@"userid"];
    profile.name            = [passing objectForKey:@"name"];
    profile.iconUrlstring   = [passing objectForKey:@"iconUrlstring"];
    profile.message         = [passing objectForKey:@"message"];
    profile.passinged       = [passing objectForKey:@"passinged"];
    
    EnoMyProfileViewController *profileVC = [[EnoMyProfileViewController alloc] initForOthers:profile];
    [self.navigationController pushViewController:profileVC animated:YES];
    
    NSLog( @"%@", passing );
}

@end
