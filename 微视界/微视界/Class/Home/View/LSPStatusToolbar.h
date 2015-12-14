//
//  LSPStatusToolbar.h
//  微视界
//
//  Created by mac on 15-11-4.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPStatus;
@interface LSPStatusToolbar : UIView
+ (instancetype)toolbar;
@property (strong,nonatomic) LSPStatus *status;

@end
