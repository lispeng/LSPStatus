//
//  LSPStatusCell.h
//  微视界
//
//  Created by mac on 15-11-2.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSPStatusFrame;

@interface LSPStatusCell : UITableViewCell

+ (instancetype)statusCellWithTableView:(UITableView *)tableView;

@property (strong,nonatomic) LSPStatusFrame *statusFrame;

@end
