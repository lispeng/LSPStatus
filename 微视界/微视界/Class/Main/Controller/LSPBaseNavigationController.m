//
//  LSPBaseNavigationController.m
//  微视界
//
//  Created by mac on 15-10-28.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPBaseNavigationController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
@implementation LSPBaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}
+ (void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    UINavigationBar *bar = [UINavigationBar appearance];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSMutableDictionary *disableAttributes = [NSMutableDictionary dictionary];
    disableAttributes[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    [item setTitleTextAttributes:disableAttributes forState:UIControlStateDisabled];
    //设置所有导航条的颜色
    [bar setBarTintColor:[UIColor grayColor]];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self selector:@selector(back) image:@"navigationbar_back" selectedImage:@"navigationbar_back_highlighted"];
        
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self selector:@selector(more) image:@"navigationbar_more" selectedImage:@"navigationbar_more_highlighted"];
        
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
