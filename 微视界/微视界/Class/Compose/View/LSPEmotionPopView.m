//
//  LSPEmotionPopView.m
//  微视界
//
//  Created by mac on 15-11-10.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPEmotionPopView.h"
#import "LSPEmotionButton.h"
#import "LSPEmotion.h"
#import "UIView+Extension.h"
@interface LSPEmotionPopView()

@property (weak, nonatomic) IBOutlet LSPEmotionButton *emotionBtn;
@end
@implementation LSPEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LSPEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFromButton:(LSPEmotionButton *)button
{
    
    if(button == nil) return;
    
    self.emotionBtn.emotion = button.emotion;
    
    
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    CGRect pageFrame = [button convertRect:button.bounds toView:nil];
    
    self.y = CGRectGetMidY(pageFrame) - self.height;
    self.centerX = CGRectGetMidX(pageFrame);

    
}
@end
