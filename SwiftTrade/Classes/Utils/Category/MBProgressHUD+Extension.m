//
//  MBProgressHUD+Extension.m
//  iCan
//
//  Created by Jerry Yao on 2016/4/19.
//  Copyright © 2016年 MS. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kHUDBackgroundColor kHexRGB(0x000000)
#define kHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static int delayInterval = 2;

@implementation MBProgressHUD (Extension)

#pragma mark - show then dismiss method
/**
 默认的Toast，1.5秒后消失
 @param status 需要显示的Toast
 */
+ (void)showWithStatus:(NSString *)status
{
    [self showWithStatus:status duration:delayInterval];
}

/**
 @param status 需要显示的Toast
 @param duration 显示多久,单位是秒
 */
+ (void)showWithStatus:(NSString *)status duration:(float)duration
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.bezelView.backgroundColor = kHUDBackgroundColor;
        hud.bezelView.alpha = 0.7;
        hud.bezelView.layer.cornerRadius = 8;
        hud.mode = MBProgressHUDModeText;
        hud.contentColor = [UIColor whiteColor];
        hud.label.font = [UIFont systemFontOfSize:12];
        hud.label.text = status;
        hud.label.textColor = [UIColor whiteColor];
        hud.label.numberOfLines = 2;
        [hud hideAnimated:NO afterDelay:duration];
    });
}

/**
 默认的Toast，一秒后消失，消失后再做一些事情
 @param status 状态
 @param completionHandle 回调
 */
+ (void)showWithStatus:(NSString *)status completionHandle:(void(^)())completionHandle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.bezelView.backgroundColor = kHUDBackgroundColor;
        hud.bezelView.alpha = 0.7;
        hud.bezelView.layer.cornerRadius = 8;
        hud.mode = MBProgressHUDModeText;
        hud.contentColor = [UIColor whiteColor];
        hud.label.font = [UIFont systemFontOfSize:12];
        hud.label.text = status;
        hud.label.numberOfLines = 2;
        [hud hideAnimated:NO afterDelay:delayInterval];
        
        // 等待toast消失后，执行回调
        if (completionHandle) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                completionHandle();
            });
        }
    });
}

+ (void)showSuccessWithStatus:(NSString *)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.bezelView.backgroundColor = kHUDBackgroundColor;
        hud.bezelView.alpha = 0.7;
        hud.bezelView.layer.cornerRadius = 8;
        hud.contentColor = [UIColor whiteColor];
        hud.mode = MBProgressHUDModeCustomView;
        UIImage *image = [[UIImage imageNamed:@"hud_checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        // Looks a bit nicer if we make it square.
        hud.square = YES;
        hud.label.font = [UIFont systemFontOfSize:12];
        hud.label.text = status;
        hud.label.numberOfLines = 2;
        [hud hideAnimated:NO afterDelay:delayInterval];
        
    });
}

+ (void)showErrorWithStatus:(NSString *)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.bezelView.backgroundColor = kHUDBackgroundColor;
        hud.bezelView.alpha = 0.7;
        hud.bezelView.layer.cornerRadius = 8;
        hud.mode = MBProgressHUDModeCustomView;
        hud.contentColor = [UIColor whiteColor];
        UIImage *image = [[UIImage imageNamed:@"hud_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc] initWithImage:image];
        // Looks a bit nicer if we make it square.
        hud.square = YES;
        hud.label.font = [UIFont systemFontOfSize:12];
        hud.label.text = status;
        hud.label.numberOfLines = 2;
        [hud hideAnimated:NO afterDelay:delayInterval];
    });
}

#pragma mark - show method

/**
 显示菊花加载框
 */
+ (void)showLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        CGFloat hudWH = 100;
        CGRect frame = hud.frame;
        frame = CGRectMake((SCREEN_WIDTH - hudWH) / 2, (SCREEN_HEIGHT - hudWH) / 2, hudWH, hudWH);
        hud.frame = frame;
        hud.bezelView.backgroundColor = kHUDBackgroundColor;
        hud.bezelView.alpha = 0.7;
        hud.bezelView.layer.cornerRadius = 8;
        hud.contentColor = [UIColor whiteColor];
        kKeyWindow.userInteractionEnabled = NO; // 禁止交互
    });
}

+ (void)showLoadingWithStatus:(NSString *)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.bezelView.backgroundColor = kHUDBackgroundColor;
        hud.bezelView.alpha = 0.7;
        hud.bezelView.layer.cornerRadius = 8;
        hud.label.text = status;
        hud.label.font = [UIFont systemFontOfSize:12];
        hud.contentColor = [UIColor whiteColor];
    });
}

/**
 隐藏菊花加载框
 */
+ (void)dismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:kKeyWindow];
        [hud hideAnimated:NO];
        kKeyWindow.userInteractionEnabled = YES; // 允许交互
    });
}

@end
