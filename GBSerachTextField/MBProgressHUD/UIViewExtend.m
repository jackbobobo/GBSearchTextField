//
//  UIViewExtend.m
//  YuJingWan
//
//  Created by Jomi on 12-11-17.
//  Copyright (c) 2012年 kklink. All rights reserved.
//

#import "UIViewExtend.h"
//#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
//#import "UIImageView+WebCache.h"
#import <AudioToolbox/AudioToolbox.h>
@implementation UIView (Extend)

/**
 @功能:在视图上添加菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style
{
    UIView *view = [self viewWithTag:ACTIVITYTAG];
    
    if ( nil != view ) {
        [self removeActivityIndicatorView];
    }
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    aiv.frame = CGRectMake( (self.frame.size.width - ACTIVITYWIDTH) / 2.0, 
                           (self.frame.size.height - ACTIVITYHRIGHT) / 2.0, 
                           ACTIVITYWIDTH, ACTIVITYHRIGHT);
    aiv.tag = ACTIVITYTAG;
    [aiv startAnimating];
    [self addSubview:aiv];
}

/**
 @功能:在视图上添加菊花
 @param UIActivityIndicatorViewStyle  菊花类型
 @param activitySize                  加载菊花宽、高
 @返回值:更改后的图片对象
 */
- (void) addActivityIndicatorView:(UIActivityIndicatorViewStyle) style withSize:(int)activitySize
{
    UIView *view = [self viewWithTag:activitySize];
    
    if ( nil != view ) {
        [self removeActivityIndicatorView];
    }
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    aiv.frame = CGRectMake( (self.frame.size.width - activitySize) / 2.0,
                           (self.frame.size.height - activitySize) / 2.0,
                           activitySize, activitySize);
    aiv.tag = activitySize;
    [aiv startAnimating];
    [self addSubview:aiv];
}

/**
 @功能:删除视图上的菊花
 @返回值:空
 */
- (void) removeActivityIndicatorView 
{
    UIView *subView = [self viewWithTag:ACTIVITYTAG];
    [subView removeFromSuperview];
}

/**
 @功能:删除视图上的菊花
 @返回值:空
 */
- (void) removeActivityIndicatorView:(int)activitySize
{
    UIView *subView = [self viewWithTag:activitySize];
    [subView removeFromSuperview];
}

/**
 @功能:在视图上添加HUD菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDActivityView:(NSString*) labelText
{
//    UIView *view = [self viewWithTag:HUDTAG];
//    
//    if ( nil != view ) {
//        [self removeHUDActivityView];
//    }
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.tag = HUDTAG;
    HUD.labelText = labelText;
    HUD.userInteractionEnabled = NO;
    [self addSubview:HUD];
    [HUD show:YES];
}

- (void) addHUDActivityView:(NSString*) labelText needLockScreen:(BOOL)lock
{
    //    UIView *view = [self viewWithTag:HUDTAG];
    //
    //    if ( nil != view ) {
    //        [self removeHUDActivityView];
    //    }
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.tag = HUDTAG;
    HUD.labelText = labelText;
    HUD.userInteractionEnabled = lock;
    [self addSubview:HUD];
    [HUD show:YES];
}

/**
 @功能:删除视图上的HUD菊花
 @返回值:空
 */
- (void) removeHUDActivityView
{
    UIView *subView = [self viewWithTag:HUDTAG];
    if (subView) {
        
        [subView removeFromSuperview];
    }
}

/**
 @功能:在视图上添加HUD菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDLabelView:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay 
{
    
    UIView *view = [self viewWithTag:HUDLABELTAG];
    
    if ( nil != view ) {
        [view removeHUDActivityView];
    }
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.tag = HUDLABELTAG;
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = labelText;
    HUD.labelFont = [UIFont systemFontOfSize:11];
    [self addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
}

- (void) addMaskImage:(UIImage*) maskImage
{
    CALayer* roundCornerLayer = [CALayer layer];
    roundCornerLayer.frame = self.bounds;
    roundCornerLayer.contents = (id)[maskImage CGImage];
    [[self layer] setMask:roundCornerLayer];
}

/**
 @brief 添加截屏闪烁效果
 */
-(void)addHUDAllScreenAfterDelay:(NSTimeInterval)delay WithFrame:(CGRect)frame
{
    
//    SystemSoundID soundID;
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"shotScreen" ofType:@"wav"];
//
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
//
//    AudioServicesPlaySystemSound(soundID);
    
    
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.5;
    
    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=delay;
    theAnimation.repeatCount=1;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:0.0];
    theAnimation.toValue=[NSNumber numberWithFloat:1.0];
//    theAnimation.delegate = self;
    theAnimation.removedOnCompletion = YES;
    [view.layer addAnimation:theAnimation forKey:@"animateOpacity"];
    
    [self addSubview:view];
    [view performSelector:@selector(removeFromSuperview) withObject:view afterDelay:delay];
 
}

- (void) addHUDLabelWindow:(NSString*) labelText Image:(UIImage*) image afterDelay:(NSTimeInterval)delay
{
    
    UIView *view = [self viewWithTag:HUDLABELTAG];
    
    if ( nil != view ) {
        [view removeHUDActivityView];
    }
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self];
    HUD.tag = HUDLABELTAG;
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = labelText;

    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    [tempWindow addSubview:HUD];
    

    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
}

/**
 @method 自定义提示框
 @param labelText   提示文字
 @param frame       提示框位置
 @param image       提示框背景图
 @param delay       提示框的动画时间
 */
- (void) addHUDLabelView:(NSString*) labelText withFrame:(CGRect)frame Image:(UIImage*) image afterDelay:(NSTimeInterval)delay
{
    UIImageView *hubImgView = [[UIImageView alloc] initWithFrame:frame];
    if (image !=nil) {
        [hubImgView setImage:image];
    } else {
        [hubImgView setBackgroundColor:[UIColor blackColor]];
    }
    hubImgView.layer.cornerRadius = 10;
    hubImgView.layer.masksToBounds = YES;
    hubImgView.alpha = 0.5;
    [self addSubview:hubImgView];
    
    //字体
    frame.origin.x = 0;
    frame.origin.y = 0;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.textColor = [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
    titleLabel.numberOfLines = 20;
    [titleLabel setText:labelText];
    [hubImgView addSubview:titleLabel];
    
    [UIView animateWithDuration:delay animations:^{
        hubImgView.alpha = 1.0;
    } completion:^(BOOL finished) {
        hubImgView.alpha = 0.0;
        [hubImgView removeFromSuperview];
    }];
}

/**
 @method 自定义图文提示框
 @param labelText   提示文字
 @param image       提示框图
 @param delay       提示框的动画时间
 */
- (void) addHUDImgView:(NSString*) labelText withImage:(UIImage*) image afterDelay:(NSTimeInterval)delay
{
    UIView *view = [self viewWithTag:HUDTAG];
    if ( nil != view ) {
        [self removeHUDImgView];
    }
    
    CGRect frame = CGRectZero;
    CGSize contentSize = [labelText sizeWithFont:[UIFont boldSystemFontOfSize:12]];
    if (contentSize.width < 160) {
        frame.size.width = contentSize.width + 40;
    } else {
        frame.size.width = 160 + 40;
    }
    int height = (contentSize.width/frame.size.width+1)*contentSize.height;
    frame.size.height = height + image.size.height + 20;
    frame.origin.x = (self.frame.size.width - frame.size.width)/2;
    frame.origin.y = (self.frame.size.height - frame.size.height)/2;
    UIView *hubImgView = [[UIView alloc] initWithFrame:frame];
    [hubImgView setBackgroundColor:[UIColor blackColor]];
    hubImgView.layer.cornerRadius = 10;
    hubImgView.layer.masksToBounds = YES;
    hubImgView.alpha = 0.5;
    hubImgView.tag = HUDTAG;
    [self addSubview:hubImgView];
    
    //字体
    frame.origin.y = 10;
    if (contentSize.width < 160) {
        frame.size.width = contentSize.width;
    } else {
        frame.size.width = 160;
    }
    frame.origin.x = (hubImgView.frame.size.width - frame.size.width)/2;
    frame.size.height = height;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
    titleLabel.font = [UIFont boldSystemFontOfSize:12];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setNumberOfLines:10];
    titleLabel.textColor = [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
    titleLabel.numberOfLines = 20;
    [titleLabel setText:labelText];
    [hubImgView addSubview:titleLabel];
    
    //图片
    frame.origin.x = (hubImgView.frame.size.width - image.size.width)/2;
    frame.origin.y = (titleLabel.frame.origin.y + titleLabel.frame.size.height);
    frame.size = image.size;
    UIImageView *tipImgView = [[UIImageView alloc] init];
    [tipImgView setFrame:frame];
    [tipImgView setImage:image];
    [hubImgView addSubview:tipImgView];
    
    [UIView animateWithDuration:delay animations:^{
        hubImgView.alpha = 1.0;
    } completion:^(BOOL finished) {
        hubImgView.alpha = 0.0;
        [hubImgView removeFromSuperview];
    }];
}

/**
 @功能:删除自定义图文提示框
 @返回值:空
 */
- (void) removeHUDImgView
{
    UIView *subView = [self viewWithTag:HUDTAG];
    for (UIView *sv in subView.subviews) {
        [sv removeFromSuperview];
    }
    [subView removeFromSuperview];
}

@end
