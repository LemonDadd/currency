//
//  NSDate+Extension.h
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/3/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+JKUtilities.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)

/// 获取相对于系统时区的时间
+ (NSDate *)getSystemDate;

/**
 时间比较
 */
+ (int)compareDate:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 当前时间
 */
+ (NSString *)getCurrentTime;

/**
 是否是今天
 */
- (BOOL)isToday;

/**
 是否是今年
 */
- (BOOL)isThisYear;

/**
 时分秒 转 date (今天)
 */
+ (NSDate *)timeToTodayDate:(NSString *)time;

/**
 date 转 string
 */
- (NSString *)timeDateToStringWithFormat:(NSString *)format;
- (NSString *)timeDateToString;

+ (NSDate *)timeStringToDate:(NSString *)dateStr format:(NSString *)format;
+ (NSDate *)timeStringToDate:(NSString *)dateStr;

/**
 获取是星期几
 */
- (NSString *)getWeekDay;

/**
 *  根据时间差返回天/时/分/秒时间数组
 *
 *  @param timeDistance 时间差（单位秒）
 *
 *  @return 返回天，时，分，秒的数组，如@[@“05”,@“10”,@“30”,@“50”],代表05天10时30分50秒
 */
+ (NSArray *)timeArrayWithTimeDistance:(long)timeDistance;

/**
 *  根据时间差返回时/分/秒数组
 *
 *  @param timeDistance 时间差（单位秒）
 *
 *  @return 返回时，分，秒的数组，如@[@“10”,@“30”,@“50”],代表10时30分50秒
 */
+ (NSArray *)secTimeArrayWithTimeDistance:(long)timeDistance;

/**
 *  计算两个日期的时间差
 *
 *  @param date        格式为@"yyyy-MM-dd HH:mm:ss"的字符串
 *  @param anotherDate 格式为@"yyyy-MM-dd HH:mm:ss"的字符串
 *
 *  @return 时间差（单位秒）
 */
+ (long)timeDistanceWithDate:(NSString *)date anotherDate:(NSString *)anotherDate;

/**
 *  是否为同一天
 */
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

@end

NS_ASSUME_NONNULL_END
