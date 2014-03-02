//
//  EnoUIAsyncImageView.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/01.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoUIAsyncImageView.h"

#define VIEW_TAG 1

@interface EnoUIAsyncImageView()

@property (nonatomic, retain) NSURLConnection *conn;
@property (nonatomic, retain) NSMutableData   *data;

@end

@implementation EnoUIAsyncImageView

- (id)initWithFrame:(CGRect)frame withUrlstring:(NSString *)urlstring
{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        [self setImageUrl:[NSURL URLWithString:urlstring]];
    }
    
    return self;
}

- (void)startLoadImage
{
    // 既に読み込まれているならそのまま
    if ( self.image ) { return; }
    
    if ( self.conn ) {
        
        [self.conn cancel];
    }
    
    [self setData:[NSMutableData data]];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:self.imageUrl];
    
    self.conn = [NSURLConnection connectionWithRequest:req delegate:self];
    
    [self p_setLoadingImage];
}

- (void)reloadImage
{
    [self setImage:nil];
    [self startLoadImage];
}

- (void)cancelLoading
{
    [self.conn cancel];
    self.conn = nil;
    
    if ( ! self.image ) {
        
        [self p_setLoadErrorImage];
    }
}

#pragma mark - private method

/**
 * 読み込み中画像のセット
 */
- (void)p_setLoadingImage
{
    UIActivityIndicatorView *iv = (UIActivityIndicatorView *)
    [self viewWithTag:VIEW_TAG];
    
    if ( ! iv ) {
        // 読み込み中画像のセット
        iv = [[UIActivityIndicatorView alloc]
              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [iv setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        [iv setTag:VIEW_TAG];
        
        [self addSubview:iv];
    }
    
    [iv startAnimating];
    [iv setHidden:NO];
    
    //[self setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3]];
    [self setBackgroundColor:[UIColor whiteColor]];
}

/**
 * 画像読み込みが失敗したとき
 */
- (void)p_setLoadErrorImage
{
    UIActivityIndicatorView *iv = (UIActivityIndicatorView *)
    [self viewWithTag:VIEW_TAG];
    [iv removeFromSuperview];
    
    [self setImage:nil];
    //[self setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.4]];
    [self setBackgroundColor:[UIColor redColor]];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self p_setLoadErrorImage];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIActivityIndicatorView *iv = (UIActivityIndicatorView *)
    [self viewWithTag:VIEW_TAG];
    
    if ( iv ) {
        
        [iv removeFromSuperview];
    }
    
    [self setImage:[UIImage imageWithData:self.data]];
}

@end
