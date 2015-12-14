//
//  LSPHTTPRequest.h
//  微视界
//
//  Created by mac on 15-11-12.
//  Copyright (c) 2015年 Lispeng(李斯鹏). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPHTTPRequest : NSObject

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
