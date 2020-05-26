//
//  NSObject+Regex.h
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/3/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Regex)

/**
 *  正则验证 - 银行卡
 *
 *  @param value 验证的值
 *
 *  @return YES or NO
 */
+ (BOOL)isMathBankCard:(NSString *)value;

/**
 *  正则验证 - 手机号码
 *
 *  @param value 验证的值
 *
 *  @return YES or NO
 */
+ (BOOL)isMathMobile:(NSString *)value;

/**
 *  正则验证 - 判断首字符是否为字母
 *
 *  @param value 验证的值
 *
 *  @return YES or NO
 */
+ (BOOL)isMathFirstCharacterLetter:(NSString *)value;

/**
 *  正则验证 - 只能输入中文和字母
 *
 *  @param value 验证的值
 *
 *  @return YES or NO
 */
+ (BOOL)isMathChineseOrLetters:(NSString *)value;

/**
 *  正则验证 - 验证qq号码
 *
 *  @param value 验证的值
 *
 *  @return YES or NO
 */
+ (BOOL)isMathQQ:(NSString *)value;

/**
 *  正则验证 - 是否是正整数
 *
 *  @param value 验证的值
 *
 *  @return YES or NO
 */
+ (BOOL)isMathPositiveInteger:(NSString *)value;

/**
 *  正则验证 - 只允许输入字母和数字
 *
 *  @param value 验证的值
 *
 *  @return YES or NO
 */
+ (BOOL)isMathLettersOrNumbers:(NSString *)value;

/**
 *  正则验证 - 只允许输入字母和数字 长度范围最小是1，最大默认是100
 *
 *  @param value 验证的值
 *  @param from  长度范围开始，最小是1
 *  @param to    长度范围结束，最大默认是100
 *
 *  @return YES or NO
 */
+ (BOOL)isMathLettersOrNumbers:(NSString *)value andFrom:(int)from andTo:(int)to;

/**
 *  正则验证 - 邮箱
 *
 *  @param value 验证的值
 *
 *  @return YES or NO
 */
+ (BOOL)isMathEmail:(NSString *)value;

/**
 *  正则验证 - 只允许输入中文、字母和数字
 *
 *  @param value 验证的值
 *
 *  @return YES or NO
 */
+ (BOOL)isMathChineseOrLettersAndNumbers:(NSString *)value;

/**
 *  身份证校验
 *
 *  @param sPaperId 身份证号字符串
 *
 *  @return 是否校验通过
 */
+ (BOOL)isMathIDCard:(NSString *)sPaperId;

/**
 *  判断是否是URL
 *  @return Yes 是数组 No 不是数组
 */
+ (BOOL)isMathURL:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
