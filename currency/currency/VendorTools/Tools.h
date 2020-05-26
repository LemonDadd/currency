//
//  Tools.h
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/4/16.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject

/**
 *  倒计时工具
 */
+ (void)verificationCode:(long long)time blockYes:(void(^)(void))blockYes blockNo:(void(^)(id time))blockNo;

+ (void)stopVerificationCode;


/**
 *  根据给定的宽度算出等比例的高度
 */
+ (CGFloat)scalHeightByWidth:(CGFloat)width
                      BySize:(CGSize)size;


/**
 *  根据给定的高度算出等比例的宽度
 */
+ (CGFloat)scalWidthByHeight:(CGFloat)height
                      BySize:(CGSize)size;

/**
 弹框
 */
+ (void)setAlertWithTitle:(NSString *)title
                  message:(NSString *)message
        cancelButtonTitle:(NSString *)cancelButtonTitle
        cancelButtonColor:(UIColor *)cancelButtonColor
        otherButtonTitles:(NSString *)otherButtonTitles
         otherButtonColor:(UIColor *)otherButtonColor
           viewController:(UIViewController *)viewController
                    block:(void (^)(NSInteger index))block;

+ (UIViewController *)jsd_getCurrentViewController;

/**
 图片选择弹框
 */
+ (void)showCameraWithViewController:(UIViewController *)viewController cameraBlock:(void (^)(void))cameraBlock albumBlock:(void (^)(void))albumBlock;


/**
 字典转字符串
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

/**
 字符串转字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;



/**
 拨打电话
 */
+ (void)callPhone:(NSString *)phoneNumber;


/**
 CIImage -> UIImage
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGSize)size;

// 小数不四舍五入转化字符串
+(NSString *)notRounding:(CGFloat)price;

//获取剪切板内容
+(NSString *)getPboardContent;


@end

NS_ASSUME_NONNULL_END
