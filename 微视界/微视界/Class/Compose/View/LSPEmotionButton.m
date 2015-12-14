//
//  LSPEmotionButton.m
//  微视界
//
//  Created by mac on 15-11-10.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPEmotionButton.h"
#import "LSPEmotion.h"
#import "NSString+Emoji.h"

@implementation LSPEmotionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentMode = UIViewContentModeCenter;
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentMode = UIViewContentModeCenter;
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
}
- (void)setEmotion:(LSPEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {
        
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else if (emotion.code)
    {
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
        
    }

}
@end
