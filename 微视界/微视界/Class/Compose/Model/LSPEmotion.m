//
//  LSPEmotion.m
//  微视界
//
//  Created by mac on 15-11-9.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPEmotion.h"
@interface LSPEmotion()<NSCoding>

@end
@implementation LSPEmotion

- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.code forKey:@"code"];
    [enCoder encodeObject:self.png forKey:@"png"];
    [enCoder encodeObject:self.chs forKey:@"chs"];
}

- (id)initWithCoder:(NSCoder *)deCoder
{
    if (self = [super init]) {
        
        self.code = [deCoder decodeObjectForKey:@"code"];
        self.chs = [deCoder decodeObjectForKey:@"chs"];
        self.png = [deCoder decodeObjectForKey:@"png"];
    }
    return self;
}

- (BOOL)isEqual:(LSPEmotion *)object
{
    return [self.chs isEqualToString:object.chs] || [self.code isEqualToString:object.chs];
}
@end
