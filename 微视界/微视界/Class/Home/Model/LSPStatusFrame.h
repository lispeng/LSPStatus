//
//  LSPStatusFrame.h
//  微视界
//
//  Created by mac on 15-11-2.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LSPSystemFontForName [UIFont systemFontOfSize:15]
#define LSPSystemFontForCreatedTime [UIFont systemFontOfSize:12]
#define LSPSystemFontForSource [UIFont systemFontOfSize:12]
#define LSPSystemFontForContent [UIFont systemFontOfSize:15]
#define LSPSystemFontForRetweetContent [UIFont systemFontOfSize:13]
#define LSPStatusCellMargin 5
#define LSPCellMargin 10
@class LSPStatus;
@class LSPStatusPhotosView;
@interface LSPStatusFrame : NSObject

@property (strong,nonatomic) LSPStatus *status;

/**
 *  原创微博整体的Frame
 */
@property (nonatomic,assign) CGRect originalViewF;
/**
 *  头像的Frame
 */
@property (nonatomic,assign) CGRect iconViewF;
/**
 *  vip会员的Frame
 */
@property (nonatomic,assign) CGRect vipViewF;
/**
 *  配图的Frame
 */
@property (nonatomic,assign) CGRect photosViewF;
/**
 *  昵称的Frame
 */
@property (nonatomic,assign) CGRect nameLabelF;
/**
 *  时间的Frame
 */
@property (nonatomic,assign) CGRect timeLabelF;
/**
 *  来源的Frame
 */
@property (nonatomic,assign) CGRect sourceLabelF;
/**
 *  正文的Frame
 */
@property (nonatomic,assign) CGRect contentLabelF;

/**
 *转发的微博
 */
@property (nonatomic,assign) CGRect retweetViewF;

/**
 转发的微博内容（微博内容+昵称)Frame
 */
@property (nonatomic,assign) CGRect retweetContentLabelF;
/**
 *  转发的微博配图Frame
 */
@property (nonatomic,assign) CGRect retweetPhotosViewF;

/**
 *  微薄的cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 *  微博底部的长条形控件
 */
@property (assign,nonatomic) CGRect toolBarViewF;

@end
