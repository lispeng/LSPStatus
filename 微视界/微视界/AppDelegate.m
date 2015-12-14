//
//  AppDelegate.m
//  微视界
//
//  Created by mac on 15-10-28.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "AppDelegate.h"
#import "UIWindow+Extension.h"
#import "LSPAccountTool.h"
#import "LSPOAuthViewController.h"
#import "LSPAccount.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
        //判断
    //获取沙盒路径
   [self.window makeKeyAndVisible];
    LSPAccount *account = [LSPAccountTool account];
    if (account) {
        
        [UIWindow switchRootViewController];
               
    }
    else
    {
        LSPOAuthViewController *OAuth = [[LSPOAuthViewController alloc] init];
        self.window.rootViewController = OAuth;

    }
     

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
        __block UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
               
             [application endBackgroundTask:task];
           }];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager cancelAll];
    
    [manager.imageCache clearMemory];
}
@end
