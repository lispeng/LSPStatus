//
//  LSPHomeViewController.m
//  微视界
//
//  Created by mac on 15-10-28.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPHomeViewController.h"
#import "LSPDropdownMenu.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "LSPAccountTool.h"
#import "AFNetworking.h"
#import "LSPTitleButton.h"
#import "UIImageView+WebCache.h"
#import "LSPUser.h"
#import "LSPStatus.h"
#import "MJExtension.h"
#import "LSPLoadFooterView.h"
#import "LSPStatusFrame.h"
#import "LSPStatusCell.h"
#import "LSPStatusTool.h"
@interface LSPHomeViewController ()<LSPDropdownMenuDelagate>
@property (strong,nonatomic) NSMutableArray *dataSource;
@property (strong,nonatomic) NSMutableArray *statusFrames;
@property (strong,nonatomic) NSDictionary *dic;


@end

@implementation LSPHomeViewController

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}


- (NSDictionary *)dic
{
    if (_dic == nil) {
        _dic = [NSDictionary dictionary];
    }
    return _dic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1.0];
    //设置导航栏左右按钮样式
    [self setStyleNavigationBar];
    
    //数据请求
    [self navigationInfoRequest];
    
    //获得微博数据
   // [self loadNewStatus];
    
    //集成下拉刷新控件
    [self addRefresh];
    
    //集成上拉刷新控件
    [self loadDownRefresh];
    
    
    // 获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    
}

- (NSArray *)statusFrameFromNewArray:(NSArray *)newArray
{
    NSMutableArray *status = [NSMutableArray array];
    
    for (LSPStatus *statusModel in newArray) {
        
        LSPStatusFrame *statusFrame = [[LSPStatusFrame alloc] init];
        statusFrame.status = statusModel;
        [status addObject:statusFrame];
    }
    
    return status;
}
/**
 *  获得未读数
 */
- (void)setupUnreadCount
{
    //    HWLog(@"setupUnreadCount");
    //    return;
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    LSPAccount *account = [LSPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 微博的未读数
        //        int status = [responseObject[@"status"] intValue];
        // 设置提醒数字
        //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", status];
        
        // @20 --> @"20"
        // NSNumber --> NSString
        // 设置提醒数字(微博的未读数)
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@", error);
    }];
}


- (void)loadDownRefresh
{
    LSPLoadFooterView *loadFooterView = [LSPLoadFooterView loadFooterView];
    self.tableView.tableFooterView = loadFooterView;
    loadFooterView.hidden = YES;
}

- (void)addRefresh
{
    UIRefreshControl *refrashControl = [[UIRefreshControl alloc] init];
    
    [refrashControl addTarget:self action:@selector(refreshLoad:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:refrashControl];
    
    [refrashControl beginRefreshing];
    
    [self refreshLoad:refrashControl];
}

- (void)refreshLoad:(UIRefreshControl *)refreshControl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *path = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    LSPStatusFrame *statusFrame = [self.statusFrames firstObject];
    LSPAccount *account = [LSPAccountTool account];
    params[@"access_token"] = account.access_token;
    
    if(statusFrame)
    {
    params[@"since_id"] = statusFrame.status.idstr;
    }
    
    void (^statusBlock)(NSArray *) = ^(NSArray *statues){
        
        
        NSArray *newStatus = [LSPStatus objectArrayWithKeyValuesArray:statues];
        NSArray *status = [self statusFrameFromNewArray:newStatus];
        NSRange range = NSMakeRange(0, newStatus.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:status atIndexes:indexSet];
        [self.tableView reloadData];
        
        [self showLoadNum:newStatus.count];
    };
    //尝试从沙盒中加载数据
    NSArray *status = [LSPStatusTool statusWithParams:params];
    if (status.count) {
        statusBlock(status);
        
    }else{
     [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        
        NSArray *statuses = responseObject[@"statuses"];
         [LSPStatusTool saveStatus:statuses];
         statusBlock(statuses);
        
        //        for (NSDictionary *dict in statuses) {
        //
        //            LSPStatus *status = [LSPStatus statusWithDict:dict];
        //            [self.dataSource addObject:status];
        //        }
#warning -------修改的frame
//        NSArray *newStatus = [LSPStatus objectArrayWithKeyValuesArray:statuses];
//        NSArray *status = [self statusFrameFromNewArray:newStatus];
//        NSRange range = NSMakeRange(0, newStatus.count);
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statusFrames insertObjects:status atIndexes:indexSet];
//        [self.tableView reloadData];
//        
//        [self showLoadNum:newStatus.count];
//        
//        [refreshControl endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [refreshControl endRefreshing];
    }];
    }
}
- (void)showLoadNum:(NSInteger)count
{
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UILabel *label = [[UILabel alloc] init];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    if (count == 0) {
        label.text = @"没有微博数据加载";
    }
    else{
        label.text = [NSString stringWithFormat:@"加载了%ld条微博",count];
    }
    CGFloat timeInterval = 1.0;
    CGFloat delay = 1.0;
    [UIView animateWithDuration:timeInterval animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, 64);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:timeInterval delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
        }];
        
    }];
    
    
}
//
- (void)loadNewStatus
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *path = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    LSPAccount *account = [LSPAccountTool account];
    params[@"access_token"] = account.access_token;
   
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        
        NSArray *statuses = responseObject[@"statuses"];
        
//        for (NSDictionary *dict in statuses) {
//            
//            LSPStatus *status = [LSPStatus statusWithDict:dict];
//            [self.dataSource addObject:status];
//        }
        NSArray *newStatus = [LSPStatus objectArrayWithKeyValuesArray:statuses];
        NSArray *status = [self statusFrameFromNewArray:newStatus];
        
        [self.statusFrames addObjectsFromArray:status];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
- (void)navigationInfoRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    NSString *path = @"https://api.weibo.com/2/users/show.json";
    LSPAccount *account = [LSPAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
/**************************************************/
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
       LSPUser *user = [LSPUser objectWithKeyValues:responseObject];
        
        //
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        account.name = user.name;
        [LSPAccountTool saveAccount:account];
       // [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)setStyleNavigationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self selector:@selector(leftBtnClick) image:@"navigationbar_friendsearch" selectedImage:@"navigationbar_friendsearch_highlighted"];
   self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self selector:@selector(rightBtnClick) image:@"navigationbar_pop" selectedImage:@"navigationbar_pop_highlighted"];
    

    LSPTitleButton *titleBtn = [[LSPTitleButton alloc] init];
    [titleBtn addTarget:self action:@selector(popMenu:) forControlEvents:UIControlEventTouchUpInside];
     NSString *name = [LSPAccountTool account].name;
    NSLog(@"name = %@",name);
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];

    self.navigationItem.titleView = titleBtn;
}

- (void)leftBtnClick
{
    
}

- (void)rightBtnClick
{
    
}

- (void)dropdownMenuDidShow:(LSPDropdownMenu *)menu
{
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = NO;
}
- (void)dropdownMenuDidDismiss:(LSPDropdownMenu *)menu
{
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = YES;
}
- (void)popMenu:(UIButton *)titleBtn
{
    
    LSPDropdownMenu *menu = [LSPDropdownMenu dropdownMenu];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.width = 130;
    btn.height = 300;
    btn.backgroundColor = [UIColor blueColor];
    menu.content = btn;
    menu.delegate = self;
    [menu showFrom:titleBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    LSPStatus *status = self.dataSource[indexPath.row];
    LSPUser *user = status.user;
    
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = status.text;
     // NSString *imageUrl = user.profile_name_url;
     UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
     [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placeholder];
    */
    LSPStatusCell *cell = [LSPStatusCell statusCellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
  
    
    return cell;
}
/**
 *  每行cell的高度
 *
 * 
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}
/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    LSPAccount *account = [LSPAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    LSPStatusFrame *lastStatus = [self.statusFrames lastObject];
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    void (^defaultStatus)(NSArray *) = ^(NSArray *statues){
        // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFrameFromNewArray:statues];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        
        self.tabBarItem.badgeValue = nil;
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    };
    //先到沙盒中取数据{
    
    NSArray *statues = [LSPStatusTool statusWithParams:params];
    if (statues.count) {
        defaultStatus(statues);
    }else{
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [LSPStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        [LSPStatusTool saveStatus:newStatuses];
        defaultStatus(newStatuses);
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
