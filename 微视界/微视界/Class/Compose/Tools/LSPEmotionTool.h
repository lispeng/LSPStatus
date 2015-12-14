//
//  LSPEmotionTool.h
//  微视界
//
//  Created by mac on 15-11-11.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSPEmotion;
@interface LSPEmotionTool : NSObject
+ (void)addRecentEmotion:(LSPEmotion *)emotion;
+ (NSArray *)recentEmotion;
@end
