//
//  UIBarButtonItem+Extension.h
//  微视界
//
//  Created by mac on 15-10-29.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target selector:(SEL)selector image:(NSString *)image selectedImage:(NSString *)selectedImage;
@end
