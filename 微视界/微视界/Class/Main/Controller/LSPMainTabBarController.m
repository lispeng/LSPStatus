//
//  LSPMainTabBarController.m
//  微视界
//
//  Created by mac on 15-10-28.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPMainTabBarController.h"
#import "LSPBaseNavigationController.h"
#import "LSPHomeViewController.h"
#import "LSPMessageCenterViewController.h"
#import "LSPDiscoverViewController.h"
#import "LSPProfileViewController.h"
#import "LSPTabBar.h"
#import "LSPComposeViewController.h"
#import "LSPTestViewController.h"

#define LSPColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) /255.0 blue:(g) / 255.0 alpha:1.0]
@interface LSPMainTabBarController ()<LSPTabBarDelegate>

@end

@implementation LSPMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildController];
    // Do any additional setup after loading the view.
}

- (void)addChildController
{

    LSPHomeViewController *home = [[LSPHomeViewController alloc] init];
    [self addChildController:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    LSPMessageCenterViewController *messageCenter = [[LSPMessageCenterViewController alloc] init];
    
    [self addChildController:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    
    LSPDiscoverViewController *discover = [[LSPDiscoverViewController alloc] init];
    [self addChildController:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    LSPProfileViewController *profile = [[LSPProfileViewController alloc] init];
    [self addChildController:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    //更换系统自带的UITabBar
    LSPTabBar *customTabBar = [[LSPTabBar alloc] init];
    customTabBar.delegate = self;
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

- (void)addChildController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childController.title = title;
    //childController.view.backgroundColor = [UIColor redColor];
    childController.tabBarItem.title = title;
    UIImage *normalImage = [UIImage imageNamed:image];
    childController.tabBarItem.image = normalImage;
    
    UIImage *selectImage = [UIImage imageNamed:selectedImage];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectImage;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = LSPColor(132, 132, 132);
    [childController.tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateSelected];
    LSPBaseNavigationController *baseNavigationController = [[LSPBaseNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:baseNavigationController];
    
}

- (void)tabBarClicked:(LSPTabBar *)targetTabBar
{
    LSPComposeViewController *compose = [[LSPComposeViewController alloc] init];
    LSPBaseNavigationController *baseNav = [[LSPBaseNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:baseNav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
