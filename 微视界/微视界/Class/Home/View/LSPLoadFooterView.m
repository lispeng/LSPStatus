//
//  LSPLoadFooterView.m
//  微视界
//
//  Created by mac on 15-11-2.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPLoadFooterView.h"

@implementation LSPLoadFooterView

+ (instancetype)loadFooterView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LSPLoadFooterView" owner:nil options:nil] lastObject];
}
@end
