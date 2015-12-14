//
//  LSPTextView.m
//  微视界
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPTextView.h"

@interface LSPTextView()

@end
@implementation LSPTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)textChanged
{
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
  
    if (self.hasText) return;
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat h = rect.size.height - 2 * y;
    
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    attrs[NSFontAttributeName] = self.font ? self.font : [UIFont systemFontOfSize:15];
    
    
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];
 
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    
}


@end
