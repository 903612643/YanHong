//
//  RegsiterViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/4.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "RegsiterViewController.h"
#import "LoginViewController.h"

#import "PhoneClass.h"
#import "UIWindow+YzdHUD.h"
#import "NSString+MD5.h"


static int theButton_w=0;
static int theTextF_h=0;
static int theFont;

@interface RegsiterViewController ()

@end


@implementation RegsiterViewController


static int codeButton_Size;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.title=@"注册";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theButton_w=230;
        theTextF_h=30;
        
        theFont=14;
        
        codeButton_Size=85;
        
      
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theTextF_h=30;
        theButton_w=230;
        
        theFont=14;
        
        codeButton_Size=85;
        
      
    }else if (IS_IPHONE_6) {  // 6
        
        theTextF_h=40;
        theButton_w=280;
        
        theFont=18;
        
        codeButton_Size=100;
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        theTextF_h=40;
        theButton_w=320;
        
        theFont=18;
        
        codeButton_Size=100;
    
      
    }
    
    _titleArr=[[NSMutableArray alloc] initWithObjects:
               @"手    机",
               @"密    码",
               @"姓    名",
               @"验证码",
               @"推荐人",
               @"",
               nil];

    
    httpReq=[HttpRequestCalss sharnInstance];
    httpReq.delegate=self;
    
    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    
}

-(void)popAction{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)mapAction
{
    self.tabBarController.hidesBottomBarWhenPushed=YES;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController popToRootViewControllerAnimated:YES];


}

-(void)openProWebView
{
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //佣金细则
    NSString *strJson2 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1019\",\"uid\":\"%@\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"keyname\":\"c105\",\"apptype\":\"2\"}",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],dateString];
    
    //postter
    httpReq=[[HttpRequestCalss alloc] init];
    
    NSString *url2=[NSString stringWithFormat:THE_POSTURL];
    
    httpReq.delegate=self;
    
    [url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpReq postJSONWithUrl:url2 parameters:strJson2 success:^(id responseObject) {
        
    } fail:^{
        
    }];

    self.title=@"全民经纪人注册协议";
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight+300)];
    view.backgroundColor=[UIColor blackColor];
    view.alpha=0.5;
    view.tag=100;
    [view bringSubviewToFront:_theTableVIew];
    [self.view addSubview:view];
    
    webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(20, 0, theWidth-40, theHeight-100);
    webView.delegate = self;
    webView.tag=101;
    [webView bringSubviewToFront:view];
    webView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:webView];
    
    UIButton *sureButton=[[UIButton alloc] initWithFrame:CGRectMake(0, theHeight-100-44, theWidth-40, 44)];
    sureButton.backgroundColor=[UIColor colorWithRed:35/255.0 green:40/255.0 blue:47/255.0 alpha:1];
    sureButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [sureButton addTarget:self action:@selector(sureProAction) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [webView addSubview:sureButton];
    
    
}

-(void)sureProAction
{
    self.title=@"注册";
    
    for (UIView *subView in [self.view subviews]) {
        
        if (subView.tag==101 ) {
            
            [subView removeFromSuperview];
        }
        if (subView.tag==100) {
            
            [subView removeFromSuperview];
            
        }
        
    }
    
}
static bool isAgree=YES;


-(void)imageArgeeAction

{
    if (isAgree==YES) {
        
        [imageButton setImage:[UIImage imageNamed:@"disagree"] forState:UIControlStateNormal];
        regButton.backgroundColor=PublieCorlor;
        regButton.enabled=YES;
        
        
        isAgree=NO;
        
        
    }else{
        
        [imageButton setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
        regButton.backgroundColor=[UIColor grayColor];
        regButton.enabled=NO;
        
        
        isAgree=YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"myCell";
    
    UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tabCell == nil) {
        tabCell = [[UITableViewCell alloc] initWithStyle:
                   UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        tabCell.accessoryType=UITableViewCellAccessoryNone;
        
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.row==0) {
            //手机号码
            _thePhoneText=[[UITextField alloc] initWithFrame:CGRectMake(100,  (theTableView_rowH_Size-theTextF_h)/2, theWidth-110, theTextF_h)];
            _thePhoneText.font=[UIFont systemFontOfSize:theFont];
            _thePhoneText.backgroundColor=[UIColor clearColor];
            _thePhoneText.delegate=self;
            _thePhoneText.leftViewMode = UITextFieldViewModeAlways;
            NSString *str=[[NSString alloc] initWithFormat:@"%@",@"请输入手机号码"];
            _thePhoneText.placeholder=str;
            _thePhoneText.borderStyle=UITextBorderStyleNone;
            _thePhoneText.clearsOnBeginEditing=YES;
            _thePhoneText.keyboardType=UIKeyboardTypePhonePad;
            _thePhoneText.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_thePhoneText];
            
        }else if (indexPath.row==1) {
            //密码
            _thePassWordText=[[UITextField alloc] initWithFrame:CGRectMake(100, (theTableView_rowH_Size-theTextF_h)/2, theWidth-110, theTextF_h)];
            _thePassWordText.font=[UIFont systemFontOfSize:theFont];
            _thePassWordText.backgroundColor=[UIColor clearColor];
            _thePassWordText.delegate=self;
            _thePassWordText.leftViewMode = UITextFieldViewModeAlways;
             NSString *str=[[NSString alloc] initWithFormat:@"%@",@"请输入6-16位密码"];
            _thePassWordText.placeholder=str;
            _thePassWordText.borderStyle=UITextBorderStyleNone;
            _thePassWordText.clearsOnBeginEditing=YES;
            _thePassWordText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _thePassWordText.secureTextEntry = YES; //密文
            _thePassWordText.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_thePassWordText];
            
        }else  if (indexPath.row==2) {
            //姓名
            _theTextField=[[UITextField alloc] initWithFrame:CGRectMake(100, (theTableView_rowH_Size-theTextF_h)/2, theWidth-110, theTextF_h)];
            _theTextField.font=[UIFont systemFontOfSize:theFont];
            _theTextField.backgroundColor=[UIColor clearColor];
            _theTextField.delegate=self;
            _theTextField.leftViewMode = UITextFieldViewModeAlways;
            NSString *str=[[NSString alloc] initWithFormat:@"%@",@"请输入姓名"];
            _theTextField.placeholder=str;
            _theTextField.borderStyle=UITextBorderStyleNone;
            _theTextField.clearsOnBeginEditing=YES;
            _theTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_theTextField];
            
        }else  if (indexPath.row==3) {
            //验证码
            _thePassText=[[UITextField alloc] initWithFrame:CGRectMake(100, (theTableView_rowH_Size-theTextF_h)/2, theWidth-100-90, theTextF_h)];
            _thePassText.backgroundColor=[UIColor clearColor];
            _thePassText.delegate=self;
            _thePassText.font=[UIFont systemFontOfSize:theFont];
            _thePassText.leftViewMode = UITextFieldViewModeAlways;
             NSString *str=[[NSString alloc] initWithFormat:@"%@",@"手机验证码"];
            _thePassText.placeholder=str;
            _thePassText.placeholder=@"请输入验证码";
            _thePassText.borderStyle=UITextBorderStyleNone;
            _thePassText.clearsOnBeginEditing=YES;
            _thePassText.keyboardType=UIKeyboardTypeNumberPad;
            _thePassText.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_thePassText];
            
            getTextButton=[UIButton buttonWithType:UIButtonTypeCustom];
            getTextButton.frame=CGRectMake(theButton_w-15, (theTableView_rowH_Size-theTextF_h)/2, codeButton_Size, theTextF_h);
            getTextButton.backgroundColor=PublieCorlor;
            [getTextButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            getTextButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
            [getTextButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted ];
            [getTextButton setTintColor:[UIColor whiteColor]];
            [getTextButton addTarget:self action:@selector(getAction) forControlEvents:UIControlEventTouchUpInside];
            //    获取self.view 的layer层
            layer =  self.view.layer;
            //    创建CALayer 对象
            layer1 = [[CALayer alloc] init];
            [layer addSublayer:layer1];
            //  设置UIView圆角
            getTextButton.layer.cornerRadius = 4;
            //    如果父元素溢出 子元素将父元素剪切
            getTextButton.layer.masksToBounds = YES;
            [tabCell addSubview:getTextButton];
            
        }else  if (indexPath.row==4) {
            //推荐人
            _theNameText=[[UITextField alloc] initWithFrame:CGRectMake(100, (theTableView_rowH_Size-theTextF_h)/2, theWidth-110, theTextF_h)];
            _theNameText.font=[UIFont systemFontOfSize:theFont];
            _theNameText.backgroundColor=[UIColor clearColor];
            _theNameText.delegate=self;
            _theNameText.leftViewMode = UITextFieldViewModeAlways;
            NSString *str=[[NSString alloc] initWithFormat:@"%@",@"推荐人姓名"];
            _theNameText.placeholder=str;
            _theNameText.borderStyle=UITextBorderStyleNone;
            _theNameText.clearsOnBeginEditing=YES;
            _theNameText.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_theNameText];
            
        }else if (indexPath.row==5){
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 2, theWidth-20, 20)];
            lable.text=@"请输入正确的推荐人姓名，没有则留空";
            lable.alpha=0.4;
            lable.font=[UIFont systemFontOfSize:12];
            [tabCell addSubview:lable];
            
            imageButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 35, 20, 20)];
            [imageButton setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
            [imageButton addTarget:self action:@selector(imageArgeeAction) forControlEvents:UIControlEventTouchUpInside];
            [tabCell addSubview:imageButton];
            
            proButton=[UIButton buttonWithType:UIButtonTypeCustom];
            proButton.frame=CGRectMake(35, 35, theWidth-20, 20);
            [proButton setTitle:@"我同意《全民经纪人注册协议》" forState:UIControlStateNormal];
            proButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            proButton.titleLabel.font=[UIFont systemFontOfSize:15];
            [proButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [proButton addTarget:self action:@selector(openProWebView) forControlEvents:UIControlEventTouchUpInside];
            
            [tabCell addSubview:proButton];
            
            
            regButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            regButton.backgroundColor=[UIColor grayColor];
            regButton.frame=CGRectMake(10, 80,theWidth-20 , 40);
            [regButton setTitle:@"注册" forState:UIControlStateNormal];
            [regButton addTarget:self action:@selector(regAction1) forControlEvents:UIControlEventTouchUpInside];
            [regButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            regButton.titleLabel.font=[UIFont systemFontOfSize:16];
            [tabCell addSubview:regButton];
            regButton.enabled=NO;
            regButton.layer.cornerRadius=8;
            regButton.layer.masksToBounds=YES;
            


        }
        
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, (theTableView_rowH_Size-theTextF_h)/2, 70, theTextF_h)];
        lable.backgroundColor=[UIColor clearColor];
        lable.font=[UIFont systemFontOfSize:theFont];
        lable.text=[_titleArr objectAtIndex:indexPath.row];
        lable.alpha=0.6;
        [tabCell addSubview:lable];
        
    }
    
    return tabCell;
    
} //cell 创建单元格

static int theTableView_rowH_Size;

#pragma  mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theTableView_rowH_Size=40;
        
        if (indexPath.row==5) {
            
            return 400;
        }
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theTableView_rowH_Size=40;
        
        if (indexPath.row==5) {
            
            return 400;
        }
        
    }else if (IS_IPHONE_6) {  // 6
        
        theTableView_rowH_Size=60;
        
        if (indexPath.row==5) {
            
            return 400;
        }
        
    }else if (IS_IPHONE_6P){
        
        theTableView_rowH_Size=60;
        
        if (indexPath.row==5) {
            
            return 400;
        }
    }
    
    return theTableView_rowH_Size;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 10;
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row==5) {
        
        [_theNameText resignFirstResponder];
        [_thePassText resignFirstResponder];
        [_thePassWordText resignFirstResponder];
        [_thePhoneText resignFirstResponder];
        [_theTextField resignFirstResponder];
        
    }
    

    
}


#pragma mark UITextFieldDelegate

//点击空白隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    
    [textField resignFirstResponder];
    
    return YES;
}

//文本长度限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    
    if (_thePhoneText==textField) {
        
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    
    }
    if (_thePassWordText==textField ) {
        
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 16) {
            return NO;
        }
    }
    if (_theTextField==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 32) {
            return NO;
        }
    }
    if (_thePassText==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 5) {
            return NO;
        }
    }
    if (_theNameText==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 16) {
            return NO;
        }
    }
    return YES;
}
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

//获取验证码
-(void)getAction
{
        NSString *phone=_thePhoneText.text;
        NSLog(@"获取验证码");
        PhoneClass *phoneCla=[[PhoneClass alloc] init];
    
    
    if (phone.length!=0) {
        
        if ([phoneCla phone:phone]==YES) {
            
            if (_theTextField.text.length!=0) {
                
                index=60;
                getTextButton.backgroundColor=[UIColor grayColor];
                [getTextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(GetActionTime:) userInfo:nil repeats:YES];
                
                [self.view.window showHUDWithText:@"发送成功" Type:ShowPhotoYes Enabled:YES];
                
                //当前时间
                NSDate *date=[NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmssSS";
                NSString *dateString = [formatter stringFromDate:date];
                
                
                NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1003\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"username\":\"%@\",\"apptype\":\"2\",\"language\":\"1\"}",dateString,phone];
                [httpReq httpRequest:strJson];
                
            }else{
                [self.view.window showHUDWithText:@"姓名不能为空" Type:ShowPhotoNo Enabled:YES];
            }
            
        }else{
            
            [self.view.window showHUDWithText:@"手机号码格式不正确" Type:ShowPhotoNo Enabled:YES];
            
            
        }
    }else{
        [self.view.window showHUDWithText:@"请输入手机号码" Type:ShowPhotoNo Enabled:YES];
    }
            
            
    
}
-(void)GetActionTime:(NSTimer *)timer
{
    
        index--;
    
        NSLog(@"index=%d",index);
    
        if (index==0) {
            
            getTextButton.backgroundColor=PublieCorlor;
            [getTextButton setTitle:[[NSString alloc] initWithFormat:@"重新获取"] forState:UIControlStateNormal];
            getTextButton.enabled=YES;
            [timer invalidate];
            
        }else{
            
            [getTextButton setTitle:[[NSString alloc] initWithFormat:@"请等待%d秒",index] forState:UIControlStateNormal];
            getTextButton.enabled=NO;
            
        }

    
}
//注册
- (void)regAction1{
    //获取文本
    NSString *phone=_thePhoneText.text;
    NSString *passWord=_thePassWordText.text;
    NSString *name=_theTextField.text;
    NSString *code=_thePassText.text;
    NSString *forName=_theNameText.text;
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    if (phone.length!=0) {
        //判断是否为手机号
        PhoneClass *phoneCla=[[PhoneClass alloc] init];
        
        if ([phoneCla phone:phone]==YES) {
            
            if (passWord.length!=0){
                
                if (passWord.length>=6 && passWord.length<=16) {
                    
                    if (name.length==0) {
                        
                        [self.view.window showHUDWithText:@"用户名不能为空" Type:ShowPhotoNo Enabled:YES];
                    }else{
                        if (code.length<5) {
                            [self.view.window showHUDWithText:@"验证码错误" Type:ShowPhotoNo Enabled:YES];
                            
                        }else{
                            
                            _theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
                            _theView.backgroundColor=[UIColor blackColor];
                            _theView.tag=101;
                            _theView.alpha=0.2;
                            [self.view addSubview:_theView];
                            
                            [self.view.window showHUDWithText:@"正在注册..." Type:ShowLoading Enabled:YES];
                            //请求数据
                            
                            NSString *md5PassStr=[passWord md5String];
                            
                            NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1001\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"username\":\"%@\",\"loginpwd\":\"%@\",\"name\":\"%@\",\"recommender\":\"%@\",\"logintype\":\"1\",\"apptype\":\"2\",\"language\":\"1\",\"validcode\":\"%@\"}",dateString,phone,md5PassStr,name,forName,code];
                            httpReq.delegate=self;
                            [httpReq httpRequest:strJson];
                        }
                        
                    }
                }
                else{
                    //失败提示
                    [self.view.window showHUDWithText:@"密码过于简单" Type:ShowPhotoNo Enabled:YES];
                }
            }else{
                [self.view.window showHUDWithText:@"密码不能为空" Type:ShowPhotoNo Enabled:YES];
            }
        }else{
            //失败提示
            [self.view.window showHUDWithText:@"手机号码格式不正确" Type:ShowPhotoNo Enabled:YES];
        }

    }else{
        [self.view.window showHUDWithText:@"请输入手机号码" Type:ShowPhotoNo Enabled:YES];
    }
    
}
-(void)toLoginViewCtrAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    NSLog(@"委托后的数据：%@",dic);

    
    if (dic.count>0||dic!=nil) {
        
        //提交的验证
        if (COMMANDINT==COMMAND1004) {
            
        
        }else if (COMMANDINT==COMMAND1002){
            
            if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
                
                for (UIView *subviews in [self.view subviews]) {
                    if (subviews.tag==101) {
                        [subviews removeFromSuperview];
                    }
                }
                
                [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
                //返回根视图
                [self performSelector:@selector(toLoginViewCtrAction) withObject:nil afterDelay:1.5];
                
                
            }else{
                
                for (UIView *subviews in [self.view subviews]) {
                    if (subviews.tag==101) {
                        [subviews removeFromSuperview];
                    }
                }
                
                [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
                
            }
            
            
            
        }else if (COMMANDINT==COMMAND1020){
            
             if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
                 
                    NSURL *Url =[NSURL URLWithString:[dic objectForKey:@"url"]];
                    
                    request = [[NSURLRequest alloc] initWithURL:Url];
                    
                    [webView loadRequest:request];
                 
                 
                }else{
                    
                    for (UIView *subviews in [self.view subviews]) {
                        if (subviews.tag==101) {
                            [subviews removeFromSuperview];
                        }
                    }
                    
                    [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
            }

            
        }else{
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
            
        }
        
    }else{
        
        [self.view.window showHUDWithText:@"网络繁忙，请稍后再试！" Type:ShowPhotoNo Enabled:YES];
        
    }
    
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
   // NSLog(@"error = %@",error);
    
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
    }
    [self.view.window showHUDWithText:@"网络已断开" Type:ShowPhotoNo Enabled:YES];
    
}



@end
