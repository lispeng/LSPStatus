//
//  UIWindow+Extension.m
//  微视界
//
//  Created by mac on 15-10-31.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "LSPMainTabBarController.h"
#import "LSPNewfeatureController.h"
@implementation UIWindow (Extension)

+ (void)switchRootViewController
{
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
    LSPMainTabBarController *mainTabBar = [[LSPMainTabBarController alloc] init];
    
    LSPNewfeatureController *newfeature = [[LSPNewfeatureController alloc] init];
    
    NSString *key = @"CFBundleVersion";
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        
        window.rootViewController = mainTabBar;
     }
    else
    {
        window.rootViewController = newfeature;
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
@end
