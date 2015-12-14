//
//  LSPComposePhotosView.m
//  微视界
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPComposePhotosView.h"
#import "UIView+Extension.h"
@implementation LSPComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _photos = [NSMutableArray array];
    }
    return self;
}

- (void)addPhoto:(UIImage *)photo
{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = photo;
    [self addSubview:imageView];
    [self.photos addObject:photo];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    NSInteger count = self.subviews.count;
    NSInteger maxCols = 4;
    NSInteger photoMargin = 5;
    NSInteger photoWH = 70;
    for (NSInteger i = 0; i < count; i ++) {
        
        UIImageView *imageView = self.subviews[i];
        
        NSInteger rows = i % maxCols;
        NSInteger cols = i / maxCols;
        imageView.x = rows * (photoWH + photoMargin);
        imageView.y = cols * (photoWH + photoMargin);
        imageView.width = photoWH;
        imageView.height = photoWH;
    }
}
@end

