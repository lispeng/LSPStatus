//
//  LSPStatusFrame.m
//  微视界
//
//  Created by mac on 15-11-2.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPStatusFrame.h"
#import "LSPUser.h"
#import "LSPStatus.h"
#import "LSPFigure.h"
#import "NSString+Extension.h"
#import "LSPStatusPhotosView.h"

@implementation LSPStatusFrame
/*
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}
 */

- (void)setStatus:(LSPStatus *)status
{
    _status = status;
    LSPUser *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /***头像**/
    CGFloat iconX = LSPStatusCellMargin;
    CGFloat iconY = LSPStatusCellMargin;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    /***昵称**/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + LSPStatusCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:LSPSystemFontForName];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    
    /***会员图标**/
    if (user.isVip) {
        
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + LSPStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipW = 15;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    
    /***时间**/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + LSPStatusCellMargin;
    CGSize timeSize = [status.created_at sizeWithFont:LSPSystemFontForCreatedTime];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    
    /***来源**/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + LSPStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:LSPSystemFontForSource];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    /***正文**/
    
    CGFloat figureX = 0;
    CGFloat figureY = 0;
    
    if (status.text) {
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + LSPStatusCellMargin;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.text sizeWithFont:LSPSystemFontForContent maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
        
        figureX = contentX;
        figureY = CGRectGetMaxY(self.contentLabelF) + LSPStatusCellMargin;
    }else{
        figureX = iconX;
        figureY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + LSPStatusCellMargin;
    }
    
    /***配图**/
    CGFloat originH = 0;
    if (status.pic_urls.count) {
        
        CGSize figureSize = [LSPStatusPhotosView sizeWithStatusPhotosCount:status.pic_urls.count];
      //  self.photosViewF = (CGRect){{figureX,figureY},figureSize};
        self.photosViewF = CGRectMake(figureX, figureY, figureSize.width, figureSize.height);
        originH = CGRectGetMaxY(self.photosViewF) + LSPStatusCellMargin;
    }else{
        if(status.text)
        {
        originH = CGRectGetMaxY(self.contentLabelF) + LSPStatusCellMargin;
        }else{
            originH = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + LSPStatusCellMargin;

        }
    }
    
    
    /***原创微博整体**/
    CGFloat originalX = 0;
    CGFloat originalY = LSPStatusCellMargin;
    CGFloat originalW = cellW;
   self.originalViewF = CGRectMake(originalX, originalY, originalW, originH);
    
      CGFloat toolBarViewY = 0;
 /************************转发微博的frame设置*******************************/
    
    if (status.retweeted_status) {
        
        LSPStatus *retweetedStatus = status.retweeted_status;
        LSPUser *retweetedUser = retweetedStatus.user;
        
      
        /**********转发微博的内容**********/
        NSString *retweetedContent = [NSString stringWithFormat:@"@%@ : %@",retweetedUser.name,retweetedStatus.text];
        CGFloat retweetedContentX = LSPStatusCellMargin;
        CGFloat retweetedContentY = CGRectGetMaxY(self.originalViewF);
        CGFloat maxW = cellW - 2 * retweetedContentX;
        CGSize retweetedContentSize = [retweetedContent sizeWithFont:LSPSystemFontForRetweetContent maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetedContentX,retweetedContentY},retweetedContentSize};
        CGFloat retweetContentH = 0;
        /***********转发微博的配图*****************/
        
#warning -----转发微薄的配图的frame设置----------
        if(retweetedStatus.pic_urls.count)
        {
            
            CGFloat retweetedFigureX = retweetedContentX;
            CGFloat retweetedFigureY = CGRectGetMaxY(self.retweetContentLabelF) + LSPStatusCellMargin;
            CGSize retweetedFigureSize = [LSPStatusPhotosView sizeWithStatusPhotosCount:retweetedStatus.pic_urls.count];
            
            self.retweetPhotosViewF = (CGRect){{retweetedFigureX,retweetedFigureY},retweetedFigureSize};
            
          //  retweetContentH = CGRectGetMaxY(self.retweetFigureViewF) + LSPStatusCellMargin;
            retweetContentH = self.retweetContentLabelF.size.height +self.retweetPhotosViewF.size.height + LSPStatusCellMargin;

            
        }else
        {
            //retweetContentH = CGRectGetMaxY(self.retweetContentLabelF) + LSPStatusCellMargin;
            retweetContentH = self.retweetContentLabelF.size.height + LSPStatusCellMargin;
        }
        
        CGFloat retweetContentX = 0;
        CGFloat retweetContentY = CGRectGetMaxY(self.originalViewF) + LSPStatusCellMargin;
        CGFloat retweetContentW = cellW;
        self.retweetViewF = CGRectMake(retweetContentX, retweetContentY, retweetContentW, retweetContentH);
        toolBarViewY = CGRectGetMaxY(self.retweetViewF) + 1;
        
    }else{
        
        toolBarViewY = CGRectGetMaxY(self.originalViewF) + 1;
            }
    //NSLog(@"toolBarViewY = %lf",toolBarViewY);
    
    CGFloat toolBarViewX = 0;
    CGFloat toolBarViewH = 35;
    CGFloat toolBarViewW = cellW;
    self.toolBarViewF = CGRectMake(toolBarViewX, toolBarViewY, toolBarViewW, toolBarViewH);
    
    self.cellHeight = CGRectGetMaxY(self.toolBarViewF) + LSPCellMargin;

    
    
}


@end
