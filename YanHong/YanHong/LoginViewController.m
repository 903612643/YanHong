//
//  IndexViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/2.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "LoginViewController.h"
#import "RegsiterViewController.h"
#import "ForGetPassWordViewController.h"
#import "PhoneClass.h"
#import "UIWindow+YzdHUD.h"
#import "SetPassWordViewController.h"
#import "MiddlemanViewController.h"
#import "YH_DiscoverViewController.h"
#import "NSString+MD5.h"
#import "RootViewController.h"

//子视图初始值
static int firstSubView_Size=0;
static int wid_Size=0;

static int button_size_w;
static int TheSize;
static int Logbutton_size_w;
static int Logbutton_size_h;
static int Regbutton_size_w;
static int Regbutton_size_h;
static int TextFiled_size_h;

@interface LoginViewController()

@end

@implementation LoginViewController

static int theFont;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        firstSubView_Size =150;
        button_size_w=145;
        wid_Size=10;
        
        
        TheSize=250;
        Logbutton_size_w=150;
        Logbutton_size_h=38;
        Regbutton_size_h=38;
        Regbutton_size_w=90;
        TextFiled_size_h=50;
        
        theFont=14;
        
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        firstSubView_Size=220;
        wid_Size=10;
        button_size_w=145;
        
        
        TheSize=250;
        Logbutton_size_w=150;
        Logbutton_size_h=38;
        Regbutton_size_h=38;
        Regbutton_size_w=90;
        TextFiled_size_h=60;
        
        theFont=14;
        
        
    }else if (IS_IPHONE_6) {  // 6
        
        firstSubView_Size =220;
        wid_Size=10;
        TheSize=300;
        
        button_size_w=190;
        Logbutton_size_w=180;
        Logbutton_size_h=44;
        Regbutton_size_h=44;
        Regbutton_size_w=110;
        TextFiled_size_h=60;
        
        theFont=18;
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        firstSubView_Size=220;
        wid_Size=10;
        button_size_w=190;
        
        TheSize=300;
        Logbutton_size_w=180;
        Logbutton_size_h=44;
        Regbutton_size_h=44;
        Regbutton_size_w=110;
        TextFiled_size_h=60;
        
        theFont=18;
        
        
    }
    //登录View
    [self createView];
    
    //圆角
    //    获取self.view 的layer层
    layer =  self.view.layer;
    //    创建CALayer 对象
    layer1 = [[CALayer alloc] init];
    [layer addSublayer:layer1];
    //  设置UIView圆角
    LoginButton.layer.cornerRadius = 8;
    returnButton.layer.cornerRadius = 8;
    subView.layer.cornerRadius=8;
    regButton1.layer.cornerRadius=8;
    //    如果父元素溢出 子元素将父元素剪切
    LoginButton.layer.masksToBounds=YES;
    returnButton.layer.masksToBounds=YES;
    subView.layer.masksToBounds=YES;
    regButton1.layer.masksToBounds = YES;
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame=CGRectMake(0,0,30,30);
    [button1 setTitle:@"×" forState:UIControlStateNormal];
    button1.titleLabel.font=[UIFont systemFontOfSize:35];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(dismissHomeAction) forControlEvents: UIControlEventTouchUpInside ];
    UIBarButtonItem *rigItem1=[[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem=rigItem1;
    
}
-(void)dismissHomeAction
{

    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//登录View
-(void)createView
{
    firstView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
    firstView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:firstView];
    
    firstSubView=[[UIView alloc] initWithFrame:CGRectMake(0, firstSubView_Size, theWidth, 48)];
    firstSubView.backgroundColor=[UIColor clearColor];
    [firstView addSubview:firstSubView];
    
    //手机号码
    _phoneTestField1=[[UITextField alloc] initWithFrame:CGRectMake((theWidth-TheSize)/2, TextFiled_size_h, TheSize, 44)];
    _phoneTestField1.font=[UIFont systemFontOfSize:theFont];
   
    _phoneTestField1.leftViewMode = UITextFieldViewModeAlways;
    _phoneTestField1.placeholder=@"请输入手机号码";
    _phoneTestField1.borderStyle=UITextBorderStyleRoundedRect;
   // _phoneTestField.clearsOnBeginEditing=YES;
    _phoneTestField1.delegate=self;
    _phoneTestField1.keyboardType=UIKeyboardTypePhonePad;
    _phoneTestField1.clearButtonMode=UITextFieldViewModeWhileEditing;
    [firstView addSubview:_phoneTestField1];
    //密码
    _passWrodTestField=[[UITextField alloc] initWithFrame:CGRectMake((theWidth-TheSize)/2, TextFiled_size_h*2, TheSize, 44)];
   // _passWrodTestField.backgroundColor=[UIColor grayColor];
   
    _passWrodTestField.font=[UIFont systemFontOfSize:theFont];
    _passWrodTestField.leftViewMode = UITextFieldViewModeAlways;
    _passWrodTestField.placeholder=@"请输入密码";
    _passWrodTestField.borderStyle=UITextBorderStyleRoundedRect;
   // _passWrodTestField.clearsOnBeginEditing=YES;
    _passWrodTestField.delegate=self;
    _passWrodTestField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    _passWrodTestField.secureTextEntry = YES; //密文
  //  _passWrodTestField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [firstView addSubview:_passWrodTestField];
    
    _phoneTestField1.text=[[NSUserDefaults standardUserDefaults]  objectForKey:@"username"];
    _passWrodTestField.text=[[NSUserDefaults standardUserDefaults]  objectForKey:@"password"];
    
    UIView* view1 = [[UIView alloc]initWithFrame:CGRectMake(10,0,20,0)];
    _phoneTestField1.leftView=view1;
    UIView* view2 = [[UIView alloc]initWithFrame:CGRectMake(10,0,20,0)];
    _passWrodTestField.leftView=view2;
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 15, 20)];
    imageView.image=[UIImage imageNamed:@"login1"];
    [_phoneTestField1 addSubview:imageView];
    
    UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 15, 20)];
    imageView1.image=[UIImage imageNamed:@"pass"];
    [_passWrodTestField addSubview:imageView1];
    
    //忘记密码
    //创建button
    UIButton *button=[[UIButton alloc ] initWithFrame:CGRectMake(button_size_w, 4, 120, 36)];
    [button setTitleColor:[UIColor colorWithRed:229/255.0 green:24/255.0 blue:29/225.0 alpha:1] forState:UIControlStateNormal];
    button.frame=CGRectMake(button_size_w, 4, 120, 36);
    button.titleLabel.font=[UIFont systemFontOfSize:theFont];
    [button setTitle:@"忘记密码?" forState:UIControlStateNormal ];
    [button addTarget: self action:@selector(forgetPassAction) forControlEvents:UIControlEventTouchUpInside];
    button.alpha=1;
    [_passWrodTestField addSubview:button];
    //登录button
    LoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    LoginButton.backgroundColor=PublieCorlor;
    [LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    LoginButton.frame=CGRectMake((theWidth-TheSize)/2, 2, Logbutton_size_w,Logbutton_size_h);
    LoginButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [LoginButton setTitle:@"登录" forState:UIControlStateNormal ];
    [LoginButton addTarget:self action:@selector(LoginAction1) forControlEvents: UIControlEventTouchUpInside ];
    [firstSubView addSubview:LoginButton];

    
    regButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    regButton1.layer.borderWidth = 1;
    regButton1.layer.borderColor = PublieCorlor.CGColor;
    regButton1.layer.cornerRadius = 6;
    regButton1.titleLabel.font=[UIFont systemFontOfSize:16];
    [regButton1 setTitleColor:PublieCorlor forState:UIControlStateNormal];
    regButton1.frame=CGRectMake((theWidth-TheSize)/2+Logbutton_size_w+wid_Size, 2, Regbutton_size_w,Regbutton_size_h);
    [regButton1 setTitle:@"注册" forState:UIControlStateNormal ];
    [regButton1 addTarget:self action:@selector(regAction) forControlEvents: UIControlEventTouchUpInside ];
    [firstSubView addSubview:regButton1];
    
}
//页面消失，进入后台不显示该页面.
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //离开界面时给dic赋空值
    dic=nil;
}
//登录
-(void)LoginAction1
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *phone=_phoneTestField1.text;
    NSString *passWord=_passWrodTestField.text;
    NSString *md5PassStr=[passWord md5String];
    PhoneClass *phoneCtr=[[PhoneClass alloc] init];
    
    if (phone.length!=0) {
        if( [phoneCtr phone:phone]==YES) {
            if (passWord.length==0) {
                [self.view.window showHUDWithText:@"密码不能为空" Type:ShowPhotoNo Enabled:YES];
            }else{
                
                [self.view.window showHUDWithText:@"正在登录..." Type:ShowLoading Enabled:YES];

                
                self.tabBarController.tabBar.hidden=YES;
                
                _theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
                _theView.backgroundColor=[UIColor blackColor];
                _theView.tag=101;
                _theView.alpha=0.2;
                [self.view addSubview:_theView];
                
                //手机号码正确，请求数据
                NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1005\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"logintype\":\"1\",\"username\":\"%@\",\"loginpwd\":\"%@\",\"apptype\":\"2\",\"language\":\"1\"}",dateString,phone,md5PassStr];
                
                httpRequest=[[HttpRequestCalss alloc] init];
                
                NSString *url1=[NSString stringWithFormat:THE_POSTURL];
                
                httpRequest.delegate=self;
                
                [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
                    
                } fail:^{
                    
                }];
                
            }
            
        }else{
            //提示
            [self.view.window showHUDWithText:@"号码格式不正确" Type:ShowPhotoNo Enabled:YES];
        }
    }else{
        
        [self.view.window showHUDWithText:@"请输入手机号码" Type:ShowPhotoNo Enabled:YES];
    }
}
-(void)loginSuccessAction
{
 
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//注册
-(void)regAction
{
    RegsiterViewController *regView=[[RegsiterViewController alloc] init];
    regView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:regView animated:YES];
    
}
//忘记密码
-(void)forgetPassAction
{
    
    ForGetPassWordViewController *forViewCtr=[[ForGetPassWordViewController alloc] init];
    forViewCtr.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:forViewCtr animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITextFieldDelegate
//点击空白隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    
    if (_phoneTestField1==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    if (_passWrodTestField==textField) {
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

#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
     NSLog(@"委托后的数据：%@",dic);
 
    if(COMMANDINT==COMMAND1006){
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //登陆成功后把用户名和密码存储到UserDefault
            [userDefaults setObject:[dic objectForKey:@"uid"] forKey:@"uid"];
            
            //登陆成功后把用户名和密码存储到UserDefault
            [userDefaults setObject:_phoneTestField1.text forKey:@"username"];
            
            [userDefaults setObject:_passWrodTestField.text forKey:@"password"];
            
            if (![[dic objectForKey:@"headpicture"] isKindOfClass:[NSNull class]] ) {
                
                [userDefaults setObject:[dic objectForKey:@"headpicture"] forKey:@"headpicture"];
                
            }
            if (![[dic objectForKey:@"nickname"] isKindOfClass:[NSNull class]]){
                
                [userDefaults setObject:[dic objectForKey:@"nickname"] forKey:@"nickname"];
            }
            
            [userDefaults synchronize];
            
            
            //登录成功,延时1秒进入
            [self performSelector:@selector(loginSuccessAction) withObject:nil afterDelay:1];
            
        }else{
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
            
//            [self dismissViewControllerAnimated:YES completion:^{
//                
//            }];
            
        }
        
    }else{
        
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
        
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
        
       
    }
    
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
    }
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
    }
    
    [self.view.window showHUDWithText:@"断开连接" Type:ShowPhotoNo Enabled:YES];
}

@end
