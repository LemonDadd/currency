//
//  NSObject+Verification.m
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/3/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NSObject+Verification.h"

@implementation NSObject (Verification)

#pragma mark ---- 判断字符串是否为空
+ (BOOL)ldy_isEmpty:(id)obj
{
    if (obj==nil || [obj isEqual:[NSNull null]]) return YES;
    
    if ([obj isKindOfClass:[NSString class]]) {
        if ([obj isEqualToString:@""]) return YES;
        
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [obj stringByTrimmingCharactersInSet:set];
        if ([trimedString length]==0) return YES;
    }
    
    return NO;
}

#pragma mark ---- 判断数字是否大于0
+ (BOOL)ldy_isNumberBigZero:(id)obj
{
    if ([NSObject ldy_isEmpty:obj]) return NO;
    
    if ([obj isKindOfClass:[NSNumber class]]) {
        if ([obj intValue]>0) return YES;
    }
    
    return NO;
}

#pragma mark ---- 返回非nil和NULL字符串
+ (NSString *)ldy_returnNoEmpty:(id)obj {
    NSString *result = @"";
    if (obj!=nil && ![obj isEqual:[NSNull null]]) {
        result = [NSString stringWithFormat:@"%@", obj];
    }
    return result;
}

#pragma mark ---- 返回非nil和NSNULL字符串，如果为空有传默认值，就返回默认值。没有就返回@“”
+ (NSString *)ldy_toString:(id)value defaultStr:(NSString *)defaultStr
{
    NSString *returnString = @"";
    if (value != nil && ![value isKindOfClass:[NSNull class]] && ![value isEqual:[NSNull null]]) {
        NSString *val = [NSString stringWithFormat:@"%@",value];
        if ([NSObject ldy_isNonEmptyString:val]) {
            returnString = val;
        }
    }
    if ([returnString isEqualToString:@""] && [NSObject ldy_isNonEmptyString:defaultStr]) {
        returnString = [NSString stringWithFormat:@"%@",defaultStr];
    }
    
    return returnString;
}

#pragma mark ---- 是否能拨打电话发信息
+ (BOOL)ldy_isCanCallPhomeOrSendSms
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]) {
        return NO;
    }
    
    return YES;
}

#pragma mark ---- URL解码
- (NSString*)ldy_urlDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)(NSString *)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8));
    return result;
}

#pragma mark ---- 是否是非空字符串
+ (BOOL)ldy_isNonEmptyString:(id)obj
{
    //是否字符串
    if (![obj isKindOfClass:[NSString class]]) return NO;
    //字符串是否为空
    if ([NSObject ldy_isEmpty:obj]) return NO;
    //非空字符串
    return YES;
}

#pragma mark ---- 是否为字典类型
+ (BOOL)ldy_isDictionary:(id)obj {
    //是否nil或NULL
    if (self==nil || [self isEqual:[NSNull null]]) return NO;
    //是否字典类型
    if (![obj isKindOfClass:[NSDictionary class]]) return NO;
    
    if (((NSDictionary *)obj).count == 0) return NO;
    
    return YES;
}

#pragma mark ---- 返回非nil和NSNULL字符串
- (NSString *)ldy_toString
{
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return [NSString stringWithFormat:@"%@",self];
    } else {
        return @"";
    }
}

#pragma mark ---- 返回非nil和NSNULL字符串
- (NSString *)ldy_toString:(NSString *)defaulrStr
{
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return [NSString stringWithFormat:@"%@",self];
    } else {
        return defaulrStr;
    }
}

#pragma mark ---- 返回NSInteger类型数字 只判断 NSNumber 和 NSSString 其他返回-1
- (int)ldy_toIntValue
{
    if (([self isKindOfClass:[NSNumber class]]
        || [self isKindOfClass:[NSString class]])
        && self != nil
        && ![self isKindOfClass:[NSNull class]]) {
        return [[NSString stringWithFormat:@"%@",self] intValue];
    } else {
        return -1;
    }
}

@end
