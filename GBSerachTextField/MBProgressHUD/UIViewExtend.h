//
//  UIViewExtend.h
//  YuJingWan
//
//  Created by jomi on 12-11-17.
//  Copyright (c) 2012年 kklink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define ACTIVITYWIDTH       20
#define ACTIVITYHRIGHT      20
#define ACTIVITYTAG         666666
#define HUDTAG              (ACTIVITYTAG + 1)
#define HUDLABELTAG         (HUDTAG + 1)

@interface UIView (Extend)

/**
 @brief 在视图上添加菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style;

/**
 @brief 删除视图上的菊花
 @返回值:空
 */
- (void) removeActivityIndicatorView;

/**
 @brief 在视图上添加菊花
 @param UIActivityIndicatorViewStyle  菊花类型
 @param activitySize                  加载菊花宽、高
 @返回值:更改后的图片对象
 */
- (void) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style withSize:(int)activitySize;

/**
 @brief 删除视图上的菊花
 @返回值:空
 */
- (void) removeActivityIndicatorView:(int)activitySize;


/**
 @功能:在视图上添加HUD菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDActivityView:(NSString*) labelText;


- (void) addHUDActivityView:(NSString*) labelText needLockScreen:(BOOL)lock;

/**
 @brief 删除视图上的HUD菊花
 @返回值:空
 */
- (void) removeHUDActivityView;

/**
 @brief 在视图上添加HUD提示
 @param UIImage  使用的图片
 @param NSTimeInterval 多少秒后自动消失
 @返回值:更改后的图片对象
 */
- (void) addHUDLabelView:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay;

- (void) addHUDLabelWindow:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay;

- (void) addMaskImage:(UIImage*) maskImage;

/**
 @brief 自定义提示框
 @param labelText   提示文字
 @param frame       提示框位置
 @param image       提示框背景图
 @param delay       提示框的动画时间
 */
- (void) addHUDLabelView:(NSString*) labelText
               withFrame:(CGRect)frame
                   Image:(UIImage*) image
              afterDelay:(NSTimeInterval)delay;

/**
 @brief 自定义图文提示框
 @param labelText   提示文字
 @param image       提示框图
 @param delay       提示框的动画时间
 */
- (void) addHUDImgView:(NSString*) labelText
             withImage:(UIImage*) image
            afterDelay:(NSTimeInterval)delay;

/**
 @brief 添加截屏闪烁效果
 */
-(void)addHUDAllScreenAfterDelay:(NSTimeInterval)delay WithFrame:(CGRect)frame;

@end
