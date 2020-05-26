//
//  CustomView.h
//  zjproject
//
//  Created by rockontrol on 15/4/15.
//  Copyright (c) 2015年 rockontrol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@protocol CustomViewDelegate <NSObject>

@optional
- (void)closeWindowBy;

@end

@interface CustomView : UIView

{
    MBProgressHUD *HUD;
    
    //全局弹出提示框
    UIView *mainWindow;
    __weak id mainWindowView;
}

@property (nonatomic, weak) id<CustomViewDelegate> delegate;

+ (instancetype)getInstancetype;

/**
 *  高级提醒框
 *
 */
- (void)windowAlertBy:(UIView*)view
         isTouchClose:(BOOL)isTouchClose
                color:(UIColor *)color
             animated:(BOOL)animated
          addDelegate:(id<CustomViewDelegate>)delegate;

/**
 *  关闭上边的高级提醒框
 */
- (void)closeWindowAlertWithanimated:(BOOL)animated;

/**
 *  关闭上边的高级提醒框
 */
- (void)closeWindowAlertWithanimated:(BOOL)animated
                            complete:(void(^)())complete;

/**
 *  显示等待视图
 *
 */
- (void)showWaitView:(NSString*)noticeMsg;
- (void)showWaitView:(NSString*)noticeMsg byView:(UIView*)view;

/**
 *  关闭等待视图
 */
- (void)closeHUD;

/**
 *  具备回调的消息提醒功能
 *
 */
- (void)showAlertView:(NSString*)noticeMsg
               byView:(UIView*)view
           completion:(void(^)(void))completion;

/**
 *  具备回调的消息提醒功能
 *
 */
- (void)showAlertView:(NSString*)noticeMsg
               byView:(UIView*)view
                delay:(int)delay
           completion:(void(^)(void))completion;

/**
 *  警告视图
 *
 */
+ (void)alertView:(NSString*)title content:(NSString*)content;

/**
 *  提醒视图
 *
 */
+ (void)alertMessage:(NSString*)title view:(UIView*)view;

+ (void)show;

@end













