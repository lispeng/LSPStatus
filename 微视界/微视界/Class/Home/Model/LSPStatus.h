//
//  LSPStatus.h
//  微视界
//
//  Created by mac on 15-10-31.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSPUser;
@interface LSPStatus : NSObject
/**
 *  微薄的ID
 */
@property (copy,nonatomic) NSString *idstr;
/**
 *  微博内容
 */
@property (copy,nonatomic) NSString *text;
/**
 *  微博作者（用户）
 */
@property (strong,nonatomic) LSPUser *user;

/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

@property (strong,nonatomic) NSArray *pic_urls;

@property (strong,nonatomic) LSPStatus *retweeted_status;

/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;


//+ (instancetype)statusWithDict:(NSDictionary *)dict;
@end
