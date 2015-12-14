//
//  LSPComposeViewController.m
//  微视界
//
//  Created by mac on 15-11-6.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPComposeViewController.h"
#import "LSPAccountTool.h"
#import "UIView+Extension.h"
#import "LSPEmotionTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "LSPComposeToolbar.h"
#import "LSPComposePhotosView.h"
#import "LSPEmotionKeyboard.h"
#import "LSPEmotion.h"
@interface LSPComposeViewController ()<UITextViewDelegate,LSPComposeToolbarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,weak) LSPEmotionTextView *textView;
@property (nonatomic,weak) LSPComposeToolbar *toolbar;
@property (nonatomic,weak) LSPComposePhotosView *photosView;
@property (strong,nonatomic) LSPEmotionKeyboard *emotionKeyboard;
@property (assign,nonatomic) CGFloat keyboardHeight;
@property (assign,nonatomic) BOOL isSwitchKeyboard;
@end

@implementation LSPComposeViewController

- (LSPEmotionKeyboard *)emotionKeyboard
{
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [[LSPEmotionKeyboard alloc] init];
        _emotionKeyboard.width = self.view.width;
        _emotionKeyboard.height = self.keyboardHeight;

    }
    return _emotionKeyboard;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationBar];
   
    [self setupTextView];
    
    [self addComposeToolbar];
    
    [self addPhotosView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
     NSString *prefix = @"发微博";
     NSString *subfix = [LSPAccountTool account].name;
    if (subfix) {
    UILabel *titleView = [[UILabel alloc] init];
    titleView.width = 150;
    titleView.height = 44;
    titleView.numberOfLines = 0;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.backgroundColor = [UIColor redColor];
    
    NSString *title = [NSString stringWithFormat:@"%@\n%@",prefix,subfix];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:title];
    
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [attr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[title rangeOfString:prefix]];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[title rangeOfString:subfix]];
    titleView.attributedText = attr;
    self.navigationItem.titleView = titleView;
    }else
    {
        self.title = prefix;
    }
    
    
}

- (void)addComposeToolbar
{
    LSPComposeToolbar *toolbar = [[LSPComposeToolbar alloc] init];
    toolbar.height = 44;
    toolbar.width = self.view.width;
    toolbar.x = 0;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}
- (void)setupTextView
{
    LSPEmotionTextView *textView = [[LSPEmotionTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
  
    textView.placeholder = @"分享新鲜事…";
   // textView.placeholderColor = [UIColor blueColor];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:textView];
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //监听按钮被点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidselect:) name:@"LSPEmotionDidSelectedNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteTextContent) name:@"LSPEmotionPageDeleteNotification" object:nil];
    [self.view addSubview:textView];
    self.textView = textView;
}
- (void)deleteTextContent
{
    [self.textView deleteBackward];
}

- (void)emotionDidselect:(NSNotification *)notification
{
    LSPEmotion *emotion = notification.userInfo[@"emotionDidSelected"];
    [self.textView insertEmotion:emotion];
}
- (void)addPhotosView
{
    LSPComposePhotosView *photosView = [[LSPComposePhotosView alloc] init];
    photosView.y = 100;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if(self.isSwitchKeyboard) return;
    /*
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 315}, {320, 253}},
     UIKeyboardCenterEndUserInfoKey = NSPoint: {160, 694.5},
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {320, 253}},
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 568}, {320, 253}},
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {160, 441.5},
     UIKeyboardAnimationCurveUserInfoKey = 7
     }
     */
    
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        
        self.toolbar.y = keyboardRect.origin.y - self.toolbar.height;
        
    }];
}

- (void)textDidChanged
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    if (self.photosView.photos.count) {
        [self sendStatusWithImage];
    }else
    {
        [self sendStatusWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)sendStatusWithoutImage
{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	pic false binary 微博的配图。*/
    /**	access_token true string*/
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *dicts = [NSMutableDictionary dictionary];
    dicts[@"access_token"] = [LSPAccountTool account].access_token;
    dicts[@"status"] = self.textView.fullText;
    
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:dicts success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD showError:@"发送失败"];
    }];

}

- (void)sendStatusWithImage
{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *dicts = [NSMutableDictionary dictionary];
    dicts[@"access_token"] = [LSPAccountTool account].access_token;
    dicts[@"status"] = self.textView.fullText;

    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:dicts constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITextViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}

#pragma LSPComposeToolbarDelegate
- (void)composeToolbar:(LSPComposeToolbar *)toolbar didClickedButtonType:(LSPComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
            
        case LSPComposeToolbarButtomTypeCamera:
            [self openCamera];
            break;
            
        case LSPComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
            
        case LSPComposeToolbarButtonTypeMention:
            
            break;
            
        case LSPComposeToolbarButtonTypeTrend:
            
            break;
            
        case LSPComposeToolbarButtonTypeEmotion:
            [self switchEmotionKeyboard];
            break;
            
        default:
            break;
    }
}

- (void)switchEmotionKeyboard
{
    
    if (self.textView.inputView == nil) {
        
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.isShowKeyboardButton = YES;
    }else
    {
        self.textView.inputView = nil;
        self.toolbar.isShowKeyboardButton = NO;
    }
    self.isSwitchKeyboard = YES;
    
    [self.textView resignFirstResponder];
    
    self.isSwitchKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
        
    });
}
- (void)openCamera
{
    [self getImageWithstyle:UIImagePickerControllerSourceTypeCamera];
}
- (void)openAlbum
{
    [self getImageWithstyle:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)getImageWithstyle:(UIImagePickerControllerSourceType)type
{
    
    if(![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = type;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:image];
}
@end
