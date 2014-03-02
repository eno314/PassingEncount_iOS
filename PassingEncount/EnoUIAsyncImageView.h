//
//  EnoUIAsyncImageView.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/01.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnoUIAsyncImageView : UIImageView

/** 初期化 */
- (id)initWithFrame:(CGRect)frame withUrlstring:(NSString *)urlstring;

/** 画像読み込み開始処理（既に画像が読み込まれているならロードしない） */
- (void)startLoadImage;

/** 画像の再読み込み */
- (void)reloadImage;

/** 読み込んである画像のリセット */
- (void)cancelLoading;

/** urlはセットできるようにしておく */
@property (nonatomic, strong) NSURL *imageUrl;

@end
