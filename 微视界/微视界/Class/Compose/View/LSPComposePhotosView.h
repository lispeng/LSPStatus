//
//  LSPComposePhotosView.h
//  微视界
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPComposePhotosView : UIView
- (void)addPhoto:(UIImage *)photo;
@property (strong,nonatomic,readonly) NSMutableArray *photos;

@end
