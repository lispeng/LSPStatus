//
//  LSPNewfeatureController.m
//  微视界
//
//  Created by mac on 15-10-30.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPNewfeatureController.h"
#import "UIView+Extension.h"
#import "LSPMainTabBarController.h"
#define LSPScrollViewCount 4
#define LSPColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) /255.0 blue:(g) / 255.0 alpha:1.0]
@interface LSPNewfeatureController()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollerView;
@property (nonatomic,weak) UIPageControl *pageControl;


@end

@implementation LSPNewfeatureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addScrollView];
    
    [self addPageControl];
    
}

- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    
    scrollView.contentSize = CGSizeMake(LSPScrollViewCount * scrollView.width, 0);
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    CGFloat scrollViewW = scrollView.width;
    CGFloat scrollViewH = scrollView.height;
    for (int i = 0; i < LSPScrollViewCount; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
       
        imageView.width = scrollViewW;
        imageView.height = scrollViewH;
        imageView.x = i * scrollViewW;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        imageView.image = image;
        [scrollView addSubview:imageView];
        
        if (i == LSPScrollViewCount-1) {
            
            [self lastImageViewForStyle:imageView];
        }
    }
    
    
    [self.view addSubview:scrollView];
    
    self.scrollerView = scrollView;
}

- (void)lastImageViewForStyle:(UIImageView *)imageView
{
   
    imageView.userInteractionEnabled = YES;
    
   // UIButton *checkBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *checkBoxBtn = [[UIButton alloc] init];
    [checkBoxBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBoxBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [checkBoxBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    checkBoxBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkBoxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    checkBoxBtn.width = 200;
    checkBoxBtn.height = 30;
    checkBoxBtn.centerX = imageView.width * 0.5;
    checkBoxBtn.centerY = imageView.height * 0.65;
    

    [checkBoxBtn addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:checkBoxBtn];
    
    checkBoxBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    //开始按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.userInteractionEnabled = YES;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = imageView.width * 0.5;
    startBtn.centerY = imageView.height * 0.75;
    
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
}

- (void)checkBoxClick:(UIButton *)checkBoxBtn
{
    checkBoxBtn.selected = !checkBoxBtn.isSelected;
}

- (void)startBtnClick
{
    NSLog(@"新特性的销毁");
    LSPMainTabBarController *mainTabBar = [[LSPMainTabBarController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    window.rootViewController = mainTabBar;
}
- (void)addPageControl
{
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.x = [UIScreen mainScreen].bounds.size.width * 0.5;
    pageControl.y = self.scrollerView.height - 50;
    
    pageControl.numberOfPages = LSPScrollViewCount;
 
   // pageControl.x = 170;
   // pageControl.y = 300;
       pageControl.backgroundColor = [UIColor redColor];
    
    pageControl.currentPageIndicatorTintColor = LSPColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = LSPColor(189, 189, 189);
    
    
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double currentNum = self.scrollerView.contentOffset.x / self.view.width;
    
    int returnNum = (int)(currentNum + 0.5);
    
    self.pageControl.currentPage = returnNum;

}
@end
