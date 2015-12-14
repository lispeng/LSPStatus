//
//  LSPComposeTabBarButton.m
//  微视界
//
//  Created by mac on 15-11-8.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPComposeTabBarButton.h"

@implementation LSPComposeTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end
