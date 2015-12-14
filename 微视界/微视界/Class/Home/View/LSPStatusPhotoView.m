//
//  LSPStatusPhotoView.m
//  微视界
//
//  Created by mac on 15-11-5.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPStatusPhotoView.h"
#import "LSPFigure.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface LSPStatusPhotoView()

@property (nonatomic,weak) UIImageView *gifView;

@end

@implementation LSPStatusPhotoView

- (UIImageView *)gifView
{
    if (_gifView == nil) {
        
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

-  (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}
- (void)setPhoto:(LSPFigure *)photo
{
    _photo = photo;
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.width - self.gifView.height;
}

@end
