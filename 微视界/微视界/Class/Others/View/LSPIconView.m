//
//  LSPIconView.m
//  微视界
//
//  Created by mac on 15-11-5.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPIconView.h"
#import "LSPUser.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
@interface LSPIconView()
@property (nonatomic,weak) UIImageView *iconView;

@end

@implementation LSPIconView

- (UIImageView *)iconView
{
    if (_iconView == nil) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
    }
    return _iconView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}

- (void)setUser:(LSPUser *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    switch (user.verified_type) {
        case HWUserVerifiedPersonal:
            self.iconView.hidden = NO;
            self.iconView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case HWUserVerifiedOrgEnterprice:
        case HWUserVerifiedOrgMedia:
        case HWUserVerifiedOrgWebsite:
            self.iconView.hidden = NO;
            self.iconView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case HWUserVerifiedDaren:
            self.iconView.hidden = NO;
            self.iconView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
            
        default:
            self.iconView.hidden = YES;
            break;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat scale = 0.6;
    self.iconView.size = self.iconView.image.size;
    self.iconView.x = self.width - self.iconView.image.size.width * scale;
    self.iconView.y = self.height - self.iconView.image.size.height * scale;
}
@end
