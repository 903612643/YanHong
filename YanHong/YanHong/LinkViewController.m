//
//  LinkViewController.m
//  YanHong
//
//  Created by anbaoxing on 16/3/25.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "LinkViewController.h"
#import "UIWindow+YzdHUD.h"

@interface LinkViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_queue_create("YH", nil);
    //创建异步线程
    dispatch_async(queue, ^{
        
        [self httpData];
        
        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self setUpView];
            
        });
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

//线程方法
-(void)httpData
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //进入下载我的客户信息
    
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1097\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"apptype\":\"1\",\"keyname\":\"%@\",\"projectid\":\"%@\"}",dateString,_keyName,_projectID];
    
    //post 请求
    
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
    
}

- (void)setUpView {
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, theWidth, 200)];
    lable.backgroundColor=[UIColor colorWithRed:34/255.0 green:37/255.0 blue:38/255.0 alpha:1];
    lable.text=@"";
    lable.textColor=[UIColor whiteColor];
    [self.view addSubview:lable];
    
    UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, theWidth, 20)];
    lable1.text=@"网页由 www.yanhongw.com 提供";
    [lable1 bringSubviewToFront:lable];
    lable1.alpha=0.6;
    lable1.font=[UIFont systemFontOfSize:12];
    lable1.textAlignment=NSTextAlignmentCenter;
    lable1.textColor=[UIColor whiteColor];
    [lable addSubview:lable1];
    
    _webView = [[UIWebView alloc] init];
    _webView.frame = CGRectMake(0, 0, theWidth, theHeight-64);
    _webView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_webView];
}

-(void)popAction{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

#pragma mark HttpRequestClassDelegate

-(void)dissActon
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:json];
    NSLog(@"%@",dict);
    if ([dict[@"errcode"] isEqualToString:@"000"]) {
        
        NSURL *url = [[NSURL alloc] initWithString:dict[@"url"]];
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
        [_webView loadRequest:urlRequest];
        
        
    }else {
        
        [self alertViewWithMessage:[dict objectForKey:@"errmsg"]];
        
    }
    
}

-(void)alertViewWithMessage:(NSString *)msg{
    //初始化UIAlertController
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    //定义一个UIAlertAction
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    //添加到UIAlertController
    [alertC addAction:action];
    //实现跳转
    [self presentViewController:alertC animated:YES completion:nil];
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
