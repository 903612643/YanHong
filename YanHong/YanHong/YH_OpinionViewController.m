//
//  YH_OpinionViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/3/11.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_OpinionViewController.h"
#import "UIWindow+YzdHUD.h"

@interface YH_OpinionViewController ()

@end

@implementation YH_OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    _textView=[[UITextView alloc] initWithFrame:CGRectMake(2, 0, theWidth-4, 150)];
    _textView.delegate=self;
    _textView.font=[UIFont systemFontOfSize:15];
    _textView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:_textView];
    
    lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 6, theWidth-10, 20)];
    lable.text=@"请提交您要反馈的内容";
    lable.font=[UIFont systemFontOfSize:14];
    lable.alpha=0.4;
    [_textView addSubview:lable];
    
    UIButton *commitButton=[[UIButton alloc] initWithFrame:CGRectMake(15, 170, theWidth-30, 38)];
    commitButton.layer.cornerRadius=6;
    commitButton.layer.masksToBounds=YES;
    [commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    commitButton.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    commitButton.backgroundColor=PublieCorlor;
    [self.view addSubview:commitButton];
    
    UIButton *phoneButton=[[UIButton alloc] initWithFrame:CGRectMake(15, 245, theWidth-30, 38)];
    phoneButton.layer.cornerRadius=6;
    phoneButton.layer.masksToBounds=YES;
    [phoneButton addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    phoneButton.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    [phoneButton setTitle:@"客服电话：400-9977-971" forState:UIControlStateNormal];
    phoneButton.backgroundColor=[UIColor colorWithRed:83/255.0 green:172/255.0 blue:97/255.0 alpha:1];
    [self.view addSubview:phoneButton];
    
    
}
-(void)altActon
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitAction
{
    
    if (_textView.text.length==0) {
        
        [self.view.window showHUDWithText:@"不要偷懒，写点东西哦" Type:ShowPhotoNo Enabled:YES];
        
    }else{

        //当前时间
        NSDate *date=[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSS";
        NSString *dateString = [formatter stringFromDate:date];
        
        //佣金细则
        NSString *strJson2 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1089\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"feedback\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],_textView.text];
        
        //postter
        httpReq=[[HttpRequestCalss alloc] init];
        
        NSString *url2=[NSString stringWithFormat:THE_POSTURL];
        
        httpReq.delegate=self;
        
        [url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [httpReq postJSONWithUrl:url2 parameters:strJson2 success:^(id responseObject) {
            
        } fail:^{
            
        }];

        
        
    }
    
}

-(void)callAction
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-9977-971"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_textView.text.length==0) {
        
        lable.text=@"请提交您要反馈的内容";
    }
    
    [_textView resignFirstResponder];
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    
    lable.text=@"";
    
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView;
{
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if (_textView==textView) {
        
        if (_textView.text.length == 0)
            return YES;
        NSInteger existedLength = _textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = _textView.text.length;
        //限制长度
        if (existedLength - selectedLength + replaceLength > 1000) {
            return NO;
        }
        
    }
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    
    return YES;
}

#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
   NSDictionary *dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1090) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
            
            [self performSelector:@selector(popAction) withObject:nil afterDelay:1.5];
            
        }else{
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
        }
        
    }else{
        
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];

    }
    
}
-(void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    
}





@end
