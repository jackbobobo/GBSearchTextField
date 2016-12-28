//
//  CustomProgressHud.m
//  DanaVideo
//
//  Created by xu ping on 14-7-3.
//  Copyright (c) 2014年 danale. All rights reserved.
//

#import "CustomProgressHud.h"

#define kMargin 40.0f
#define kFontSize 15.0f
#define kMinWidth 100.0f

@implementation CustomProgressHud

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        showView = [[UIView alloc]init];
        showView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
        showView.layer.cornerRadius = 10.0f;
        [self addSubview:showView];
        
        label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:kFontSize];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = NO;
        label.opaque = NO;
        label.textColor = [UIColor whiteColor];
        label.lineBreakMode  = UILineBreakModeWordWrap;
        label.numberOfLines = 10;
        [showView addSubview:label];
    }
    return self;
}

- (id)initWithView:(UIView *)view
{
	// Let's check if the view is nil (this is a common error when using the windw initializer above)
	if (!view) {
		[NSException raise:@"MBProgressHUDViewIsNillException"
					format:@"The view used in the MBProgressHUD initializer is nil."];
	}
	id me = [self initWithFrame:view.bounds];
	
	return me;
}

-(void)setLabelText:(NSString *)labelText
{
    if(labelText != _labelText)
    {
//        [_labelText release];
        _labelText = labelText;
        
        [self setNeedsLayout];
        [self setNeedsDisplay];
    }
}

-(void)setMode:(MBProgressHUDMode)mode
{
    if(mode != _mode)
    {
        _mode = mode;
        
        [self updateIndicators];
    }
}

- (void)updateIndicators {
    if (indicator) {
        [indicator removeFromSuperview];
    }
	
    if (_mode == MBProgressHUDModeDeterminate) {
#if __has_feature(objc_arc)
        indicator = [[MBRoundProgressView alloc] init];
#else
        indicator = [[[MBRoundProgressView alloc] init] autorelease];
#endif
    }
    else if (_mode == MBProgressHUDModeCustomView && self.customView != nil){
        indicator = self.customView;
    } else {
#if __has_feature(objc_arc)
		indicator = [[UIActivityIndicatorView alloc]
                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
#else
		indicator = [[[UIActivityIndicatorView alloc]
						   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
#endif
        [(UIActivityIndicatorView *)indicator startAnimating];
	}
	
    [showView addSubview:indicator];
}

-(void)layoutSubviews
{
    if(_labelText && _labelText.length > 0)
    {
        CGRect frect = CGRectZero;
        UIFont *labelFont = [UIFont systemFontOfSize:kFontSize];
        if(indicator == nil)
        {
            float maxWidth = self.bounds.size.width - 2 * kMargin;
            CGSize constrainedSize = CGSizeMake(maxWidth, 20000.0f);
            CGSize textSize = [_labelText sizeWithFont:labelFont constrainedToSize:constrainedSize];
            if(textSize.width < kMinWidth)
            {
                textSize.width = kMinWidth;
            }
            
            float width = textSize.width + 10.0f;
            float height = textSize.height + 10.0f;
            frect.origin.x = (self.bounds.size.width - width) / 2.0f;
            frect.origin.y = (self.bounds.size.height - height) / 2.0f;
            frect.size.width = width;
            frect.size.height = height;
            showView.frame = frect;
            
            frect.origin.x = 0;
            frect.origin.y = 0;
            label.frame = frect;
        }
        else
        {
            float width = indicator.bounds.size.width + 2 * 10.0f;
            CGSize constrainedSize = CGSizeMake(width, 20000.0f);
            CGSize textSize = [_labelText sizeWithFont:labelFont constrainedToSize:constrainedSize];
            if(width < kMinWidth)
            {
                width = kMinWidth;
            }
            
            float height = indicator.bounds.size.height + 2 * 10.0f + textSize.height;
            
            frect.origin.x = (self.bounds.size.width - width) / 2.0f;
            frect.origin.y = (self.bounds.size.height - height) / 2.0f;
            frect.size.width = width;
            frect.size.height = height;
            showView.frame = frect;
            
            frect.origin.x = (width - indicator.bounds.size.width) / 2.0f;
            frect.origin.y = 10;
            frect.size = indicator.bounds.size;
            indicator.frame = frect;
            
            frect.origin.x = 0;
            frect.origin.y = CGRectGetMaxY(indicator.frame);
            frect.size.width = width;
            frect.size.height = textSize.height;
            label.frame = frect;
        }
        label.text = _labelText;
    }
}

- (void)show:(BOOL)animated
{
    self.alpha = 0.0f;

    // Fade in
    if (animated) {
        [UIView animateWithDuration:0.30 animations:^{
            self.alpha = 1.0f;
        }];
    }
    else {
        self.alpha = 1.0f;
    }
}

- (void)hide:(BOOL)animated
{
	if (animated) {
        [UIView animateWithDuration:0.30 animations:^{
            self.alpha = 0.02f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else {
        self.alpha = 0.0f;
        [self removeFromSuperview];
    }
}

- (void)hideDelayed:(NSNumber *)animated {
	[self hide:[animated boolValue]];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
	[self performSelector:@selector(hideDelayed:) withObject:[NSNumber numberWithBool:animated] afterDelay:delay];
}

@end
