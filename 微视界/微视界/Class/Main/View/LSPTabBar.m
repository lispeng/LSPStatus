//
//  LSPTabBar.m
//  微视界
//
//  Created by mac on 15-10-29.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPTabBar.h"
#import "UIView+Extension.h"
@interface LSPTabBar()
@property (nonatomic,strong) UIButton *plusBtn;

@end
@implementation LSPTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;
       
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self plusBtnPosition];
    
    [self tabBarPosition];
}

- (void)plusBtnPosition
{
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
}

- (void)tabBarPosition
{
    CGFloat tabBarWidth = self.width / 5.0;
    NSInteger index = 0;
    
    for (UIView *childView in self.subviews) {
        
        Class class = NSClassFromString(@"UITabBarButton");
        if ([childView isKindOfClass:class]) {
            
            childView.width = tabBarWidth;
            childView.x = index * tabBarWidth;
            index ++;
            
            if (index == 2) {
                index ++;
            }
        }
        
    }
    
}

- (void)plusBtnClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarClicked:)]) {
        
        [self.delegate tabBarClicked:self];
    }
}
@end
