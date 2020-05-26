//
//  UIImage+Extension.h
//  customer_rebuild
//
//  Created by quanqiuwa on 2019/4/27.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)startPageImage;


- (UIImage *)circleImageWithborderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
