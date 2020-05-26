//
//  Tools.m
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/4/16.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "Tools.h"
#import <CoreImage/CoreImage.h>

@implementation Tools

static dispatch_source_t _timer;

/**
 *  倒计时工具
 *
 *  @param time  倒计时时间
 *  @param blockYes 倒计时结束 设置UI
 *  @param blockNo  倒计时进行中 设置UI
 */
+ (void)verificationCode:(long long)time
                blockYes:(void(^)(void))blockYes
                 blockNo:(void(^)(id time))blockNo
{
    __block long long timeout = time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                blockYes();
            });
        } else {
            //            int minutes = timeout / 60;
            long long seconds = timeout;// % time;
            NSString *strTime = [NSString stringWithFormat:@"%.2llu", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                blockNo(strTime);
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

+ (void)stopVerificationCode
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
}

+ (CGFloat)scalHeightByWidth:(CGFloat)width
                      BySize:(CGSize)size{
    return size.height*width/size.width;
}

+ (CGFloat)scalWidthByHeight:(CGFloat)height
                      BySize:(CGSize)size{
    return height*size.width/size.height;
}

#pragma mark ---- 弹框
+ (void)setAlertWithTitle:(NSString *)title
                  message:(NSString *)message
        cancelButtonTitle:(NSString *)cancelButtonTitle
        cancelButtonColor:(UIColor *)cancelButtonColor
        otherButtonTitles:(NSString *)otherButtonTitles
        otherButtonColor:(UIColor *)otherButtonColor
           viewController:(UIViewController *)viewController
                    block:(void (^)(NSInteger index))block
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        if (block) {
            block(0);
        }
    }];
    [cancelAction setValue:cancelButtonColor forKey:@"_titleTextColor"];
    [alert addAction:cancelAction];
    
    if (![NSObject ldy_isEmpty:otherButtonTitles]) {
        UIAlertAction * otherAction = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (block) {
                block(1);
            }
        }];
        [alert addAction:otherAction];
        [otherAction setValue:otherButtonColor forKey:@"_titleTextColor"];
    }
    [viewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark ---- 获取当前屏幕的controller
+ (UIViewController *)jsd_getCurrentViewController{
    
    UIViewController* currentViewController = [self jsd_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

+ (UIViewController *)jsd_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

#pragma mark ---- 相册弹框
+ (void)showCameraWithViewController:(UIViewController *)viewController cameraBlock:(void (^)())cameraBlock albumBlock:(void (^)())albumBlock
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (cameraBlock) {
            cameraBlock();
        }
    }];
    
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (albumBlock) {
            albumBlock();
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [photoAction setValue:KHEXCOLOR(kMainColor) forKey:@"_titleTextColor"];
    [cancelAction setValue:KHEXCOLOR(kTitleColor) forKey:@"_titleTextColor"];
    
    [alert addAction:cameraAction];
    [alert addAction:photoAction];
    [alert addAction:cancelAction];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark 字典转字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError * parseError = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark 字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


/**
 拨打电话
 */
+ (void)callPhone:(NSString *)phoneNumber
{
    if (![NSObject ldy_isEmpty:phoneNumber]) {
        NSString * str = [[NSString alloc] initWithFormat:@"telprompt://%@", phoneNumber];
        NSURL * url = [NSURL URLWithString:str];
        UIApplication  *application = [UIApplication sharedApplication];
        if (![application canOpenURL:url]) {
            NSLog(@"无法打开\"%@\"，请确保此设备支持拨打电话功能！", url);
            return;
        }
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
    } else {
        NSLog(@"暂无联系方式!");
    }
}

/**
 CIImage -> UIImage
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGSize)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));

    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}


// 小数不四舍五入转化字符串
+(NSString *)notRounding:(CGFloat)price {
    NSNumber *number = @(price);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"###0.00"];
    formatter.roundingMode = NSNumberFormatterRoundDown;
    formatter.maximumFractionDigits = 2;
    return [formatter stringFromNumber:number];
}

+(NSString *)getPboardContent{
    return [UIPasteboard generalPasteboard].string;
}


@end
