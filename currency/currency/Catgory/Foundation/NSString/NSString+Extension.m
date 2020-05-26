//
//  NSString+Extension.m
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/3/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NSString+Extension.h"
#import "NSObject+Verification.h"

@implementation NSString (Extension)

#pragma mark - 判断是否包含某个字符串
- (BOOL)ldy_isStringContain:(NSString *)str
{
    if (![NSObject ldy_isEmpty:str]) {
        NSString * objStr = [NSString stringWithFormat:@"%@",self];
        if ([objStr rangeOfString:str].location != NSNotFound) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}

- (CGSize)ldy_sizeWithFont:(UIFont *)font size:(CGSize)size
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}

/**
 *  动态计算文字的宽高（单行）
 *  @param font 文字的字体
 *  @return 计算的宽高
 */
- (CGSize)ysl_sizeWithFont:(UIFont *)font
{
    CGSize theSize;
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    theSize = [self sizeWithAttributes:attributes];
    // 向上取整
    theSize.width = ceil(theSize.width);
    theSize.height = ceil(theSize.height);
    return theSize;
}


- (CGSize)ysl_sizeWithFont:(UIFont *)font limitSize:(CGSize)limitSize
{
    CGSize theSize;
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [self boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    theSize.width = ceil(rect.size.width);
    theSize.height = ceil(rect.size.height);
    return theSize;
}


- (CGSize)ysl_sizeWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth
{
    return [self ysl_sizeWithFont:font limitSize:CGSizeMake(limitWidth, MAXFLOAT)];
}


/**
 *  打印时间
 */
+ (NSString *)lr_stringDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

/**
 *  调整行间距
 */
- (NSAttributedString *)attributedStringAddSpace:(CGFloat)space
{
    NSString * content = [NSString stringWithFormat:@"%@", self];
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    
    return attributedStr;
}

- (NSAttributedString *)attributedStringWithFont1:(UIFont *)font isAddDeleteLine:(BOOL)isAdd
{
    NSString * showText = [NSString stringWithFormat:@"%@", self];
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:showText];
    NSDictionary * dict = @{NSFontAttributeName : font};
    [attributedStr addAttributes:dict range:NSMakeRange(0, 1)];
    
    if (isAdd) {
        NSDictionary * addDic = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                  NSStrikethroughColorAttributeName:KHEXCOLOR(kSummaryColor)};
        [attributedStr addAttributes:addDic range:NSMakeRange(0, showText.length)];
    }
    
    return attributedStr;
}

- (NSAttributedString *)attributedStringWithFont:(UIFont *)font isAddDeleteLine:(BOOL)isAdd
{
    NSString * showText = [NSString stringWithFormat:@"¥%@", self];
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:showText];
    NSDictionary * dict = @{NSFontAttributeName : font};
    [attributedStr addAttributes:dict range:NSMakeRange(0, 1)];
    
    if (isAdd) {
        NSDictionary * addDic = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                  NSStrikethroughColorAttributeName:KHEXCOLOR(kSummaryColor)};
        [attributedStr addAttributes:addDic range:NSMakeRange(0, showText.length)];
    }
    
    return attributedStr;
}

- (NSAttributedString *)attributedStringWithFont:(UIFont *)font range:(NSRange)range
{
    NSString * showText = [NSString stringWithFormat:@"¥ %@", self];
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:showText];
    NSDictionary * dict = @{NSFontAttributeName : font};
    [attributedStr addAttributes:dict range:range];
    return attributedStr;
}

/**
设置富文本：字体、内容、颜色

@param params  @[@{"font":UIFont,"text":NSString,"color":UIColor}]
*/
-(NSAttributedString *)attributeConfigForParams:(NSArray <NSDictionary <NSString *,  id> *> *)params{
    if (self.length ==0) {
        return [[NSMutableAttributedString alloc]initWithString:@""];
    }
    NSMutableAttributedString *attiString =[[NSMutableAttributedString alloc]initWithString:self];
    for (NSDictionary *param in params) {
        NSString *text = [param objectForKey:@"text"];
        if (!text) {
            continue;
        }
        NSRange range = [self rangeOfString:text];
        if (range.location == NSNotFound) {
            continue;
        }
        UIFont *textFont = [param objectForKey:@"font"];
        UIColor *textColor = [param objectForKey:@"color"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (textFont) {
            [dict setValue:textFont forKey:NSFontAttributeName];
        }
        if (textColor) {
            [dict setValue:textColor forKey:NSForegroundColorAttributeName];
        }
        if (dict.allKeys.count >0) {
            [attiString addAttributes:dict range:range];
        }
    }
    return attiString;
}


/**
 更改距离显示
 */
- (NSString *)ldy_distance
{
    NSString * distance = [NSString string];
    if ([self floatValue] > 1000) {
        distance = [NSString stringWithFormat:@"%.2fkm", [self floatValue] / 1000];
    } else {
        distance = [NSString stringWithFormat:@"%@m", self];
    }
    
    return distance;
}


/// 根据类型进行图片裁剪
/// @param cropType 图片类型
- (NSString *)imageCropByType:(ImageCropType)cropType {
    CGFloat scale = 2.0;
    CGFloat width = 120;
    CGFloat height = 120;
    switch (cropType) {
        case ImageCropTypeStyle_1:
            width = 168;
            height = 168;
            return [NSString stringWithFormat:@"%@_%.fx%.f",self,width*scale,height*scale];
        case ImageCropTypeStyle_2:
            width = 85;
            height = 85;
            return [NSString stringWithFormat:@"%@_%.fx%.f",self,width*scale,height*scale];
        case ImageCropTypeStyle_3:
            width = 118;
            height = 118;
            return [NSString stringWithFormat:@"%@_%.fx%.f",self,width*scale,height*scale];
        case ImageCropTypeStyle_4:
            width = 122;
            height = 122;
            return [NSString stringWithFormat:@"%@_%.fx%.f",self,width*scale,height*scale];
        case ImageCropTypeCategory:
            width = 75;
            height = 75;
            return [NSString stringWithFormat:@"%@_%.fx%.f",self,width*scale,height*scale];
            case ImageCropTypeStyle_5:
            width = 345;
            height = 170;
            return [NSString stringWithFormat:@"%@_%.fx%.f",self,width*scale,height*scale];
            
        default:
            return [NSString stringWithFormat:@"%@_%.fx%.f",self,width*scale,height*scale];
    }
}

- (BOOL)ldy_pureInt
{
    if ([self length] == 0) {
        return NO;
    }
    int intValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    BOOL result = [scanner scanInt:&intValue];
    return result;
}

/**
判断是否是合理手机号
*/
- (BOOL)matchRegex:(NSString *)regex
{
    //SELF MATCHES一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [predicate evaluateWithObject:self];
}

- (BOOL)isValidateMobile
{
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|(7[0[059]|6｜7｜8])|8[0-9])\\d{8}$";
    return [self matchRegex:phoneRegex];
}
@end
