//
//  EnoEditIconViewController.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/02.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoEditIconViewController.h"

@interface EnoEditIconViewController ()

@property (strong, nonatomic) IBOutlet UITextField *urlTextField;
@property (strong, nonatomic) IBOutlet UIView      *iconArea;

@property (strong, nonatomic) EnoUIAsyncImageView *iconImageView;

@end

@implementation EnoEditIconViewController

- (id)init
{
    self = [super initWithNibName:@"EnoEditIconViewController" bundle:nil];
    
    if ( self ) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.urlTextField.delegate = self;
    
    // 初期からフォーカスを当てておく
    [self.urlTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * テキストフィールドが編集完了直後
 */
- (void)textFieldDidEndEditing:(UITextField*)textField
{
    NSLog( @"textFieldDidEndEditing" );
}

/**
 * Returnボタンタップ後
 */
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSLog( @"textFieldShouldReturn" );
    
    if ( self.iconImageView == nil ) {
        
        self.iconImageView = [[EnoUIAsyncImageView alloc]
                              initWithFrame:self.iconArea.bounds
                              withUrlstring:textField.text];
        [self.iconImageView startLoadImage];
        
        [self.iconArea addSubview:self.iconImageView];
    }
    else {
        
        self.iconImageView.imageUrl = [NSURL URLWithString:textField.text];
        [self.iconImageView reloadImage];
    }
    
    return YES;
}

/**
 * 決定ボタンをクリック
 */
- (IBAction)pressDecisionButton:(id)sender
{
    // デリゲートが定義されていれば閉じる
    if( [self.delegate respondsToSelector:@selector(didPressDecisionButtonWithUrlstring:)] ) {
        
        [self.delegate didPressDecisionButtonWithUrlstring:self.urlTextField.text];
    }
}

/**
 * 閉じるボタンをクリック
 */
- (IBAction)pressCloseButton:(id)sender
{
    // デリゲートが定義されていれば閉じる
    if( [self.delegate respondsToSelector:@selector(didPressCloseButton)] ) {
        
        [self.delegate didPressCloseButton];
    }
}

@end
