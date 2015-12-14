//
//  LSPAccount.m
//  微视界
//
//  Created by mac on 15-10-30.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPAccount.h"

@implementation LSPAccount

- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [enCoder encodeObject:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.create_time forKey:@"create_time"];
    [enCoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)deDecoder
{
    if (self = [super init]) {
        
    self.access_token = [deDecoder decodeObjectForKey:@"access_token"];
        
    self.expires_in = [deDecoder decodeObjectForKey:@"expires_in"];
        
    self.uid = [deDecoder decodeObjectForKey:@"uid"];
        
    self.create_time = [deDecoder decodeObjectForKey:@"create_time"];
        
    self.name = [deDecoder decodeObjectForKey:@"name"];
        
       
    }
    
    
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict;
{
    LSPAccount *account = [[LSPAccount alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    account.create_time = [NSDate date];
    return account;
}
@end
