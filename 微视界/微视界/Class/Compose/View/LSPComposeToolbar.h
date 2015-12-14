//
//  LSPComposeToolbar.h
//  微视界
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    LSPComposeToolbarButtomTypeCamera,
    LSPComposeToolbarButtonTypePicture,
    LSPComposeToolbarButtonTypeMention,
    LSPComposeToolbarButtonTypeTrend,
    LSPComposeToolbarButtonTypeEmotion
}LSPComposeToolbarButtonType;
@class LSPComposeToolbar;
@protocol LSPComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(LSPComposeToolbar *)toolbar didClickedButtonType:(LSPComposeToolbarButtonType)buttonType;

@end
@interface LSPComposeToolbar : UIView

@property (nonatomic,weak) id<LSPComposeToolbarDelegate> delegate;
@property (assign,nonatomic) BOOL isShowKeyboardButton;
@end
