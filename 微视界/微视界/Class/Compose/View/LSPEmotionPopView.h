//
//  LSPEmotionPopView.h
//  微视界
//
//  Created by mac on 15-11-10.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPEmotion;
@class LSPEmotionButton;
@interface LSPEmotionPopView : UIView
+ (instancetype)popView;

- (void)showFromButton:(LSPEmotionButton *)button;
@end
