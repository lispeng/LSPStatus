//
//  LSPUser.m
//  微视界
//
//  Created by mac on 15-10-31.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPUser.h"

@implementation LSPUser
//+ (instancetype)userWithDict:(NSDictionary *)dict
//{
//    LSPUser *user = [[self alloc] init];
//    
//    user.idstr = dict[@"idstr"];
//    user.name = dict[@"name"];
//    user.profile_image_url = dict[@"profile_image_url"];
//    
//    return user;
//}

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}
@end
