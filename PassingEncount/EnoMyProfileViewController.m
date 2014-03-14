//
//  EnoMyProfileViewController.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/01.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoMyProfileViewController.h"

@interface EnoMyProfileViewController ()

@property (strong, nonatomic) IBOutlet UIView      *iconArea;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;

@property (nonatomic, strong) UITextField            *currentTextField;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) EnoUIAsyncImageView    *iconImageView;
@property (nonatomic, strong) EnoProfileInfo         *profile;

@property (nonatomic) BOOL isMine;

@end

@implementation EnoMyProfileViewController

- (id)init
{
    self = [super initWithNibName:@"EnoMyProfileViewController" bundle:nil];
    
    if ( self ) {
        
        self.title = @"マイプロフ";
        
        self.currentTextField = nil;
        
        self.profile = [EnoNSUserDefaultsProfile getProfileModel];
        
        self.isMine = YES;
    }
    
    return self;
}

- (id)initForOthers:(EnoProfileInfo *)profile
{
    self = [super initWithNibName:@"EnoMyProfileViewController" bundle:nil];
    
    if ( self ) {
        
        self.title = @"プロフィール";
        
        self.profile = profile;
        
        self.isMine = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameTextField.text    = self.profile.name;
    self.messageTextField.text = self.profile.message;
    
    self.nameTextField.delegate    = self;
    self.messageTextField.delegate = self;
    
    self.singleTap                      = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(onSingleTap:)];
    self.singleTap.delegate             = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
    self.iconImageView = [[EnoUIAsyncImageView alloc]
                          initWithFrame:self.iconArea.bounds
                          withUrlstring:self.profile.iconUrlstring];
    [self.iconImageView startLoadImage];
    [self.iconArea addSubview:self.iconImageView];
    
    if ( ! self.isMine ) {
        
        self.nameTextField.enabled       = NO;
        self.messageTextField.enabled    = NO;
        self.view.userInteractionEnabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 * タップされたらキーボードを閉じる
 */
- (void)onSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.currentTextField resignFirstResponder];
}

/**
 * タッチイベントを拾う
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // iconAreaViewをタッチした
    if ( touch.view == self.iconArea ) {
        
        EnoEditIconViewController *editIconVC = [[EnoEditIconViewController alloc] init];
        editIconVC.delegate = self;
        [self presentViewController:editIconVC animated:YES completion:nil];
    }
}

#pragma mark - UIGestureRecognizerDelegate

/**
 * キーボードを表示していない時は、他のジェスチャに影響を与えないように無効化
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ( gestureRecognizer == self.singleTap ) {
        
        if ( ! self.currentTextField ) {
            
            return NO;
        }
        
        // キーボード表示中のみ有効
        if ( self.currentTextField.isFirstResponder ) {
            
            return YES;
        }
        else {
            
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate

/**
 * テキストフィールドが編集モードになった直後
 */
- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    NSLog( @"textFieldDidBeginEditing" );
    
    self.currentTextField = textField;
}

/**
 * テキストフィールドが編集完了直後
 */
- (void)textFieldDidEndEditing:(UITextField*)textField
{
    NSLog( @"textFieldDidEndEditing" );
    
    // テキストフィールドの文字を設定値に戻す
    if ( textField == self.nameTextField ) {
        
        self.nameTextField.text = self.profile.name;
    }
    else if ( textField == self.messageTextField ) {
        
        self.messageTextField.text = self.profile.message;
    }
    
    self.currentTextField = nil;
}

/**
 * Returnボタンタップ後
 */
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSLog( @"textFieldShouldReturn" );
    
    if ( textField == self.nameTextField ) {
        
        self.profile.name = self.nameTextField.text;
    }
    else if ( textField == self.messageTextField ) {
        
        self.profile.message = self.messageTextField.text;
    }
    
    [EnoNSUserDefaultsProfile setProfileJsonObjWithModel:self.profile];
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - EnoEditIconViewControllerDelegate

/**
 * モーダル側で決定ボタンが押された
 */
- (void)didPressDecisionButtonWithUrlstring:(NSString *)urlstring
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.profile.iconUrlstring = urlstring;
    
    // 画像の再読み込み
    self.iconImageView.imageUrl = [NSURL URLWithString:urlstring];
    [self.iconImageView reloadImage];
    
    [EnoNSUserDefaultsProfile setProfileJsonObjWithModel:self.profile];
}

/**
 * モーダル側で閉じるボタンが押された
 */
- (void)didPressCloseButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
