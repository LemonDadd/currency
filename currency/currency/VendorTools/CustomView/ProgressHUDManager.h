//
//  ProgressHUDManager.h
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/6/29.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressHUDManager : NSObject

/**
 单行显示
 */
+ (void)showOnlyText:(NSString *)text;

+ (void)showLoadText:(NSString *)text withCompletion:(void(^)(void))completion;

// 配送时间单行显示
+ (void)showPSSJOnlyText:(NSString *)text;

/**
 文字 + 详情
 */
+ (void)showOnlyText:(NSString *)text deatil:(NSString *)detail;

/**
 菊花
 */
+ (void)showOnlyLoad;

/**
 菊花 + 文字
 */
+ (void)showLoadText:(NSString *)text;

/**
 图片 + 文字
 */
+ (void)showCustomView:(UIImage *)image title:(NSString *)title;

//弹出显示配送时间
+ (MBProgressHUD *)setPSSJHUD:(NSString *)title autoHidden:(BOOL)autoHidden;

+ (void)showSuccessWithTitle:(NSString *)title;

/**
 动画加载
 */
+ (void)showAnimationLodding;

/**
 隐藏
 */
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
