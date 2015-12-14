//
//  LSPEmotionTool.m
//  微视界
//
//  Created by mac on 15-11-11.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPEmotionTool.h"
#import "LSPEmotion.h"
#define LSPEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Emotion.archive"]
@implementation LSPEmotionTool

static NSMutableArray *_recentEmotions;

+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:LSPEmotionPath];
    
    if (_recentEmotions == nil) {
        
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)addRecentEmotion:(LSPEmotion *)emotion
{
//    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotion];
//    if (emotions == nil) {
//        emotions = [NSMutableArray array];
//    }
    
    [_recentEmotions removeObject:emotion];
    
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:LSPEmotionPath];
}
+ (NSArray *)recentEmotion
{
    return _recentEmotions;
}

@end
