//
//  WebViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/5.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "WebViewController.h"
#import "UIWindow+YzdHUD.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
    
    webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 0, theWidth, theHeight-60);
    webView.delegate = self;
    [webView bringSubviewToFront:lable];
    webView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:webView];

    
    NSLog(@"_URLStr=%@",_HouesStr);
    
     //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    
    
    NSURL *url = [NSURL URLWithString:_HouesStr];
    request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
    
    
    

}

-(void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


@end
