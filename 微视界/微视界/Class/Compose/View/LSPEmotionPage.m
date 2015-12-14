//
//  LSPEmotionPage.m
//  微视界
//
//  Created by mac on 15-11-10.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPEmotionPage.h"
#import "UIView+Extension.h"
#import "LSPEmotion.h"
#import "NSString+Emoji.h"
#import "LSPEmotionButton.h"
#import "LSPEmotionPopView.h"
#import "LSPEmotionTool.h"
#define LSPColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LSPRandomColor LSPColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface LSPEmotionPage()

@property (strong,nonatomic) LSPEmotionPopView *popView;
@property (nonatomic,weak) UIButton *deleteBtn;

@end
@implementation LSPEmotionPage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteContent) forControlEvents:UIControlEventTouchUpInside];
        
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizer:)]];
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        
    }
    return self;
}
- (void)deleteContent
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPEmotionPageDeleteNotification" object:nil];
}
-(LSPEmotionPopView *)popView
{
    if (_popView == nil) {
        
        self.popView = [LSPEmotionPopView popView];
    }
    return _popView;
}
- (void)setEmojis:(NSArray *)emojis
{
    _emojis = emojis;
    
    NSUInteger count = emojis.count;
    
    for (NSUInteger i = 0; i < count; i ++) {
        
        LSPEmotionButton *btn = [LSPEmotionButton buttonWithType:UIButtonTypeCustom];
       LSPEmotion *emotion = emojis[i];
        btn.emotion = emotion;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    
   
}
- (LSPEmotionButton *)enumerateButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emojis.count;
    
    for (NSUInteger i = 0; i < count; i ++) {
        
        LSPEmotionButton *button = self.subviews[i + 1];
        if (CGRectContainsPoint(button.frame, location)) {
            
            return button;
        }
    
    }
    return nil;
}

- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)recognizer
{
    
    
    CGPoint location = [recognizer locationInView:recognizer.view];
    LSPEmotionButton *btn = [self enumerateButtonWithLocation:location];
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.popView removeFromSuperview];
            if (btn) {
                [self selectEmotion:btn.emotion];
            }
            break;
            
            
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            [self.popView showFromButton:btn];
            break;

        default:
            break;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat padding = 10;
    NSUInteger count = self.emojis.count;
    CGFloat btnW = (self.width - 2 * padding) / LSPEmotionMaxCols;
    CGFloat btnH = (self.height - padding) / LSPEmotionMaxRows;
    
    for (NSUInteger i = 0; i < count; i ++) {
        
        UIButton *btn = self.subviews[i + 1];
        //btn.backgroundColor = LSPRandomColor;
        btn.x = (i % 7) * btnW + padding;
        btn.y = (i / 7) * btnH + padding;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    CGFloat deleteBtnW = btnW;
    CGFloat deleteBtnH = btnH;
    self.deleteBtn.width = deleteBtnW;
    self.deleteBtn.height = deleteBtnH;
    self.deleteBtn.x = self.width - padding - deleteBtnW;
    self.deleteBtn.y = self.height - deleteBtnH;
}

- (void)btnClick:(LSPEmotionButton *)button
{
    [self.popView showFromButton:button];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.popView removeFromSuperview];
    });
    
    //按钮被点击的发送通知
    [self selectEmotion:button.emotion];
}

- (void)selectEmotion:(LSPEmotion *)emotion
{
    
    [LSPEmotionTool addRecentEmotion:emotion];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"emotionDidSelected"] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LSPEmotionDidSelectedNotification" object:nil userInfo:userInfo];
}

@end
