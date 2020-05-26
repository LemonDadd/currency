//
//  NSObject+Regex.m
//  customer_rebuild
//  正则表达式
//  Created by 全球蛙 on 2019/3/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NSObject+Regex.h"

@implementation NSObject (Regex)

#pragma mark - 正则验证 - 银行卡
+ (BOOL)isMathBankCard:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length > 0) {
        NSString * regex = @"^([0-9]{16}|[0-9]{18}|[0-9]{19})$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        flag = [predicate evaluateWithObject:value];
    }
    
    return flag;
}

#pragma mark - 正则验证 - 手机号码
+ (BOOL)isMathMobile:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length == 11) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(198)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(166)|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(199)|(153)|(177)|(199)|(18[0,1,9]))\\d{8}$";
        /**
         * 其他号段正则表达式
         */
        NSString *CO_NUM = @"^((17[0-9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:value];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:value];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:value];
        NSPredicate *pred4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CO_NUM];
        BOOL isMatch4 = [pred4 evaluateWithObject:value];
        
        if (isMatch1 || isMatch2 || isMatch3 || isMatch4) {
            flag = YES;
        }else{
            flag =  NO;
        }
    }
    
    return flag;
}

#pragma mark - 正则验证 - 判断首字符是否为字母
+ (BOOL)isMathFirstCharacterLetter:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length > 0) {
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        flag =[predicate evaluateWithObject:value];
    }
    
    return flag;
}

#pragma mark - 正则验证 - 只能输入中文和字母
+ (BOOL)isMathChineseOrLetters:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length > 0) {
        NSString *regex =@"^[a-zA-Z\u4e00-\u9fa5\\s]+$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        flag =[predicate evaluateWithObject:value];
    }
    
    return flag;
}

#pragma mark - 正则验证 - 验证qq号码
+ (BOOL)isMathQQ:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length > 0) {
        NSString *regex = @"[1-9][0-9]\{4,10}";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        flag =[predicate evaluateWithObject:value];
    }
    
    return flag;
}

#pragma mark - 正则验证 - 是否是正整数
+ (BOOL)isMathPositiveInteger:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length > 0) {
        NSString *regex =@"^[0-9]*$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        flag =[predicate evaluateWithObject:value];
    }
    
    return flag;
}

#pragma mark - 正则验证 - 只允许输入字母和数字
+ (BOOL)isMathLettersOrNumbers:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length > 0) {
        NSString *regex=@"^[A-Za-z0-9]{1,45}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        flag =[predicate evaluateWithObject:value];
    }
    
    return flag;
}

#pragma mark - 正则验证 - 只允许输入字母和数字 长度范围最小是1，最大默认是100
+ (BOOL)isMathLettersOrNumbers:(NSString *)value andFrom:(int)from andTo:(int)to
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length > 0) {
        from = from<=0?1:from;
        to = to<from?100:to;
        NSString *regex=[NSString stringWithFormat:@"^[a-zA-Z0-9]{%d,%d}",from,to];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        flag =[predicate evaluateWithObject:value];
    }
    
    return flag;
}

#pragma mark - 正则验证 -邮箱
+ (BOOL)isMathEmail:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length > 0) {
        NSString *regex=@"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        flag =[predicate evaluateWithObject:value];
    }
    
    return flag;
}

#pragma mark - 正则验证 - 只允许输入中文、字母和数字
+ (BOOL)isMathChineseOrLettersAndNumbers:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && value.length > 0) {
        NSString *regex = @"^[a-zA-Z0-9\u4e00-\u9fa5]+$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        flag =[predicate evaluateWithObject:value];
    }
    
    return flag;
}

#pragma mark - 正则验证 - 身份证号
+ (BOOL)isMathIDCard:(NSString *)sPaperId
{
    sPaperId = [sPaperId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //判断位数
    if (sPaperId.length != 15 && sPaperId.length != 18) {
        return NO;
    }
    if ([sPaperId rangeOfString:@"x"].length > 0) {//不能有小写的x
        return NO;
    }
    
    NSString *carid = sPaperId;
    long lSumQT = 0 ;
    //加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //校验码
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'};
    //将15位身份证号转换为18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    if (sPaperId.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p =0;
        //        const char *pid = [mString UTF8String];
        for (int i =0; i<17; i++)
        {
            NSString * s = [mString substringWithRange:NSMakeRange(i, 1)];
            p += [s intValue] * R[i];
            //            p += (long)(pid-48) * R;//
            
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断年月日是否有效
    //年份
    int strYear = [[NSObject getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[NSObject getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[NSObject getStringWithRange:carid Value1:12 Value2:2] intValue];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        return NO;
    }
    carid = [carid uppercaseString];
    const char *PaperId = [carid UTF8String];
    //检验长度
    if (18!=strlen(PaperId)) {
        return NO;
    }
    //校验数字
    NSString * lst = [carid substringFromIndex:carid.length-1];
    char di = [carid characterAtIndex:carid.length-1];
    
    if (!isdigit(di)) {
        if ([lst isEqualToString:@"X"]) {
        }else{
            return NO;
        }
    }
    //验证最末的校验码
    lSumQT = 0;
    for (int i = 0; i<17; i++){
        NSString * s = [carid substringWithRange:NSMakeRange(i, 1)];
        lSumQT += [s intValue] * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17]) {
        return NO;
    }
    
    return YES;
}

#pragma mark ---- 根据范围截取字符串
/**
 *  根据范围截取字符串
 *
 *  @param str 被截取的字符串
 *  @param v1  开始位置
 *  @param v2  结束位置
 *
 *  @return 截取好的字符串
 */
+ (NSString *)getStringWithRange:(NSString *)str Value1:(int)v1 Value2:(int)v2
{
    NSString * sub = [str substringWithRange:NSMakeRange(v1, v2)];
    
    return sub;
}

#pragma mark ---- 判断是否是URL
+ (BOOL)isMathURL:(NSString *)value
{
    BOOL flag = NO;
    if (![NSObject ldy_isEmpty:value] && [value length] > 0) {
        NSString *regex=@"^(http://|https://)?((?:[A-Za-z0-9]+-[A-Za-z0-9]+|[A-Za-z0-9]+)\\.)+([A-Za-z]+)[/\?\\:]?.*$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        flag =[predicate evaluateWithObject:value];
    }
    return flag;
}

@end
