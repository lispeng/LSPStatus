//
//  LSPTextAttachment.m
//  微视界
//
//  Created by mac on 15-11-11.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPTextAttachment.h"
#import "LSPEmotion.h"
#import "NSString+Emoji.h"
@implementation LSPTextAttachment
- (void)setEmotion:(LSPEmotion *)emotion
{
    _emotion = emotion;
    
  
    self.image = [UIImage imageNamed:emotion.png];
   
        
    
}
@end
