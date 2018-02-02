//
//  ForGetPassWordViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/5.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "ForGetPassWordViewController.h"
#import "SaveNewPasswordViewController.h"
#import "PhoneClass.h"
#import "UIWindow+YzdHUD.h"

static int theCodeButton_Size=0;
static int theCodeButton_Size_h=0;

@interface ForGetPassWordViewController ()

@end

@implementation ForGetPassWordViewController
static int theFont;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theCodeButton_Size=80;
        theCodeButton_Size_h=30;
        
        theFont=14;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theCodeButton_Size=80;
        

        theCodeButton_Size_h=30;

        theFont=14;
        
    }else if (IS_IPHONE_6) {  // 6
      
        theCodeButton_Size=100;
        theCodeButton_Size_h=35;
        
        theFont=16;

        
    }else if (IS_IPHONE_6P) {  // 6P
        
        theCodeButton_Size=100;
        theCodeButton_Size_h=35;
        theFont=16;
       
    }

   self.title=@"忘记密码";
    

    
}
//获取验证码
-(void)getCodeAction
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *phone=_thePhoneText.text;
    PhoneClass *phoneCla=[[PhoneClass alloc] init];
    NSLog(@"dic=%@",dic);
    if (phone.length!=0) {
        if ([phoneCla phone:phone]==YES) {
            [self.view.window showHUDWithText:@"发送成功" Type:ShowPhotoYes Enabled:YES];
            
            index=60;
            
            codeButton.backgroundColor = [UIColor grayColor];
            [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(GetActionTime:) userInfo:nil repeats:YES];
            
            HttpRequestCalss *httpReq=[HttpRequestCalss sharnInstance];
            httpReq.delegate=self;
            NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1003\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"username\":\"%@\",\"apptype\":\"1\",\"language\":\"1\"}",dateString,phone];
            [httpReq httpRequest:strJson];
        }else{
            [self.view.window showHUDWithText:@"号码格式不正确" Type:ShowPhotoNo Enabled:YES];
        }
    }else{
        [self.view.window showHUDWithText:@"请输入手机号码" Type:ShowPhotoNo Enabled:YES];
    }
    
}
//重置
- (void)getCodeButtonAction {
    
    NSString *phone=_thePhoneText.text;
    NSString *codePass=_thePassWordText.text;
    
    PhoneClass *phoneCla=[[PhoneClass alloc] init];
    
    if (phone.length!=0) {
            
        if ([phoneCla phone:phone]==YES) {
            
            if (codePass.length<5) {
                
                [self.view.window showHUDWithText:@"验证码错误" Type:ShowPhotoNo Enabled:YES];
                
            }else{

                HttpRequestCalss *httpReq=[HttpRequestCalss sharnInstance];
                httpReq.delegate=self;
                NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1009\",\"errcode\":\"000\",\"timestamp\":\"137889283\",\"mobile\":\"%@\",\"apptype\":\"2\",\"validcode\":\"%@\",\"language\":\"1\"}",phone,codePass];
                [httpReq httpRequest:strJson];
                
            }
        }else{
            [self.view.window showHUDWithText:@"号码格式不正确" Type:ShowPhotoNo Enabled:YES];
        }

    }else{
        [self.view.window showHUDWithText:@"请输入手机号码" Type:ShowPhotoNo Enabled:YES];
    }
    
}
//重置界面
-(void)toSaveViewCtrAction
{
    SaveNewPasswordViewController *saveViewCtr=[[SaveNewPasswordViewController alloc] init];
    saveViewCtr.phoneStr=_thePhoneText.text;
    [self.navigationController pushViewController:saveViewCtr animated:YES];
    
}
//页面消失，进入后台不显示该页面.
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //离开界面时给dic赋空值
    dic=[[NSDictionary alloc] initWithObjectsAndKeys:@"",@"", nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
} //section 包含的cell 行数row

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"indexPath=%ld",(long)indexPath.row);
    static NSString *cellIdentifier = @"myCell";
    UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tabCell == nil) {
        tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.row==0) {
            //手机号码
            _thePhoneText=[[UITextField alloc] initWithFrame:CGRectMake(30, (theTableView_rowH_Size-40)/2, 400, 40)];
            _thePhoneText.font=[UIFont systemFontOfSize:theFont];
            _thePhoneText.leftViewMode = UITextFieldViewModeAlways;
            _thePhoneText.backgroundColor=[UIColor clearColor];
            _thePhoneText.delegate=self;
            _thePhoneText.placeholder=@"请输入手机号码";
            _thePhoneText.borderStyle=UITextBorderStyleNone;
            _thePhoneText.keyboardType=UIKeyboardTypeNumberPad;
            _thePhoneText.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_thePhoneText];
           
        }
        if (indexPath.row==1) {
            //手机号码
            _thePassWordText=[[UITextField alloc] initWithFrame:CGRectMake(30, (theTableView_rowH_Size-40)/2, 400, 40)];
            _thePassWordText.font=[UIFont systemFontOfSize:theFont];
            _thePassWordText.leftViewMode = UITextFieldViewModeAlways;
            _thePassWordText.backgroundColor=[UIColor clearColor];
            _thePassWordText.delegate=self;
            _thePassWordText.leftViewMode = UITextFieldViewModeAlways;
            _thePassWordText.placeholder=@"请输入验证码";
            _thePassWordText.borderStyle=UITextBorderStyleNone;
            _thePassWordText.clearsOnBeginEditing=YES;
            _thePassWordText.keyboardType=UIKeyboardTypeNumberPad;
           //_thePassWordText.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_thePassWordText];
            
            codeButton=[UIButton buttonWithType:UIButtonTypeCustom];
            codeButton.backgroundColor=PublieCorlor;
            codeButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
            [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            codeButton.frame=CGRectMake(theWidth-theCodeButton_Size-40, ((theTableView_rowH_Size-40)/2)/2, theCodeButton_Size, theCodeButton_Size_h);
            [codeButton addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside ];
            [_thePassWordText addSubview:codeButton];
            //  设置UIView圆角
            codeButton.layer.cornerRadius=4;
            //    如果父元素溢出 子元素将父元素剪切
            codeButton.layer.masksToBounds=YES;
            
        }else if (indexPath.row==2){
            
            UIButton *getCodeButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            getCodeButton.backgroundColor=PublieCorlor;
            getCodeButton.frame=CGRectMake(10,( theTableView_rowH_Size-40),theWidth-20 , 38);
            getCodeButton.titleLabel.font=[UIFont systemFontOfSize:16];
            [getCodeButton setTitle:@"下一步" forState:UIControlStateNormal];
            [getCodeButton addTarget:self action:@selector(getCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tabCell addSubview:getCodeButton];
            getCodeButton.layer.cornerRadius=8;
            getCodeButton.layer.masksToBounds=YES;
            
        }
    }
    
    return tabCell;
} //cell 创建单元格

-(void)GetActionTime:(NSTimer *)timer
{
    
    index--;
    
    NSLog(@"index=%d",index);
    
    if (index==0) {
        
        codeButton.backgroundColor=PublieCorlor;
        [codeButton setTitle:[[NSString alloc] initWithFormat:@"重新获取"] forState:UIControlStateNormal];
        codeButton.enabled=YES;
        [timer invalidate];
        
    }else{
        
        [codeButton setTitle:[[NSString alloc] initWithFormat:@"请等待%d秒",index] forState:UIControlStateNormal];
        codeButton.enabled=NO;
        
    }
    
    
}


static int theTableView_rowH_Size;

#pragma  mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theTableView_rowH_Size=50;
        
        if (indexPath.row==2) {
            
            return 400;
        }
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theTableView_rowH_Size=50;
        
        if (indexPath.row==2) {
            
            return 400;
        }
        
    }else if (IS_IPHONE_6) {  // 6
        
        theTableView_rowH_Size=60;
        
        if (indexPath.row==2) {
            
            return 470;
        }
        
    }else if (IS_IPHONE_6P){
        
        theTableView_rowH_Size=60;
        
        if (indexPath.row==2) {
            
            return 540;
        }
        
    }
    
    return theTableView_rowH_Size;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView==_thetable) {
        
        [_thePhoneText resignFirstResponder];
        
        [_thePassWordText resignFirstResponder];

    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}



#pragma mark UITextFieldDelegate
//点击空白隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if (textField==_thePassWordText||textField==_thePhoneText) {
        [_thePhoneText resignFirstResponder];
        [_thePassWordText resignFirstResponder];
    }
    return YES;
}
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
    if (_thePassWordText==textField) {
        
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 5) {
            return NO;
        }

    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (textField==_thePhoneText) {
        NSLog(@"编辑结束");
    }
}

#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    NSLog(@"委托后的数据：%@",dic);
    //验证验证吗
    if (COMMANDINT==COMMAND1010) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            [self performSelector:@selector(toSaveViewCtrAction) withObject:nil afterDelay:1.5];
            
        }else{
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
            
        }
        
        
    }else{
        
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
    }

}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
   // NSLog(@"error = %@",error);
    [self.view.window showHUDWithText:@"网络异常" Type:ShowPhotoNo Enabled:YES];

}


@end
