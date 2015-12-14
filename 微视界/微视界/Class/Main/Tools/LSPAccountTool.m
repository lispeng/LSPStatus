//
//  LSPAccountTool.m
//  微视界
//
//  Created by mac on 15-10-31.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPAccountTool.h"

#define LSPAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation LSPAccountTool

+ (void)saveAccount:(LSPAccount *)account
{
    
    [NSKeyedArchiver archiveRootObject:account toFile:LSPAccountPath];
    
    
}


+ (LSPAccount *)account
{
    
    LSPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:LSPAccountPath];
    
    NSDate *lastDate = account.create_time;
    
    long long timeInterval = [account.expires_in longLongValue];
    
    NSDate *nowDate = [NSDate date];
    
   NSDate *expireDate = [lastDate dateByAddingTimeInterval:timeInterval];
    NSComparisonResult result = [expireDate compare:nowDate];
    
    if (result != NSOrderedDescending) {
        
        return nil;
    }
    
    return account;
}



@end
