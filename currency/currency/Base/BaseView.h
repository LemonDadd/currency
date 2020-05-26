//
//  BaseView.h
//  customer_rebuild
//
//  Created by quanqiuwa on 2019/3/1.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ViewClickBlcok)(void);
typedef void (^BaseViewSelectedBlock)(id param);

@interface BaseView : UIView

@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIImageView * moreImageView;
@property (nonatomic, copy) ViewClickBlcok block;
@property (nonatomic, copy) BaseViewSelectedBlock selectedBlock;

/**
 空白View + 点击事件
 */
- (instancetype)initWithBlock:(ViewClickBlcok)block;
- (instancetype)initWithParamBlock:(BaseViewSelectedBlock)block;

/**
 view (title + image)
 */
- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font block:(ViewClickBlcok)block;
- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font moreImage:(NSString *)moreImage block:(ViewClickBlcok)block;
- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor moreImage:(NSString *)moreImage block:(ViewClickBlcok)block;

- (void)changeMoreImage:(NSString *)moreImage;

- (UIViewController *)viewController;

+ (NSMutableAttributedString *)attStringRange:(NSString *)allTitle rangeTitle:(NSString *)rangeTitle allColor:(UIColor *)allColor rangeColor:(UIColor *)rangeColor allFontSize:(UIFont *)allSize rangeFontSize:(UIFont *)rangeSize;


/**
 富文本+调整行间距
 */
+ (NSMutableAttributedString *)attStringRange:(NSString *)allTitle rangeTitle:(NSString *)rangeTitle allColor:(UIColor *)allColor rangeColor:(UIColor *)rangeColor allFontSize:(UIFont *)allSize rangeFontSize:(UIFont *)rangeSize space:(CGFloat)space;

/**
 添加圆角
 */
- (void)addTopCircularBeadWithHeight:(CGFloat)height;
- (void)addBottomCornerWithHeight:(CGFloat)height;
- (void)addLeftCornerWithHeight:(CGFloat)height;
- (void)addRightCornerWithHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
