//
//  BaseView.m
//  customer_rebuild
//
//  Created by quanqiuwa on 2019/3/1.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()

@end

@implementation BaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (instancetype)initWithBlock:(ViewClickBlcok)block
{
    if (self = [super init]) {
        self.block = block;
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSelf)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (instancetype)initWithParamBlock:(BaseViewSelectedBlock)block
{
    if (self = [super init]) {
        self.selectedBlock = block;
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSelf)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font block:(ViewClickBlcok)block
{
    return [self initWithTitle:title font:font moreImage:@"shop_icon_pull_right" block:block];
}

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font moreImage:(NSString *)moreImage block:(ViewClickBlcok)block
{
    return [self initWithTitle:title font:font titleColor:KHEXCOLOR(kTitleColor) moreImage:moreImage block:block];
}

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor moreImage:(NSString *)moreImage block:(ViewClickBlcok)block
{
    self = [self initWithBlock:block];
    if (self) {
        _contentLabel = [UILabel new];
        _contentLabel.text = title;
        _contentLabel.font = font;
        _contentLabel.textColor = titleColor;
        [self addSubview:_contentLabel];
        
        _moreImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:moreImage]];
        [self addSubview:_moreImageView];
        [_moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self);
        }];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.moreImageView.mas_left).offset(kWidth(-5));
            make.centerY.equalTo(self.moreImageView);
            make.left.equalTo(self);
            make.top.left.equalTo(self);
        }];
        
        [_moreImageView setContentHuggingPriority:UILayoutPriorityRequired
                                  forAxis:UILayoutConstraintAxisHorizontal];
        [_contentLabel setContentHuggingPriority:UILayoutPriorityDefaultLow
                                  forAxis:UILayoutConstraintAxisHorizontal];
    }
    
    return self;
}

#pragma mark ---- Action
- (void)didClickSelf
{
    if (self.block) {
        self.block();
    }
    
    if (self.selectedBlock) {
        self.selectedBlock(self);
    }
}

- (void)changeMoreImage:(NSString *)moreImage
{
    _moreImageView.image = [UIImage imageNamed:moreImage];
}

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/**
 *  创建部分颜色不一样的富文本字符串
 *
 *  @param allTitle   全部文字
 *  @param rangeTitle 部分不一样的文字
 *  @param allColor   全体的颜色
 *  @param rangeColor 部分不同的颜色
 *  @param allSize    全体的字体
 *  @param rangeSize  部分不同的字体
 *
 *  @return 富文本字符串
 */
+ (NSMutableAttributedString *)attStringRange:(NSString *)allTitle rangeTitle:(NSString *)rangeTitle allColor:(UIColor *)allColor rangeColor:(UIColor *)rangeColor allFontSize:(UIFont *)allSize rangeFontSize:(UIFont *)rangeSize
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allTitle];
    //颜色
    [str addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, allTitle.length)];
    [str addAttribute:NSForegroundColorAttributeName value:rangeColor range:[allTitle rangeOfString:rangeTitle]];
    //字体
    [str addAttribute:NSFontAttributeName value:allSize range:NSMakeRange(0, allTitle.length)];
    [str addAttribute:NSFontAttributeName value:rangeSize range:[allTitle rangeOfString:rangeTitle]];
    
    return str;
}

+ (NSMutableAttributedString *)attStringRange:(NSString *)allTitle rangeTitle:(NSString *)rangeTitle allColor:(UIColor *)allColor rangeColor:(UIColor *)rangeColor allFontSize:(UIFont *)allSize rangeFontSize:(UIFont *)rangeSize space:(CGFloat)space
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allTitle];
    //颜色
    [str addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, allTitle.length)];
    [str addAttribute:NSForegroundColorAttributeName value:rangeColor range:[allTitle rangeOfString:rangeTitle]];
    //字体
    [str addAttribute:NSFontAttributeName value:allSize range:NSMakeRange(0, allTitle.length)];
    [str addAttribute:NSFontAttributeName value:rangeSize range:[allTitle rangeOfString:rangeTitle]];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [allTitle length])];
    
    return str;
}


- (NSAttributedString *)attributedString:(NSString *)str
                                   Color:(UIColor *)color
                                    Font:(UIFont *)font
                         isAddDeleteLine:(BOOL)isAdd
{
    NSString * showText = [NSString stringWithFormat:@"¥%@", str];
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:showText];
    NSDictionary * dict = @{NSFontAttributeName : font};
    [attributedStr addAttributes:dict range:NSMakeRange(0, 1)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, showText.length)];
    
    if (isAdd) {
        NSDictionary * addDic = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                  NSStrikethroughColorAttributeName:KHEXCOLOR(kPlaceholderColor)};
        [attributedStr addAttributes:addDic range:NSMakeRange(0, showText.length)];
    }
    
    return attributedStr;
}


/**
 添加顶部圆角
 */
- (void)addTopCircularBeadWithHeight:(CGFloat)height
{
    CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, height);
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12, 0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 添加底部圆角
 */
- (void)addBottomCornerWithHeight:(CGFloat)height
{
    CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, height);
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(12, 0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)addLeftCornerWithHeight:(CGFloat)height{
    CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, height);
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(12, 0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)addRightCornerWithHeight:(CGFloat)height{
    CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, height);
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(12, 0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
