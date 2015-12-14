//
//  LSPOAuthViewController.m
//  微视界
//
//  Created by mac on 15-10-30.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "LSPAccount.h"
#import "UIWindow+Extension.h"
#import "LSPAccountTool.h"
#import "LSPConst.h"
@interface LSPOAuthViewController()<UIWebViewDelegate>

@end
@implementation LSPOAuthViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     // 请求地址：https://api.weibo.com/oauth2/authorize
      请求参数：
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     
     新浪的开发者账号
     App Key：3948170479
     App Secret：39f56a133eb58148075a62553b2acd78
     */

     
    NSString *path = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=3948170479&redirect_uri=%@",LSPAppURL];
    
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    
    webView.delegate = self;
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中……"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = request.URL.absoluteString;
    
    NSLog(@"urlString = %@",urlString);
    
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length != 0) {
        
        NSInteger fromIndex = range.location + range.length;
        
        NSString *code = [urlString substringFromIndex:fromIndex];
        
        NSLog(@"code = %@",code);
        
        [self getAccessTokenWithCode:code];
        
        return NO;
    }
    
    
    return YES;
}

/*
 URL：https://api.weibo.com/oauth2/access_token
 
 请求参数：
 client_id：申请应用时分配的AppKey
 client_secret：申请应用时分配的AppSecret
 grant_type：使用authorization_code
 redirect_uri：授权成功后的回调地址
 code：授权成功后返回的code
 */

- (void)getAccessTokenWithCode:(NSString *)code
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *dicts = [NSMutableDictionary dictionary];
    dicts[@"client_id"] = @"3948170479";
    dicts[@"client_secret"] = @"39f56a133eb58148075a62553b2acd78";
    dicts[@"grant_type"] = @"authorization_code";
    dicts[@"redirect_uri"] = LSPAppURL;
    dicts[@"code"] = code;
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:dicts success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [MBProgressHUD hideHUD];
    NSDictionary *dict = responseObject;
        
    LSPAccount *account = [LSPAccount accountWithDict:dict];
        
        
        //保存到指定路径
        [LSPAccountTool saveAccount:account];
        
        //切换窗口的根控制器
        [UIWindow switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUD];
       
    }];
    
    /*
     
     "access_token" = "2.005pdTGGBVHM_E0c549487890ZF5bL";
     "expires_in" = 157679999;
     "remind_in" = 157679999;
     uid = 5592519622;
/Users/mac/Desktop/Lispeng/Day7/微视界/微视界/Class/OAuth/Users/mac/Desktop/Lispeng/Day7/微视界/微视界/Class/OAuth/Controller/LSPOAuthViewController.h/Controller/LSPOAuthViewController.h
     
     */
    
}

@end
