//
//  LSPEmotionTabBar.m
//  微视界
//
//  Created by mac on 15-11-7.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPEmotionTabBar.h"
#import "UIView+Extension.h"
#import "LSPComposeTabBarButton.h"

@interface LSPEmotionTabBar()
@property (nonatomic,weak) LSPComposeTabBarButton *selectedBtn;

@end
@implementation LSPEmotionTabBar
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupButtonwithTitle:@"最近" buttonType:LSPEmotionTabBarButtonTypeRecent];
        [self setupButtonwithTitle:@"默认" buttonType:LSPEmotionTabBarButtonTypeDefault];
        [self setupButtonwithTitle:@"Emoji" buttonType:LSPEmotionTabBarButtonTypeEmoji];
        [self setupButtonwithTitle:@"浪小花" buttonType:LSPEmotionTabBarButtonTypeLxh];
    }
    return self;
}

- (LSPComposeTabBarButton *)setupButtonwithTitle:(NSString *)title buttonType:(LSPEmotionTabBarButtonType)buttonType
{
    LSPComposeTabBarButton *btn = [[LSPComposeTabBarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = buttonType;
    if (buttonType == LSPEmotionTabBarButtonTypeDefault) {
        
        [self btnClick:btn];
    }
    [self addSubview:btn];
    //设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        
        
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    //图片拉伸处理
    UIImage *normalImage = [UIImage imageNamed:image];
    UIImage *heighlightedImage = [UIImage imageNamed:selectImage];
    CGFloat top = normalImage.size.height / 2;
    CGFloat left = normalImage.size.width / 2;
    CGFloat bottom = normalImage.size.height / 2;
    CGFloat right = normalImage.size.width / 2;
    normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
    heighlightedImage = [heighlightedImage resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:heighlightedImage forState:UIControlStateDisabled];
    
    
    return btn;
   
}

- (void)setDelegate:(id<LSPEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    [self btnClick:(LSPComposeTabBarButton *)[self viewWithTag:LSPEmotionTabBarButtonTypeDefault]];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i < count; i ++) {
        
        LSPComposeTabBarButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btn.width;
        btn.y = 0;
    }
}

- (void)btnClick:(LSPComposeTabBarButton *)button
{
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectedButton:)]) {
        
        [self.delegate emotionTabBar:self didSelectedButton:button.tag];
    }

   }

@end
