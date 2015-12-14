//
//  LSPSearchBar.m
//  微视界
//
//  Created by mac on 15-10-29.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPSearchBar.h"
#import "UIView+Extension.h"
@implementation LSPSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
       
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = 30;
        imageView.height = 30;
        
        imageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

+ (instancetype)searchBar
{
    return [[LSPSearchBar alloc] init];
}

@end
