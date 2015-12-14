//
//  LSPUser.h
//  微视界
//
//  Created by mac on 15-10-31.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HWUserVerifiedTypeNone = -1, // 没有任何认证
    
    HWUserVerifiedPersonal = 0,  // 个人认证
    
    HWUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    HWUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    HWUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    HWUserVerifiedDaren = 220 // 微博达人
} HWUserVerifiedType;

@interface LSPUser : NSObject
/**
 *  用户UID
 */
@property (copy,nonatomic) NSString *idstr;
/**
 *  用户
 */
@property (copy,nonatomic) NSString *name;
/**
 *  用户头像地址
 */
@property (copy,nonatomic) NSString *profile_image_url;

/**
 *  会员类型
 */
@property (assign,nonatomic) int mbtype;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
@property (assign,nonatomic,getter=isVip) BOOL vip;
/**
 *  微博头像的认证类型
 */
@property (nonatomic, assign) HWUserVerifiedType verified_type;
//+ (instancetype)userWithDict:(NSDictionary *)dict;
@end
