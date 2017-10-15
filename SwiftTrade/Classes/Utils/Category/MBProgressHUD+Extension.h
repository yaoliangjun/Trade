//
//  MBProgressHUD+Extension.h
//  iCan
//
//  Created by Jerry Yao on 2016/4/19.
//  Copyright © 2016年 MS. All rights reserved.
//  MBProgressHUD二次封装

//#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Extension)

#pragma mark - 显示HUD，然后消失

/** 显示一个成功的文本信息, 带对勾的HUD, 一秒后消失 */
+ (void)showSuccessWithStatus:(NSString *)status;

/** 显示一个失败的文本信息HUD, 一秒后消失 */
+ (void)showErrorWithStatus:(NSString *)status;

/** 显示一个文本信息HUD, 1.5秒后消失 */
+ (void)showWithStatus:(NSString *)status;

/**
 @param status 需要显示的Toast
 @param duration 显示多久,单位是秒
 */
+ (void)showWithStatus:(NSString *)status duration:(float)duration;

/**
 默认的Toast，一秒后消失，消失后再做一些事情
 
 @param status <#status description#>
 @param completionHandle <#completionHandle description#>
 */
+ (void)showWithStatus:(NSString *)status completionHandle:(void(^)())completionHandle;

/** 显示一个文本信息, 带菊花加载的HUD, 一秒后消失 */
+ (void)showLoadingWithStatus:(NSString *)status;

/** 显示一个菊花加载 */
+ (void)showLoading;

/** 隐藏HUD */
+ (void)dismiss;

@end
