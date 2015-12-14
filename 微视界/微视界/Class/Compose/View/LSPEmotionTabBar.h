//
//  LSPEmotionTabBar.h
//  微视界
//
//  Created by mac on 15-11-7.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    LSPEmotionTabBarButtonTypeRecent,
    LSPEmotionTabBarButtonTypeDefault,
    LSPEmotionTabBarButtonTypeEmoji,
    LSPEmotionTabBarButtonTypeLxh
    
}LSPEmotionTabBarButtonType;

@class LSPEmotionTabBar;

@protocol LSPEmotionTabBarDelegate <NSObject>

@optional

- (void)emotionTabBar:(LSPEmotionTabBar *)tabBar didSelectedButton:(LSPEmotionTabBarButtonType)buttonType;

@end

@interface LSPEmotionTabBar : UIView

@property (assign,nonatomic) CGFloat y;

@property (nonatomic,weak) id<LSPEmotionTabBarDelegate> delegate;


@end
