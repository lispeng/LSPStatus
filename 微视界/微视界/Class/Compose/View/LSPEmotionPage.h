//
//  LSPEmotionPage.h
//  微视界
//
//  Created by mac on 15-11-10.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LSPEmotionMaxCols 7
#define LSPEmotionMaxRows 3
#define LSPPageOfMaxNum ((LSPEmotionMaxCols * LSPEmotionMaxRows) - 1)
@interface LSPEmotionPage : UIView

@property (strong,nonatomic) NSArray *emojis;

@end
