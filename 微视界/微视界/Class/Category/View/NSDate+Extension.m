//
//  NSDate+Extension.m
//  微视界
//
//  Created by mac on 15-11-4.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
/**
 *  判断是否为今年
 *
 */
- (BOOL)isThisYear
{
    NSCalendar *canlendar = [NSCalendar currentCalendar];
    
    NSDateComponents *canlendarComponents = [canlendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *currentYear = [canlendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return canlendarComponents.year == currentYear.year;
}
/**
 *  判断是否为昨天
 *
 */
- (BOOL)isYesterday
{
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *currentStr = [fmt stringFromDate:self];
    
    NSDate *date = [fmt dateFromString:currentStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmpt = [calendar components:unit fromDate:date toDate:now options:0];
    
    
    return cmpt.year == 0 && cmpt.month == 0 && cmpt.day == 1;
}
/**
 *  判断是否为今天
 *
 */
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *currentStr = [fmt stringFromDate:self];
    
    return [currentStr isEqualToString:nowStr];
}

@end
