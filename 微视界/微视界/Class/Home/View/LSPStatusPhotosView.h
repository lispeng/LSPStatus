//
//  LSPStatusPhotosView.h
//  微视界
//
//  Created by mac on 15-11-5.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPStatusPhotoView;
@interface LSPStatusPhotosView : UIView

@property (strong,nonatomic) NSArray *photos;

@property (strong,nonatomic) LSPStatusPhotoView *photo;

+ (CGSize)sizeWithStatusPhotosCount:(NSInteger)count;

@end
