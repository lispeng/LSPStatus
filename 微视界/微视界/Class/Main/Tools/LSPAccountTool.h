//
//  LSPAccountTool.h
//  微视界
//
//  Created by mac on 15-10-31.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSPAccount.h"

@interface LSPAccountTool : NSObject

+ (void)saveAccount:(LSPAccount *)account;
+ (LSPAccount *)account;
@end
