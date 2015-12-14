//
//  UIBarButtonItem+Extension.m
//  微视界
//
//  Created by mac on 15-10-29.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target selector:(SEL)selector image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [backBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    backBtn.size = backBtn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

@end
