//
//  LSPStatusTool.h
//  微视界
//
//  Created by mac on 15-12-2.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPStatusTool : NSObject
/**
 *  根据请求去沙盒中查找需要加载的微博数据
 */
+ (NSArray *)statusWithParams:(NSDictionary *)params;
/**
 *  保存微博数据
 */
+ (void)saveStatus:(NSArray *)status;
@end
