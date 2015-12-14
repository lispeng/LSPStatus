//
//  LSPStatus.m
//  微视界
//
//  Created by mac on 15-10-31.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPStatus.h"
#import "LSPUser.h"
#import "MJExtension.h"
#import "LSPFigure.h"
#import "NSDate+Extension.h"
@implementation LSPStatus

//+ (instancetype)statusWithDict:(NSDictionary *)dict
//{
//    LSPStatus *status = [[self alloc] init];
//    status.idstr = dict[@"idstr"];
//    status.text = dict[@"text"];
//    status.user = [LSPUser userWithDict:dict[@"user"]];
//    
//    return status;
//}

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [LSPFigure class]};
}

- (NSString *)created_at
{
    //日期格式化处理
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
       NSDate *date = [formatter dateFromString:_created_at];
    
    NSDate *now = [NSDate date];
    //日历的处理
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = nil;
    if (date) {
        dateComponents = [calendar components:unit fromDate:date toDate:now options:0];
    }
    
    
    if([date isThisYear])
    {
        if ([date isYesterday]) {//是昨天
            
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:date];
            
        }else if ([date isToday])
        {
            if (dateComponents.hour > 1) {
                
                return [NSString stringWithFormat:@"%ld小时前",dateComponents.hour];
                
            }else if(dateComponents.minute >= 1){
                
                return [NSString stringWithFormat:@"%ld分钟前",dateComponents.minute];
            }else{
                return @"刚刚";
            }  
            
        }else{
            
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:date];
        }
        
    }else
    {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:date];
    }
    
}

- (void)setSource:(NSString *)source
{
    _source = source;
    
    if(source.length != 0)
    {
    NSRange range = NSMakeRange(0, 0);
    range.location = [source rangeOfString:@">"].location + 1;
   
    range.length = [source rangeOfString:@"</"].location - range.location;

    _source = [NSString stringWithFormat:@"来自：%@",[source substringWithRange:range]];
        
    }
}
/**
 *  判断是否为今年
 *
 */
/*
- (BOOL)isThisYear:(NSDate *)date
{
    NSCalendar *canlendar = [NSCalendar currentCalendar];
    
    NSDateComponents *canlendarComponents = [canlendar components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *currentYear = [canlendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return canlendarComponents.year == currentYear.year;
}
 */
/**
 *  判断是否为昨天
 *
 */
/*
- (BOOL)isYesterday:(NSDate *)date
{
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *currentStr = [fmt stringFromDate:date];
    
    date = [fmt dateFromString:currentStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmpt = [calendar components:unit fromDate:date toDate:now options:0];
    
    
    return cmpt.year == 0 && cmpt.month == 0 && cmpt.day == 1;
}
 */
/**
 *  判断是否为今天
 *
 */
/*
- (BOOL)isToday:(NSDate *)date
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *currentStr = [fmt stringFromDate:date];
    
    return [currentStr isEqualToString:nowStr];
}
 */
@end
