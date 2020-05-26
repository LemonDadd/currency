//
//  NSString+Extension.h
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/3/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

typedef NS_ENUM(NSUInteger, ImageCropType) {
    //两小图
    ImageCropTypeStyle_1 = 1,
    //三小图
    ImageCropTypeStyle_2,
    //列表
    ImageCropTypeStyle_3,
    //多商品滑动
    ImageCropTypeStyle_4,
    //分类
    ImageCropTypeCategory,
    //单图
    ImageCropTypeStyle_5
};

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

#pragma mark - 判断是否包含某个字符串
- (BOOL)ldy_isStringContain:(NSString *)str;

/**
 计算字符串的尺寸
 
 @param font 字体
 @param size 大小
 @return 字符串的尺寸
 */
- (CGSize)ldy_sizeWithFont:(UIFont *)font size:(CGSize)size;

/**
 *  动态计算文字的宽高（单行）
 *
 *  @param font 文字的字体
 *
 *  @return 计算的宽高
 */
- (CGSize)ysl_sizeWithFont:(UIFont *)font;

/**
 *  动态计算文字的宽高（多行）
 *
 *  @param font 文字的字体
 *  @param limitSize 限制的范围
 *
 *  @return 计算的宽高
 */
- (CGSize)ysl_sizeWithFont:(UIFont *)font limitSize:(CGSize)limitSize;

/**
 *  动态计算文字的宽高（多行）
 *
 *  @param font 文字的字体
 *  @param limitWidth 限制宽度 ，高度不限制
 *
 *  @return 计算的宽高
 */
- (CGSize)ysl_sizeWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth;

/**
 *  打印时间
 */
+ (NSString *)lr_stringDate;

/**
 *  调整行间距
 */
- (NSAttributedString *)attributedStringAddSpace:(CGFloat)space;

/**
 调整价格显示

 @param font ¥ 大小
 */
- (NSAttributedString *)attributedStringWithFont:(UIFont *)font isAddDeleteLine:(BOOL)isAdd;

- (NSAttributedString *)attributedStringWithFont1:(UIFont *)font isAddDeleteLine:(BOOL)isAdd;

- (NSAttributedString *)attributedStringWithFont:(UIFont *)font range:(NSRange)range;

/**
设置富文本：字体、内容、颜色

@param params  @[@{"font":UIFont,"text":NSString,"color":UIColor}]
*/
-(NSAttributedString *)attributeConfigForParams:(NSArray <NSDictionary <NSString *,  id> *> *)params;

/**
 更改距离显示
 */
- (NSString *)ldy_distance;

/// 根据类型进行图片裁剪
/// @param cropType 图片类型
- (NSString *)imageCropByType:(ImageCropType)cropType;
// 判断一个字符串是int数字
- (BOOL)ldy_pureInt;

/**
判断是否是合理手机号
*/
- (BOOL)matchRegex:(NSString *)regex;

- (BOOL)isValidateMobile;
 

@end

NS_ASSUME_NONNULL_END
