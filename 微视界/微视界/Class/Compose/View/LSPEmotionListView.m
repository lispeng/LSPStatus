//
//  LSPEmotionListView.m
//  微视界
//
//  Created by mac on 15-11-7.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPEmotionListView.h"
#import "UIView+Extension.h"
#import "LSPEmotionPage.h"

#define LSPColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LSPRandomColor LSPColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface LSPEmotionListView()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic,weak) UIPageControl *pageControl;


@end
@implementation LSPEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        //这只pageControl的背景图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = (emotions.count + LSPPageOfMaxNum - 1) / LSPPageOfMaxNum;
    self.pageControl.numberOfPages = count;
    
    //创建每一页的容器ContentView
    for (NSUInteger i = 0; i < count; i ++) {
        LSPEmotionPage *contentView = [[LSPEmotionPage alloc] init];
       // contentView.backgroundColor = LSPRandomColor;
        
        NSRange range = NSMakeRange(0, 0);
        NSUInteger left = emotions.count - i * LSPPageOfMaxNum;
        if (left > LSPPageOfMaxNum) {
            
            range.location = i * LSPPageOfMaxNum;
            range.length = LSPPageOfMaxNum;
        }else{
            range.location = i * LSPPageOfMaxNum;
            range.length = left;
        }
       
        contentView.emojis = [emotions subarrayWithRange:range];
        
        [self.scrollView addSubview:contentView];
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    /**
     *  pageControl的frame设置
     */
   
    self.pageControl.width = self.width;
    self.pageControl.x = 0;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
       /*
    CGFloat pageControlX = 0;
    CGFloat pageControlH = 35;
    CGFloat pageControlY = self.height - 35;
    CGFloat pageControlW = self.width;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    */
    
    //scrollView的frame设置
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;

  
    //scrollView内部的ContentView的设置
    NSUInteger count = self.scrollView.subviews.count;
    for (NSUInteger i = 0; i < count; i ++) {
        
        LSPEmotionPage *contentView = self.scrollView.subviews[i];
        
        contentView.width = self.scrollView.width;
        contentView.height = self.scrollView.height;
        contentView.x = i * contentView.width;
        contentView.y = 0;
    }
    
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
    
}

#pragma mark---UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double num = scrollView.contentOffset.x / scrollView.width;
    
    self.pageControl.currentPage = (NSUInteger)(num + 0.5);
}

@end
