//
//  LSPAccount.h
//  微视界
//
//  Created by mac on 15-10-30.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPAccount : NSObject<NSCoding>

/*
 "access_token" = "2.005pdTGGBVHM_E0c549487890ZF5bL";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5592519622;

 */
@property (copy,nonatomic) NSString *access_token;
@property (copy,nonatomic) NSNumber *expires_in;
@property (copy,nonatomic) NSString *uid;
@property (copy,nonatomic) NSDate *create_time;
@property (copy,nonatomic) NSString *name;
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
