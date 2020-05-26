//
//  UIColor+Extension.h
//  sport
//
//  Created by fen9fe1 on 15/5/9.
//  Copyright (c) 2015年 fen9fe1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

+ (UIColor *)colorWithHex:(NSInteger)hexValue;

+ (UIColor *)colorWithHexString:(NSString *)color;

@end
