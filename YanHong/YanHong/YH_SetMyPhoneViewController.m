//
//  YH_SetMyPhoneViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/3/15.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_SetMyPhoneViewController.h"
#import "PhoneClass.h"
#import "UIWindow+YzdHUD.h"

@interface YH_SetMyPhoneViewController ()

@end

@implementation YH_SetMyPhoneViewController

static int theFont;
static int IndRow4_Size;
static int IndRow_Size;
static int BottomView_Size_Y;
static int BottomView_Size_H;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
     
        theFont=14;
        
        IndRow4_Size=500;
        
        IndRow_Size=40;
        
        BottomView_Size_Y=160;
        BottomView_Size_H=120;
    
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
     
        theFont=14;
        IndRow4_Size=500;
        
        IndRow_Size=50;
        
        BottomView_Size_Y=200;
        BottomView_Size_H=140;
     
        
    }else if (IS_IPHONE_6) {  // 6
        

        theFont=16;
        
        IndRow4_Size=440;
        
        IndRow_Size=50;
        
        BottomView_Size_Y=300;
        BottomView_Size_H=140;

        
    }else if (IS_IPHONE_6P){
        
        
        theFont=18;
        IndRow4_Size=530;
        IndRow_Size=50;
        
        BottomView_Size_Y=350;
        BottomView_Size_H=180;
        
     
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
        static NSString *cellIdentifier = @"myCell";
 
        UITableViewCell  *tabCell= [tableView cellForRowAtIndexPath:indexPath];
        
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (tabCell == nil) {
            
            tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            if (indexPath.row==1||indexPath.row==2) {
                
                
                tabCell.backgroundColor=[UIColor whiteColor];
                
                
                
            }else{
                
                tabCell.backgroundColor=[UIColor groupTableViewBackgroundColor];
            }
            if (indexPath.row==0) {
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(20, (IndRow_Size+10-40)/2, theWidth, 20)];
                lable.textColor=[UIColor grayColor];
                lable.text=@"修改后下次可使用新手机号登录";
                lable.font=[UIFont systemFontOfSize:theFont];
                [tabCell addSubview:lable];
                
                phone=[[UILabel alloc] initWithFrame:CGRectMake(20, (IndRow_Size+10-40)/2+20, theWidth, 20)];
                phone.text=[[NSString alloc] initWithFormat:@"当前手机号:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] ];
                phone.textColor=[UIColor grayColor];
                phone.backgroundColor=[UIColor clearColor];
                phone.font=[UIFont systemFontOfSize:theFont];
                [tabCell addSubview:phone];
                
                
                
                
            }else if (indexPath.row==1){
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, (IndRow_Size-20)/2, 100, 20)];
                lable.text=@"新 手 机  号";
                lable.font=[UIFont systemFontOfSize:theFont];
                [tabCell addSubview:lable];
                
                phoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(110,(IndRow_Size-30)/2, theWidth-120, 30)];
                phoneTextField.backgroundColor=[UIColor clearColor];
                phoneTextField.font=[UIFont systemFontOfSize:theFont];
                phoneTextField.delegate=self;
                phoneTextField.leftViewMode = UITextFieldViewModeAlways;
                phoneTextField.placeholder=@"请输入11位手机号";
                phoneTextField.borderStyle=UITextBorderStyleNone;
                phoneTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
                phoneTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
                [tabCell addSubview:phoneTextField];
                
    
                
            }else if (indexPath.row==2){
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, (IndRow_Size-20)/2, 100, 20)];
                lable.text=@"验    证   码";
                lable.font=[UIFont systemFontOfSize:theFont];
                [tabCell addSubview:lable];
                
                codeTextField=[[UITextField alloc] initWithFrame:CGRectMake(110,(IndRow_Size-30)/2, theWidth-120-100, 30)];
                codeTextField.backgroundColor=[UIColor clearColor];
                codeTextField.font=[UIFont systemFontOfSize:theFont];
                codeTextField.delegate=self;
                codeTextField.leftViewMode = UITextFieldViewModeAlways;
                codeTextField.placeholder=@"请输入验证码";
                codeTextField.borderStyle=UITextBorderStyleNone;
                codeTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
                codeTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
                [tabCell addSubview:codeTextField];
                
                getTextButton=[UIButton buttonWithType:UIButtonTypeCustom];
                getTextButton.frame=CGRectMake(theWidth-110,(IndRow_Size-30)/2 , 100,30);
                getTextButton.backgroundColor=PublieCorlor;
                [getTextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
                [getTextButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                getTextButton.layer.cornerRadius=4;
                getTextButton.layer.masksToBounds=YES;
                getTextButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
                
                [getTextButton addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
                [tabCell addSubview:getTextButton];
                
      
            
            }else if(indexPath.row==3){
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(35, 15, theWidth-30, 20)];
                lable.textColor=[UIColor grayColor];
                lable.font=[UIFont systemFontOfSize:theFont-2];
                lable.text=@"验证码等同密码，打死也不能告诉其他人哦";
                [tabCell addSubview:lable];
                
                UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
                imageView.backgroundColor=[UIColor clearColor];
                imageView.image=[UIImage imageNamed:@"warn"];
                [tabCell addSubview:imageView];
                
                UIButton *sureButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                sureButton.backgroundColor=PublieCorlor;
                sureButton.frame=CGRectMake(10, 60,theWidth-20 , 40);
                [sureButton setTitle:@"确定" forState:UIControlStateNormal];
                [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
                [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sureButton.titleLabel.font=[UIFont systemFontOfSize:16];
                sureButton.layer.cornerRadius=6;
                sureButton.layer.masksToBounds=YES;
                
                [tabCell addSubview:sureButton];
                
                
                UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, BottomView_Size_Y, theWidth, BottomView_Size_H)];
                view.alpha=0.4;
                view.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:view];
                
                UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, theWidth, 20)];
                lable1.text=@"没收到短信验证码?";
                lable1.font=[UIFont systemFontOfSize:theFont+2];
                [view addSubview:lable1];
                
                UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(10, 45, theWidth, 20)];
                lable2.text=@"1、 网络通讯异常可能会造成短信丢失，请重新获取或稍后再试。";
                lable2.font=[UIFont systemFontOfSize:theFont-2];

                
                CGSize size = CGSizeMake(theWidth-20, MAXFLOAT);
                lable2.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize = [lable2 sizeThatFits:size];
                lable2.frame = CGRectMake(10,45, theWidth-20, lableSize.height);
                
                [view addSubview:lable2];

                
                UILabel *lable3=[[UILabel alloc] initWithFrame:CGRectMake(10, lableSize.height+35, theWidth, 20)];
                lable3.text=@"2、请核实手机是否欠费停机，或者屏蔽了系统短信。";
                lable3.font=[UIFont systemFontOfSize:theFont-2];
                
                CGSize size3 = CGSizeMake(theWidth-20, MAXFLOAT);
                lable3.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize3 = [lable3 sizeThatFits:size3];
                lable3.frame = CGRectMake(10,lableSize.height+45, theWidth-20, lableSize3.height);
                
                [view addSubview:lable3];
                
                
                UILabel *lable4=[[UILabel alloc] initWithFrame:CGRectMake(10, (lableSize3.height)+(lableSize.height+45), theWidth, 20)];
                lable4.text=@"3、请如果原手机已经不能接收验证码，请与管理员联系。";
                lable4.font=[UIFont systemFontOfSize:theFont-2];
                CGSize size4 = CGSizeMake(theWidth-20, MAXFLOAT);
                lable4.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize4 = [lable4 sizeThatFits:size4];
                lable4.frame = CGRectMake(10,(lableSize3.height)+(lableSize.height+45), theWidth-20, lableSize4.height);
               
                [view addSubview:lable4];

            }

 
    }
    
    return tabCell;
    
}
-(void)sureAction
{
    
    if (phoneTextField.text.length!=0) {
        
        //判断是否为手机号
        PhoneClass *phoneCla=[[PhoneClass alloc] init];
        
        if ([phoneCla phone:phoneTextField.text]==YES) {


                    if (codeTextField.text.length!=0) {
                        
                        [self.view.window showHUDWithText:@"正在上传..." Type:ShowLoading Enabled:YES];
                        
                        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight+200)];
                        view.alpha=0.3;
                        view.tag=101;
                        view.backgroundColor=[UIColor blackColor];
                        [view bringSubviewToFront:_tableView];
                        [self.view addSubview:view];
                        
                        //当前时间
                        NSDate *date=[NSDate date];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmssSS";
                        NSString *dateString = [formatter stringFromDate:date];
                        
                        //请求数据
                        NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1091\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"newusername\":\"%@\",\"affirmusername\":\"%@\",\"validcode\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],phoneTextField.text,phoneTextField.text,codeTextField.text];
                        
                        httpReq=[[HttpRequestCalss alloc] init];
                        
                        NSString *url1=[NSString stringWithFormat:THE_POSTURL];
                        
                        httpReq.delegate=self;
                        
                        [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        
                        [httpReq postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
                            
                        } fail:^{
                            
                        }];

                        
                    }else{
                        
                        [self.view.window showHUDWithText:@"请输入验证码" Type:ShowPhotoNo Enabled:YES];
                        
                    }
    
        }else{
            
            [self.view.window showHUDWithText:@"号码格式不正确" Type:ShowPhotoNo Enabled:YES];
        }
        
        
    }else{
        [self.view.window showHUDWithText:@"请输入手机号码" Type:ShowPhotoNo Enabled:YES];
    }

    
}
-(void)getCodeAction

{
    
    if (phoneTextField.text.length!=0) {
        
        //判断是否为手机号
        PhoneClass *phoneCla=[[PhoneClass alloc] init];
        
        if ([phoneCla phone:phoneTextField.text]==YES) {
    
                    //当前时间
                    NSDate *date=[NSDate date];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyyMMddHHmmssSS";
                    NSString *dateString = [formatter stringFromDate:date];
                    
                    index=60;
                    getTextButton.backgroundColor=[UIColor grayColor];
                    [getTextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(GetActionTime:) userInfo:nil repeats:YES];
                    
                    [self.view.window showHUDWithText:@"发送成功" Type:ShowPhotoYes Enabled:YES];
                    
                    NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1003\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"username\":\"%@\",\"apptype\":\"2\",\"language\":\"1\"}",dateString,phoneTextField.text];
                    httpReq=[[HttpRequestCalss alloc] init];
                    
                    NSString *url=[NSString stringWithFormat:THE_POSTURL];
                    
                    httpReq.delegate=self;
                    
                    [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    [httpReq postJSONWithUrl:url parameters:strJson success:^(id responseObject) {
                        
                    } fail:^{
                        
                    }];
            
        }else{
            
            [self.view.window showHUDWithText:@"号码格式不正确" Type:ShowPhotoNo Enabled:YES];
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

#pragma  mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (indexPath.row==0) {
        
        return IndRow_Size+10;
        
    }else if (indexPath.row==3){
        
        
        return IndRow4_Size;
    
        
    }else{
        return IndRow_Size;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
 
    if (indexPath.row==0||indexPath.row==4) {
        
        [phoneTextField resignFirstResponder];
        [codeTextField resignFirstResponder];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    
    [textField resignFirstResponder];
    
    return YES;
}

//文本长度限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    
    if (phoneTextField==textField) {
        
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
        
    }
    if (phoneTextField1==textField ) {
        
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    if (codeTextField==textField) {
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

#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSDictionary alloc] initWithDictionary:json];
    NSLog(@"委托后的数据：%@",dic);
    
    if (dic.count>0||dic!=nil) {
        
       //提交的验证
        if (COMMANDINT==COMMAND1004) {
            
            
        }else if (COMMANDINT==COMMAND1092){
            
            if ([[dic objectForKey:@"errcode"]
                 isEqualToString:@"000"]) {
                
                for (UIView *subviews in [self.view subviews]) {
                    if (subviews.tag==101) {
                        [subviews removeFromSuperview];
                    }
                }
                
                //注销
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                
                //删除用户uid
                [userDefault removeObjectForKey:@"uid"];
                
                //发布保存的数据设为空
                [userDefault setObject:@"" forKey:@"buildings"];
                [userDefault setObject:@"" forKey:@"shi"];
                [userDefault setObject:@"" forKey:@"ting"];
                [userDefault setObject:@"" forKey:@"wei"];
                [userDefault setObject:@"" forKey:@"area"];
                [userDefault setObject:@"" forKey:@"floor"];
                [userDefault setObject:@"" forKey:@"orientation"];
                [userDefault setObject:@"" forKey:@"comment"];
                [userDefault setObject:@"" forKey:@"address"];
                [userDefault setObject:@"" forKey:@"zhuangXiu"];

                [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
                
                //返回根视图
                [self performSelector:@selector(popACtion) withObject:nil afterDelay:1.5];
                
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
        
        for (UIView *subviews in [self.view subviews]) {
            if (subviews.tag==101) {
                [subviews removeFromSuperview];
            }
        }

        
        [self.view.window showHUDWithText:@"网络繁忙，请稍后再试！" Type:ShowPhotoNo Enabled:YES];
        
    }

}

-(void)popACtion
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
