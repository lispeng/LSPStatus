//
//  LSPEmotionTextView.m
//  微视界
//
//  Created by mac on 15-11-11.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPEmotionTextView.h"
#import "LSPEmotion.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"
#import "LSPTextAttachment.h"
@implementation LSPEmotionTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)insertEmotion:(LSPEmotion *)emotion
{
    
    if(emotion.code){
        
        [self insertText:emotion.code.emoji];
    }else if (emotion.png){
    
    LSPTextAttachment *attach = [[LSPTextAttachment alloc] init];
    attach.emotion = emotion;
    CGFloat attachWH = self.font.lineHeight;
    attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
    
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attach];
    
    [self insertAttributedText:attributedString];
        
        
    }
    
}

- (NSString *)fullText
{
    NSMutableString *fullText = [[NSMutableString alloc] init];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        LSPTextAttachment *attachment = attrs[@"NSAttachment"];
        
        if (attachment) {
            
            [fullText appendString:attachment.emotion.chs];
        }else{
            
            NSAttributedString *attri = [self.attributedText attributedSubstringFromRange:range];
            
            [fullText appendString:attri.string];
        }
        
    }];
    
    return fullText;
}
@end
