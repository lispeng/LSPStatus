//
//  LSPEmotionTextView.h
//  微视界
//
//  Created by mac on 15-11-11.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPTextView.h"
@class LSPEmotion;
@interface LSPEmotionTextView : LSPTextView
- (void)insertEmotion:(LSPEmotion *)emotion;
- (NSString *)fullText;
@end
