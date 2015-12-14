//
//  LSPEmotionKeyboard.m
//  微视界
//
//  Created by mac on 15-11-7.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPEmotionKeyboard.h"
#import "LSPEmotionTabBar.h"
#import "LSPEmotionListView.h"
#import "UIView+Extension.h"
#import "LSPEmotion.h"
#import "MJExtension.h"
#import "LSPEmotionTool.h"
@interface LSPEmotionKeyboard()<LSPEmotionTabBarDelegate>
@property (weak,nonatomic) UIView *contentView;
@property (nonatomic,strong) LSPEmotionListView *recentListView;
@property (nonatomic,strong) LSPEmotionListView *defaultListView;
@property (nonatomic,strong) LSPEmotionListView *emojiListView;
@property (nonatomic,strong) LSPEmotionListView *lxhListView;
@property (nonatomic,weak) LSPEmotionTabBar *tabBar;

@end
@implementation LSPEmotionKeyboard
#pragma -------懒加载

//- (UIView *)contentView
//{
//    if (_contentView == nil) {
//        _contentView = [[UIView alloc] init];
//        
//    }
//    return _contentView;
//}

- (LSPEmotionListView *)recentListView
{
    if (_recentListView == nil) {
        self.recentListView = [[LSPEmotionListView alloc] init];
    
        self.recentListView.emotions = [LSPEmotionTool recentEmotion];
    }
    return _recentListView;
}

- (LSPEmotionListView *)defaultListView
{
    if (_defaultListView == nil) {
        self.defaultListView = [[LSPEmotionListView alloc] init];
        //self.defaultListView.backgroundColor = [UIColor blueColor];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [LSPEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
      
    }
    return _defaultListView;
}


- (LSPEmotionListView *)emojiListView
{
    if (_emojiListView == nil) {
        self.emojiListView = [[LSPEmotionListView alloc] init];
       // self.emojiListView.backgroundColor = [UIColor greenColor];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [LSPEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

- (LSPEmotionListView *)lxhListView
{
    if (_lxhListView == nil) {
        _lxhListView = [[LSPEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhListView.emotions = [LSPEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
       
        LSPEmotionTabBar *tabBar = [[LSPEmotionTabBar alloc] init];
      
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidselect) name:@"LSPEmotionDidSelectedNotification" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)emotionDidselect
{
    self.recentListView.emotions = [LSPEmotionTool recentEmotion];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //底部工具条的Frame设置
    self.tabBar.width = self.width;
    self.tabBar.height = 44;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    //self.tabBars.y = 216 -44;
    //表情内容整体的Frame设置
    self.contentView.x = 0;
    self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.height - 44;
  //  NSLog(@"self.contentView.frame = %@",NSStringFromCGRect(self.contentView.frame));
   
    UIView *childView = [self.contentView.subviews lastObject];
    childView.frame = self.contentView.bounds;
    
}

- (void)emotionTabBar:(LSPEmotionTabBar *)tabBar didSelectedButton:(LSPEmotionTabBarButtonType)buttonType
{
   [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (buttonType) {
            
        case LSPEmotionTabBarButtonTypeRecent:{
            
            [self.contentView addSubview:self.recentListView];
            break;
        }
        case LSPEmotionTabBarButtonTypeDefault:{
          
            [self.contentView addSubview:self.defaultListView];
            
            break;
        }
        case LSPEmotionTabBarButtonTypeEmoji:{
            [self.contentView addSubview:self.emojiListView];
           
            break;
        }
        case LSPEmotionTabBarButtonTypeLxh:{
            [self.contentView addSubview:self.lxhListView];

            break;
        }
    }
     [self setNeedsLayout];
   
   
}

@end
