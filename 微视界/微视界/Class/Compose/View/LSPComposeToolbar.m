//
//  LSPComposeToolbar.m
//  微视界
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPComposeToolbar.h"
#import "UIView+Extension.h"
@interface LSPComposeToolbar()
@property (nonatomic,weak) UIButton *emotionButton;

@end
@implementation LSPComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        // 初始化按钮
        [self setupBtnWithImage:@"compose_camerabutton_background" heighlightedImage:@"compose_camerabutton_background_highlighted" type:LSPComposeToolbarButtomTypeCamera];
        
        [self setupBtnWithImage:@"compose_toolbar_picture" heighlightedImage:@"compose_toolbar_picture_highlighted" type:LSPComposeToolbarButtonTypePicture];
        
        [self setupBtnWithImage:@"compose_mentionbutton_background" heighlightedImage:@"compose_mentionbutton_background_highlighted" type:LSPComposeToolbarButtonTypeMention];
        
        [self setupBtnWithImage:@"compose_trendbutton_background" heighlightedImage:@"compose_trendbutton_background_highlighted" type:LSPComposeToolbarButtonTypeTrend];
        
      self.emotionButton = [self setupBtnWithImage:@"compose_emoticonbutton_background" heighlightedImage:@"compose_emoticonbutton_background_highlighted" type:LSPComposeToolbarButtonTypeEmotion];
    }
    
    return self;
}

- (UIButton *)setupBtnWithImage:(NSString *)normalImage heighlightedImage:(NSString *)heighlightedImage type:(LSPComposeToolbarButtonType)buttonType
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:heighlightedImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnCliked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = buttonType;
    [self addSubview:btn];
    return btn;
}

- (void)btnCliked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickedButtonType:)]) {
        //NSInteger btnType = sender.tag;
        [self.delegate composeToolbar:self didClickedButtonType:sender.tag];
    }
}

- (void)setIsShowKeyboardButton:(BOOL)isShowKeyboardButton
{
    _isShowKeyboardButton = isShowKeyboardButton;
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    if (_isShowKeyboardButton) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i < count; i ++) {
        
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
}

@end
