//
//  LSPTabBar.h
//  微视界
//
//  Created by mac on 15-10-29.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPTabBar;

@protocol LSPTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarClicked:(LSPTabBar *)targetTabBar;

@end
@interface LSPTabBar : UITabBar
@property (nonatomic, assign) id<LSPTabBarDelegate> delegate;
@end
