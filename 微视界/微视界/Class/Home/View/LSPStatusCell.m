//
//  LSPStatusCell.m
//  微视界
//
//  Created by mac on 15-11-2.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPStatusCell.h"
#import "LSPStatusFrame.h"
#import "LSPStatus.h"
#import "LSPUser.h"
#import "LSPFigure.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "LSPStatusToolbar.h"
#import "NSString+Extension.h"
#import "LSPStatusPhotosView.h"
#import "LSPIconView.h"
#define LSPCellTopMargin 15
@interface LSPStatusCell()
/**
 *  原创微博整体
 */
@property (nonatomic,weak) UIView *originalView;
/**
 *  头像
 */
@property (nonatomic,weak) LSPIconView *iconView;
/**
 *  vip会员
 */
@property (nonatomic,weak) UIImageView *vipView;
/**
 *  配图
 */
@property (nonatomic,weak) LSPStatusPhotosView *photosView;
/**
 *  昵称
 */
@property (nonatomic,weak) UILabel *nameLabel;
/**
 *  时间
 */
@property (nonatomic,weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic,weak) UILabel *sourceLabel;
/**
 *  正文
 */
@property (nonatomic,weak) UILabel *contentLabel;

/**
    *转发的微博
 */
@property (nonatomic,weak) UIView *retweetView;

/**
 转发的微博内容（微博内容+昵称)
 */
@property (nonatomic,weak) UILabel *retweetContentLabel;
/**
 *  转发的微博配图
 */
@property (nonatomic,weak) LSPStatusPhotosView *retweetPhotosView;

/**
   *底部的长条控件
 */
@property (nonatomic,weak) LSPStatusToolbar *toolBarView;

@end

@implementation LSPStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //微博原型
        [self originalStatus];
        
        //转发的微博
        [self retweetedStatus];
        
        //每条cell底部的长条控件
        [self addToolBarView];
        
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += LSPCellTopMargin;
    [super setFrame:frame];
}

/**
 *  原来的微博
 */
- (void)originalStatus
{
    /**
     *  原创微博整体
     */
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /**
     *  头像
     */
    LSPIconView *iconView = [[LSPIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    /**
     *  vip会员
     */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    /**
     *  配图
     */
    LSPStatusPhotosView *photosView = [[LSPStatusPhotosView alloc] init];
    photosView.backgroundColor = [UIColor blueColor];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    /**
     *  昵称
     */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = LSPSystemFontForName;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    
    /**
     *  时间
     */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = LSPSystemFontForCreatedTime;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    /**
     *  来源
     */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = LSPSystemFontForSource;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    /**
     *  正文
     */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = LSPSystemFontForContent;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;

}
/**
 *  转发的微博
 */
- (void)retweetedStatus
{
    /**
       转发的微博整体
     */
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    /**
     转发的微博内容（微博内容+昵称)
     */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = LSPSystemFontForRetweetContent;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    /**
     *  转发的微博配图
     */
    LSPStatusPhotosView *retweetPhotosView = [[LSPStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}
/**
 *  每条Cell底部的长条控件
 */
- (void)addToolBarView
{
    LSPStatusToolbar *toolBarView = [[LSPStatusToolbar alloc] init];
    //toolBarView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;
}
+ (instancetype)statusCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"statusCell";
    LSPStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LSPStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
    
}
/**
 *  微博cell里面的子空间的布局
 *
 */
- (void)setStatusFrame:(LSPStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    LSPStatus *status = statusFrame.status;
    LSPUser *user = status.user;
    
    self.originalView.backgroundColor = [UIColor whiteColor];
    
    
    
    //微博容器
    self.originalView.frame = statusFrame.originalViewF;
    
    //微博头像
    self.iconView.frame = statusFrame.iconViewF;
    //NSLog(@"user.profile_image_url = %@",user.profile_image_url);
    self.iconView.user = status.user;
    //[self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //会员
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *nameVip = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:nameVip];
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else
    {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    //微薄的配图
    self.photosView.frame = statusFrame.photosViewF;
    if (status.pic_urls.count) {
       // LSPFigure *figurePath = [status.pic_urls firstObject];
        
        self.photosView.photos = status.pic_urls;
       
        self.photosView.hidden = NO;
    }else
    {
        
        self.photosView.hidden = YES;
    }
   
    //self.photosView.backgroundColor = [UIColor redColor];
    //微博昵称
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    
    
   
    /***时间Frame**/
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + LSPStatusCellMargin;
    CGSize timeSize = [time sizeWithFont:LSPSystemFontForCreatedTime];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLabel.text = time;
    //微博来源
    /***来源**/
    CGFloat sourceX = CGRectGetMaxX(statusFrame.timeLabelF) + LSPStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:LSPSystemFontForSource];
    self.sourceLabel.frame= (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLabel.text = status.source;
    //微博内容
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
/**********转发的微博设置****************************/
    if (status.retweeted_status) {
        self.retweetView.backgroundColor = [UIColor whiteColor];
        LSPStatus *retweetedStatus = status.retweeted_status;
        LSPUser *retweetedUser = retweetedStatus.user;
        
        /*******转发的微博内容*******/
        self.retweetView.hidden = NO;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        NSString *retweetedContent = [NSString stringWithFormat:@"@%@ : %@",retweetedUser.name,retweetedStatus.text];
        self.retweetContentLabel.text = retweetedContent;
        
        self.retweetContentLabel.backgroundColor = [UIColor redColor];
        
        if (retweetedStatus.pic_urls.count) {
            
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            
            self.retweetPhotosView.photos = retweetedStatus.pic_urls;
         
            self.photosView.hidden = NO;
        }else
        {
            self.photosView.hidden = YES;
        }
 }else
{
            self.retweetView.hidden = YES;
}
    
    self.toolBarView.frame = statusFrame.toolBarViewF;
    self.toolBarView.status = status;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
