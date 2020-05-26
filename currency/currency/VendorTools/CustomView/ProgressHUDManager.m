//
//  ProgressHUDManager.m
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/6/29.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "ProgressHUDManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Tools.h"

//static MBProgressHUD * Progress;
CGFloat const delayTime = 1.2;
static MBProgressHUD * HUD;
static UIView * window;

@implementation ProgressHUDManager

// 单行显示
+ (void)showOnlyText:(NSString *)text
{
    if ([NSObject ldy_isEmpty:text]) {
        return;
    }
    MBProgressHUD * hud = [self setHUD:text autoHidden:YES];
    hud.mode = MBProgressHUDModeText;
}

// 配送时间单行显示
+ (void)showPSSJOnlyText:(NSString *)text
{
    if ([NSObject ldy_isEmpty:text]) {
        return;
    }
    MBProgressHUD * hud = [self setPSSJHUD:text autoHidden:YES];
    hud.mode = MBProgressHUDModeText;
}

// 文字 + 详情
+ (void)showOnlyText:(NSString *)text deatil:(NSString *)detail
{
    MBProgressHUD * hud = [self setHUD:text autoHidden:YES];
    hud.detailsLabel.text = detail;
    hud.mode = MBProgressHUDModeText;
}

// 菊花
+ (void)showOnlyLoad
{
    MBProgressHUD * hud = [self setHUD:nil autoHidden:NO];
    hud.mode = MBProgressHUDModeIndeterminate;
}

// 菊花 + 文字
+ (void)showLoadText:(NSString *)text
{
    MBProgressHUD * hud = [self setHUD:text autoHidden:NO];
    hud.mode = MBProgressHUDModeIndeterminate;
}

+ (void)showLoadText:(NSString *)text withCompletion:(void(^)(void))completion
{
    MBProgressHUD * hud = [self setHUD:text autoHidden:NO];
    hud.mode = MBProgressHUDModeText;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [self hideHUD];
        if (completion) {
            completion();
        }
    });
}

//- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(nullable MBProgressHUDCompletionBlock)completion

// 图片 + 文字
+ (void)showCustomView:(UIImage *)image title:(NSString *)title
{
    MBProgressHUD * hud = [self setHUD:title autoHidden:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
}

+ (void)showSuccessWithTitle:(NSString *)title
{
    // Black gold order_Popovers_failure 感叹号
    // toast_icon_succeed
    // toast_icon_error
    [self showCustomView:nil title:title];
}

+ (void)showAnimationLodding {
    
    MBProgressHUD * hud = [self setHUD:nil autoHidden:NO];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading"]];
    hud.customView = imageView;
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = .5;
    rotationAnimation.repeatCount = MAXFLOAT;
    [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    
}

// 隐藏
+ (void)hideHUD
{
    UIView * view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [MBProgressHUD hideHUDForView:view animated:NO];
}

+ (MBProgressHUD *)createHUD
{
    UIView * view = (UIView*)[UIApplication sharedApplication].delegate.window;
    
    return [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (MBProgressHUD *)setHUD:(NSString *)title autoHidden:(BOOL)autoHidden
{
    MBProgressHUD * hud = [self createHUD];
    hud.label.text = title;
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    if (autoHidden) {
        [hud hideAnimated:YES afterDelay:delayTime];
    }
    
    return hud;
}

//弹出显示配送时间
+ (MBProgressHUD *)setPSSJHUD:(NSString *)title autoHidden:(BOOL)autoHidden
{
    MBProgressHUD * hud = [self createHUD];
    hud.label.text = title;
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = KHEXCOLOR(0xf23d3d);
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    if (autoHidden) {
        [hud hideAnimated:YES afterDelay:delayTime];
    }
    
    return hud;
}

@end
