//
//  NSDate+Extension.m
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/3/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/*
 参考资料: https://www.jianshu.com/p/5f4e7fabcc02
 初步猜想, 这是因为, 在格式化的时候, NSDateFormatter实例对象, 会根据其当前的时区, 来自动校正为相对于GMT的时间, 因为我把时间已经校正了, 但是NSDate实例默认的时间是相对于GMT的, 所以 NSDateFormatter实例就根据当前的时区自动校正了, 这样就相当于校正了两次, 所以结果就会多了8个小时, 导致了这个错误;
 */
/// 获取相对于系统时区的时间
+ (NSDate *)getSystemDate {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [zone secondsFromGMTForDate:date];
    return [date dateByAddingTimeInterval:interval];
}

#pragma mark ---- 日期比较
+ (int)compareDate:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString * oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString * anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate * dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate * dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //oneDay日期大于anotherDay
        return 1;
    } else if (result == NSOrderedAscending) {
        //oneDay日期小于anotherDay
        return -1;
    }
    //日期相同
    return 0;
}

#pragma mark - 获取当前时间
+ (NSString *)getCurrentTime
{
    NSDateFormatter * formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [NSDate date];
    NSString * dateStr = [formate stringFromDate:date];
    
    return dateStr;
}

/**
 是否是今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

/**
 是否是今年
 */
- (BOOL)isThisYear

{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

+ (NSDate *)timeToTodayDate:(NSString *)time
{
    NSDate * todayDate = [NSDate getSystemDate];
    NSString * todayStr = [todayDate timeDateToStringWithFormat:@"yyyy-MM-dd"];
    NSString * timeStr = [NSString stringWithFormat:@"%@ %@", todayStr, time];
    
    return [self timeStringToDate:timeStr];
}

/**
 date 转 string
 */
- (NSString *)timeDateToStringWithFormat:(NSString *)format
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormat setDateFormat:format];
    NSString * string = [dateFormat stringFromDate:self];
    
    return string;
}

- (NSString *)timeDateToString
{
    return [self timeDateToStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)timeStringToDate:(NSString *)dateStr format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate * datestr = [dateFormatter dateFromString:dateStr];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [zone secondsFromGMTForDate:datestr];
    return [datestr dateByAddingTimeInterval:interval];
}

+ (NSDate *)timeStringToDate:(NSString *)dateStr
{
    return [self timeStringToDate:dateStr format:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)getWeekDay
{
    NSString * weekStr = [NSString string];
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2]; // Sunday == 1, Saturday == 7
    NSUInteger adjustedWeekdayOrdinal = [gregorian ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSWeekCalendarUnit forDate:self];
    switch (adjustedWeekdayOrdinal) {
        case 1:
            weekStr = @"星期一";
            break;
        case 2:
            weekStr = @"星期二";
            break;
        case 3:
            weekStr = @"星期三";
            break;
        case 4:
            weekStr = @"星期四";
            break;
        case 5:
            weekStr = @"星期五";
            break;
        case 6:
            weekStr = @"星期六";
            break;
        case 7:
            weekStr = @"星期日";
            break;
        default:
            break;
    }
    
    return weekStr;
}

/**
 *  根据时间差返回天/时/分/秒时间数组
 *
 *  @param timeDistance 时间差（单位秒）
 *
 *  @return 返回天，时，分，秒的数组，如@[@“05”,@“10”,@“30”,@“50”],代表05天10时30分50秒
 */
+ (NSArray *)timeArrayWithTimeDistance:(long)timeDistance {
    NSString *day = [NSString stringWithFormat:@"%02ld",timeDistance/(3600*24)];
    NSString *hour = [NSString stringWithFormat:@"%02ld",timeDistance/3600%24];
    NSString *minute = [NSString stringWithFormat:@"%02ld",timeDistance/60%60];
    NSString *second = [NSString stringWithFormat:@"%02ld",timeDistance%60];
    return @[day,hour,minute,second];
}

/**
 *  根据时间差返回时/分/秒数组
 *
 *  @param timeDistance 时间差（单位秒）
 *
 *  @return 返回时，分，秒的数组，如@[@“10”,@“30”,@“50”],代表10时30分50秒
 */
+ (NSArray *)secTimeArrayWithTimeDistance:(long)timeDistance {
    NSString *hour = [NSString stringWithFormat:@"%02ld",timeDistance/3600];
    NSString *minute = [NSString stringWithFormat:@"%02ld",timeDistance/60%60];
    NSString *second = [NSString stringWithFormat:@"%02ld",timeDistance%60];
    return @[hour,minute,second];
}

/**
 *  计算两个日期的时间差
 *
 *  @param date        格式为@"yyyy-MM-dd HH:mm:ss"的字符串
 *  @param anotherDate 格式为@"yyyy-MM-dd HH:mm:ss"的字符串
 *
 *  @return 时间差（单位秒）
 */
+ (long)timeDistanceWithDate:(NSString *)date anotherDate:(NSString *)anotherDate{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    long timeDistance = (long)[[inputFormatter dateFromString:date] timeIntervalSinceDate:[inputFormatter dateFromString:anotherDate]];
    return timeDistance;
}

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    [comp1 setTimeZone:[NSTimeZone localTimeZone]];
    [comp2 setTimeZone:[NSTimeZone localTimeZone]];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

@end
