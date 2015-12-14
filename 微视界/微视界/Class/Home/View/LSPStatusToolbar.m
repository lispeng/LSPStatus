//
//  LSPStatusToolbar.m
//  微视界
//
//  Created by mac on 15-11-4.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPStatusToolbar.h"
#import "UIView+Extension.h"
#import "LSPStatus.h"
@interface LSPStatusToolbar()

@property (strong,nonatomic) NSMutableArray *btns;

@property (strong,nonatomic) NSMutableArray *dividers;

@property (nonatomic,weak) UIButton *repostBtn;

@property (nonatomic,weak) UIButton *commentBtn;

@property (nonatomic,weak) UIButton *attitudeBtn;


@end
@implementation LSPStatusToolbar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];

    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
        
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.repostBtn = [self buttonWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self buttonWithTitle:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self buttonWithTitle:@"赞" icon:@"timeline_icon_unlike"];
        //添加分割线
        [self addDivider];
        [self addDivider];
    }
    
    return self;
}

+ (instancetype)toolbar
{
    return [[self alloc] init];
}

- (UIButton *)buttonWithTitle:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    
    
    return btn;
}
/**
 *  添加分割线的方法
 */
- (void)addDivider
{
    UIImageView *dividerView = [[UIImageView alloc] init];
    dividerView.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:dividerView];
    [self.dividers addObject:dividerView];
}

- (void)setStatus:(LSPStatus *)status
{
    _status = status;
    
    [self setupBtnCount:status.reposts_count button:self.repostBtn title:@"转发"];
    
    [self setupBtnCount:status.comments_count button:self.commentBtn title:@"评论"];
    
    [self setupBtnCount:status.attitudes_count button:self.attitudeBtn title:@"赞"];
    
}

- (void)setupBtnCount:(int)count button:(UIButton *)btn title:(NSString *)title
{
    
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
            [btn setTitle:title forState:UIControlStateNormal];
        }else
        {
            double num = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",num];
            [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            [btn setTitle:title forState:UIControlStateNormal];
        }
       
    }
    else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    
    int btnCount = (int)self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount;i ++) {
        
        UIButton *btn = self.btns[i];
        
        btn.x = i * btnW;
        btn.y = 0;
        btn.height = btnH;
        btn.width = btnW;
        
    }
    
    //分割线的布局
    int dividerLineCount = (int)self.dividers.count;
    for (int i = 0; i < dividerLineCount; i ++) {
        UIImageView *divider = self.dividers[i];
       
        divider.x = (i + 1) * btnW;
        divider.y = 0;
        divider.width = 1;
        divider.height = btnH;
    }
}
@end
