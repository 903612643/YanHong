//
//  SaveNewPasswordViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/8.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "SaveNewPasswordViewController.h"
#import "LoginViewController.h"
#import "UIWindow+YzdHUD.h"

#import "NSString+MD5.h"

static int theCodeButton_Size_h=0;
@interface SaveNewPasswordViewController ()

@end

@implementation SaveNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theCodeButton_Size_h=35;
        _theTableView.rowHeight=50;
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        
        theCodeButton_Size_h=35;
        _theTableView.rowHeight=50;
        
    }else if (IS_IPHONE_6) {  // 6
        

        theCodeButton_Size_h=35;
        _theTableView.rowHeight=60;
        
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        theCodeButton_Size_h=35;
        _theTableView.rowHeight=60;
        
    }

   self.title=@"重置密码";
    //  设置圆角
    _commitAction2.layer.cornerRadius = 8;
    //    如果父元素溢出 子元素将父元素剪切
    _commitAction2.layer.masksToBounds = YES;
    
    
    NSLog(@"phoneStr=%@",_phoneStr);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
} //section 包含的cell 行数row

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"indexPath=%ld",(long)indexPath.row);
    static NSString *cellIdentifier = @"myCell";
    UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tabCell == nil) {
        tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if (indexPath.row==0) {
            //手机号码
            _thePhoneText=[[UITextField alloc] initWithFrame:CGRectMake(20, (_theTableView.rowHeight-theCodeButton_Size_h)/2, theWidth-40, theCodeButton_Size_h)];
            _thePhoneText.leftViewMode = UITextFieldViewModeAlways;
            _thePhoneText.backgroundColor=[UIColor clearColor];
            _thePhoneText.delegate=self;
            _thePhoneText.leftViewMode = UITextFieldViewModeAlways;
            _thePhoneText.placeholder=@"请输入新密码";
            _thePhoneText.borderStyle=UITextBorderStyleNone;
            _thePhoneText.secureTextEntry = YES; //密文
            _thePhoneText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _thePhoneText.clearButtonMode=UITextFieldViewModeWhileEditing;
            
            UIView* view1 = [[UIView alloc]initWithFrame:CGRectMake(0,0,20,0)];
            
            _thePhoneText.leftView=view1;
            
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, (theCodeButton_Size_h-20)/2, 15, 20)];
            imageView.image=[UIImage imageNamed:@"pass"];
            [_thePhoneText addSubview:imageView];
    
            [tabCell addSubview:_thePhoneText];
            
        }
        if (indexPath.row==1) {
            //手机号码
            _thePassWordText=[[UITextField alloc] initWithFrame:CGRectMake(20, (_theTableView.rowHeight-theCodeButton_Size_h)/2, theWidth-40, theCodeButton_Size_h)];
            
            _thePassWordText.leftViewMode = UITextFieldViewModeAlways;
            _thePassWordText.backgroundColor=[UIColor clearColor];
            _thePassWordText.delegate=self;
            _thePassWordText.leftViewMode = UITextFieldViewModeAlways;
            _thePassWordText.placeholder=@"请输入确认新密码";
            _thePassWordText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _thePassWordText.borderStyle=UITextBorderStyleNone;
             _thePassWordText.secureTextEntry = YES; //密文
            _thePassWordText.clearButtonMode=UITextFieldViewModeWhileEditing;
            
            UIView* view1 = [[UIView alloc]initWithFrame:CGRectMake(0,0,20,0)];
            
            _thePassWordText.leftView=view1;
            
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, (theCodeButton_Size_h-20)/2, 15, 20)];
            imageView.image=[UIImage imageNamed:@"pass"];
            
            [_thePassWordText addSubview:imageView];
            
            [tabCell addSubview:_thePassWordText];
            
        }
    }
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 50)];
    lable.backgroundColor=[UIColor clearColor];
    lable.alpha=0.6;
    [tabCell addSubview:lable];
    
    return tabCell;
} //cell 创建单元格

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}//表视图存在的 section  行数  默认1

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    return @" ";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
{
    
    return @" ";
}
#pragma  mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"jfjfg");
    [_thePhoneText resignFirstResponder];
    [_thePassWordText resignFirstResponder];
    
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
        if (existedLength - selectedLength + replaceLength > 16) {
            return NO;
        }
    }
    if (_thePassWordText==textField) {
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
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (textField==_thePhoneText || textField==_thePassWordText) {
        NSLog(@"编辑结束");
    }
}


#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",json);
    
 
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
            
            //返回根视图
            [self performSelector:@selector(toLoginViewCtrAction) withObject:nil afterDelay:1.5];
            
        }else{
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
            
        }
    
    
    
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    //NSLog(@"error = %@",error);
}

- (IBAction)commiteAction2:(id)sender {
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    if (_thePhoneText.text.length>5) {
        
        if ([_thePassWordText.text isEqualToString:_thePhoneText.text]) {
            
            NSString *againNewPass=_thePassWordText.text;
            
            NSString *md5PassStr=[againNewPass md5String];
            
            HttpRequestCalss *httpReq=[HttpRequestCalss sharnInstance];
            httpReq.delegate=self;
            NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1007\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"username\":\"%@\",\"newpwd\":\"%@\",\"againnewpwd\":\"%@\",\"apptype\":\"2\",\"language\":\"1\"}",dateString,_phoneStr,md5PassStr,md5PassStr];
            //请求
            [httpReq httpRequest:strJson];

            
        }else {
            //失败提示
            [self.view.window showHUDWithText:@"密码不一致" Type:ShowPhotoNo Enabled:YES];
        }

    }else{
        //失败提示
        [self.view.window showHUDWithText:@"密码过于简单" Type:ShowPhotoNo Enabled:YES];
    }

    
}

-(void)toLoginViewCtrAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
