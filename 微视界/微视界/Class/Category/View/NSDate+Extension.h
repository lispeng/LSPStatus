//
//  NSDate+Extension.h
//  微视界
//
//  Created by mac on 15-11-4.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断是否为今年
 *
 */
- (BOOL)isThisYear;
/**
 *  判断是否为昨天
 *
 */
- (BOOL)isYesterday;
/**
 *  判断是否为今天
 *
 */
- (BOOL)isToday;

@end
