//
//  LSPStatusPhotosView.m
//  微视界
//
//  Created by mac on 15-11-5.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPStatusPhotosView.h"
#import "UIImageView+WebCache.h"
#import "LSPFigure.h"
#import "UIView+Extension.h"
#import "LSPStatusPhotoView.h"
#define LSPFigureMargin 10
#define LSPFigureSize 70
#define MaxCols(count) ((count == 4) ? 2 : 3)
@implementation LSPStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

/**
 *  设置图片
 */

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSInteger photosCount = photos.count;
    
    while (self.subviews.count < photosCount) {
        
        LSPStatusPhotoView *imageView = [[LSPStatusPhotoView alloc] init];
        
        [self addSubview:imageView];
    }
    
    for (NSInteger i = 0; i < self.subviews.count; i ++) {
        
        //
        LSPStatusPhotoView *figureView = self.subviews[i];
        
        if (i < photosCount) {
            figureView.hidden = NO;
            LSPFigure *figure = photos[i];
            figureView.photo = figure;
          //  [figureView sd_setImageWithURL:[NSURL URLWithString:figure.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder" ]];
        }else{
            figureView.hidden = YES;
        }
    }
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.photos.count;
    NSInteger maxCols = MaxCols(count);
    for (NSInteger i = 0; i < count; i ++) {
        
        UIImageView *figureView = self.subviews[i];
        
        NSInteger rows = i % maxCols;
        NSInteger cols = i / maxCols;
        figureView.x = rows * (LSPFigureSize + LSPFigureMargin);
        figureView.y = cols * (LSPFigureSize + LSPFigureMargin);
        figureView.width = LSPFigureSize;
        figureView.height = LSPFigureSize;
    }
    
    
    
}

+ (CGSize)sizeWithStatusPhotosCount:(NSInteger)count
{
    NSInteger maxCols = MaxCols(count);
    
    NSInteger col = (count >= maxCols) ? maxCols : count;
    
    CGFloat photosW = col * LSPFigureSize + (col - 1) * LSPFigureMargin;
    
    NSInteger rows = (count + maxCols - 1) / maxCols;
    
    CGFloat photoH = rows * LSPFigureSize + (rows - 1) * LSPFigureMargin;
    
    return CGSizeMake(photosW, photoH);
}

@end
