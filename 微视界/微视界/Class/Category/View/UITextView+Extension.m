//
//  UITextView+Extension.m
//  微视界
//
//  Created by mac on 15-11-11.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text
{
    [self insertAttributedText:text settingblock:nil];
}

- (void)insertAttributedText:(NSAttributedString *)text settingblock:(void(^)(NSMutableAttributedString *attributedText))settingBlock
{
    NSMutableAttributedString *attributText = [[NSMutableAttributedString alloc] init];
    
    [attributText appendAttributedString:self.attributedText];
    
    NSUInteger location = self.selectedRange.location;
    
   // [attributText insertAttributedString:text atIndex:location];
   
    [attributText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    if (settingBlock) {
        
        settingBlock(attributText);
    }
    self.attributedText = attributText;
    self.selectedRange = NSMakeRange(location + 1, 0);

}
@end
