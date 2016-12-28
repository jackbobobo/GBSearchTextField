//
//  CustomProgressHud.h
//  DanaVideo
//
//  Created by xu ping on 14-7-3.
//  Copyright (c) 2014年 danale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CustomProgressHud : UIView
{
    UILabel *label;
    UIView *showView;
    UIView *indicator;
}

@property (nonatomic,retain) UIView *customView;
@property (nonatomic,assign) MBProgressHUDMode mode;
@property (nonatomic,copy) NSString *labelText;

- (id)initWithView:(UIView *)view;

- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
