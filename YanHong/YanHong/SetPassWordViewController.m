//
//  SetPassWordViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/5.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "SetPassWordViewController.h"
#import "UIWindow+YzdHUD.h"

#import "NSString+MD5.h"

@interface SetPassWordViewController ()

@end

@implementation SetPassWordViewController

static int theFont;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theFont=14;
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theFont=14;
        
    }else if (IS_IPHONE_6) {  // 6
        
        theFont=18;

    }else if (IS_IPHONE_6P) {  // 6P
        
        theFont=18;
 
    }

    _tableView.backgroundColor=[UIColor whiteColor];
    
    _titleArr=[[NSMutableArray alloc] initWithObjects:
               
               @"旧  密  码",
               @"新  密  码",
               @"确认密码",
               @"",
               nil];

    
    //手机号码
    self.title=@"修改密码";
}
-(void)setAction
{
 
    if (_phoneTestField.text.length!=0) {
        
                if (_passWrodTestField.text.length!=0) {
                    
                    if (_sureNewpassWrodTestField.text.length!=0) {
                        
                        if ([_passWrodTestField.text isEqualToString:_sureNewpassWrodTestField.text]) {
                            //当前时间
                            NSDate *date=[NSDate date];
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            formatter.dateFormat = @"yyyyMMddHHmmssSS";
                            NSString *dateString = [formatter stringFromDate:date];
                            
                            NSString *md5PassStr=[_sureNewpassWrodTestField.text md5String];
                            
                            NSString *md5PassStr1=[_phoneTestField.text md5String];
                            
                            
                            NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1011\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"username\":\"%@\",\"oldpwd\":\"%@\",\"newpwd\":\"%@\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],md5PassStr1,md5PassStr];
                            
                            HttpRequestCalss *httpRequest=[HttpRequestCalss sharnInstance];
                            httpRequest.delegate=self;
                            [httpRequest httpRequest:strJson1];
                            
                        }else{
                            [self.view.window showHUDWithText:@"密码不一致" Type:ShowPhotoNo Enabled:YES];
                        }

                    }else{
                        [self.view.window showHUDWithText:@"请确认密码" Type:ShowPhotoNo Enabled:YES];
                    }

                    
                }else{
                    [self.view.window showHUDWithText:@"请输入新密码" Type:ShowPhotoNo Enabled:YES];
               
            }
    }else{
        [self.view.window showHUDWithText:@"请输入旧密码" Type:ShowPhotoNo Enabled:YES];
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
} //section 包含的cell 行数row

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //  NSLog(@"indexPath=%ld",(long)indexPath.row);
    static NSString *cellIdentifier = @"myCell";
    UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tabCell == nil) {
        tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.row==0) {
            
            _phoneTestField=[[UITextField alloc] initWithFrame:CGRectMake(120, (theTableView_Row_h-30)/2, theWidth-120, 30)];
            
            _phoneTestField.font=[UIFont systemFontOfSize:theFont];
            _phoneTestField.leftViewMode = UITextFieldViewModeAlways;
            _phoneTestField.placeholder=@"请输入旧密码";
            _phoneTestField.clearsOnBeginEditing=YES;
            _phoneTestField.delegate=self;
            _phoneTestField.secureTextEntry = YES; //密文
            _phoneTestField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _phoneTestField.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_phoneTestField];
            
            
            UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(10,0,20,0)];
            _phoneTestField.leftView=view1;
            
            UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 15, 20)];
            imageView1.image=[UIImage imageNamed:@"pass"];
            [_phoneTestField addSubview:imageView1];
            

        }
        if (indexPath.row==1) {
            
            _passWrodTestField=[[UITextField alloc] initWithFrame:CGRectMake(120, (theTableView_Row_h-30)/2, theWidth-120, 30)];
            
            _passWrodTestField.font=[UIFont systemFontOfSize:theFont];
            _passWrodTestField.leftViewMode = UITextFieldViewModeAlways;
            _passWrodTestField.placeholder=@"请输入新密码";
            _passWrodTestField.clearsOnBeginEditing=YES;
            _passWrodTestField.delegate=self;
            _passWrodTestField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _passWrodTestField.secureTextEntry = YES; //密文
            _passWrodTestField.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_passWrodTestField];
            
            UIView* view2 = [[UIView alloc]initWithFrame:CGRectMake(10,0,20,0)];
            _passWrodTestField.leftView=view2;

            UIImageView *imageView2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 15, 20)];
            imageView2.image=[UIImage imageNamed:@"pass"];
            [_passWrodTestField addSubview:imageView2];

        }
        if (indexPath.row==2) {
            
            _sureNewpassWrodTestField=[[UITextField alloc] initWithFrame:CGRectMake(120, (theTableView_Row_h-30)/2, theWidth-120, 30)];
            
            _sureNewpassWrodTestField.font=[UIFont systemFontOfSize:theFont];
            _sureNewpassWrodTestField.leftViewMode = UITextFieldViewModeAlways;
            _sureNewpassWrodTestField.placeholder=@"请确认新密码";
            _sureNewpassWrodTestField.clearsOnBeginEditing=YES;
            _sureNewpassWrodTestField.delegate=self;
            _sureNewpassWrodTestField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _sureNewpassWrodTestField.secureTextEntry = YES; //密文
            _sureNewpassWrodTestField.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_sureNewpassWrodTestField];
            
            UIView* view3 = [[UIView alloc]initWithFrame:CGRectMake(10,0,20,0)];
            _sureNewpassWrodTestField.leftView=view3;
            
            UIImageView *imageView3=[[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 15, 20)];
            imageView3.image=[UIImage imageNamed:@"pass"];
            [_sureNewpassWrodTestField addSubview:imageView3];
      

            
        }
        if (indexPath.row==3) {
            
            //登录button
            LoginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            LoginButton.backgroundColor=PublieCorlor;
            [LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            LoginButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
            LoginButton.frame=CGRectMake(10, 30,theWidth-20 , 40);
            [LoginButton setTitle:@"提交" forState:UIControlStateNormal ];
            [LoginButton addTarget:self action:@selector(setAction) forControlEvents: UIControlEventTouchUpInside ];
            LoginButton.titleLabel.font=[UIFont systemFontOfSize:16];
             [tabCell addSubview:LoginButton];
            
            LoginButton.layer.cornerRadius=6;
            LoginButton.layer.masksToBounds=YES;

            
        }

        UILabel *thelable=[[UILabel alloc] initWithFrame:CGRectMake(20, (theTableView_Row_h-30)/2, 90, 30)];
        thelable.font=[UIFont systemFontOfSize:theFont];
        thelable.backgroundColor=[UIColor clearColor];
        thelable.text=[_titleArr objectAtIndex:indexPath.row];
        thelable.alpha=0.6;
        [tabCell addSubview:thelable];
        
    }
    
    
    return tabCell;
} //cell 创建单元格



static int theTableView_Row_h;

#pragma  mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        if (indexPath.row==3) {
            
            return 500;
        }
    
        
        theTableView_Row_h=30;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        if (indexPath.row==3) {
            
            return 500;
        }
      
        theTableView_Row_h=44;
        
    }else if (IS_IPHONE_6) {  // 6
        
        if (indexPath.row==3) {
            
            return 500;
        }
       
        
        theTableView_Row_h=44;
        
        
    }else if(IS_IPHONE_6P){  // 6P
        
        if (indexPath.row==3) {
            
            return 500;
        }
        
        
        
        theTableView_Row_h=44;
    }
    
    return theTableView_Row_h;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (indexPath.row==3) {
        
        [_sureNewpassWrodTestField resignFirstResponder];
        [_phoneTestField resignFirstResponder];
        [_passWrodTestField resignFirstResponder];
        
    }
    
    
}


#pragma mark UITextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    if (_phoneTestField==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 16) {
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
    if (_sureNewpassWrodTestField==textField) {
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
    
    if (COMMANDINT==COMMAND1012) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
            
            [self performSelector:@selector(afterAction) withObject:self afterDelay:1.2];
        }else{
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
        }
        
        
    }else {
        
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
    }
    
}
-(void)afterAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
  [self.view.window showHUDWithText:@"网络异常" Type:ShowPhotoNo Enabled:YES];
}

@end
