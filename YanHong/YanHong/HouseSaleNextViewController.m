//
//  HouseSaleNextViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/1/11.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "HouseSaleNextViewController.h"
#import "PhoneClass.h"

#import "MoblieFriendViewController.h"

#import "UIWindow+YzdHUD.h"
#import "YH_FriendViewController.h"

@interface HouseSaleNextViewController ()

@end

@implementation HouseSaleNextViewController

static int theFont;

static int theFont2;

static float sencondtableView_Size_h;

static float sencondtableView_Button_Size;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theFont=14;
        
        theFont2=12;
        
        sencondtableView_Size_h=24.2;
        
        sencondtableView_Button_Size=140;
       
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        
        theFont=14;
        theFont2=14;
        sencondtableView_Size_h=24.2;
        
        sencondtableView_Button_Size=140;
        
    }else if (IS_IPHONE_6) {  // 6
        
        
        theFont=18;
        
        theFont2=15;
        sencondtableView_Size_h=24.2;
        
        sencondtableView_Button_Size=163;
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        theFont=18;
        
        theFont2=15;
        sencondtableView_Size_h=24.2;
        
        sencondtableView_Button_Size=182.5;
        
    }
    
    
    _titleArr=[[NSMutableArray alloc] initWithObjects:
               @"",@"售        价",@"",@"姓        名",@"手  机  号",@"验  证  码",@"",
               nil];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)theaddPicAction1
{
    [self req:_imageArr[1] times:2];

}
-(void)theaddPicAction2
{
    [self req:_imageArr[2] times:3];
    
}
-(void)theaddPicAction3
{
    [self req:_imageArr[3] times:4];
    
}
-(void)theaddPicAction4
{
    [self req:_imageArr[4] times:5];
    
}
-(void)timeAction
{

    
    NSLog(@"_imageArr=%ld",(unsigned long)_imageArr.count);
    
        if (_imageArr!=nil&&_imageArr.count!=0) {
            
            if (_imageArr.count==1) {
                
                [self req:_imageArr[0] times:1];
                
            }else if (_imageArr.count==2){
                
                [self req:_imageArr[0] times:1];
                
                [self performSelector:@selector(theaddPicAction1) withObject:self afterDelay:2];
                
            }else if (_imageArr.count==3){
                
                [self req:_imageArr[0] times:1];
                
                [self performSelector:@selector(theaddPicAction1) withObject:self afterDelay:1.5];
                
                [self performSelector:@selector(theaddPicAction2) withObject:self afterDelay:3];

                
            }else if (_imageArr.count==4){
                
                [self req:_imageArr[0] times:1];
                
                [self performSelector:@selector(theaddPicAction1) withObject:self afterDelay:1.5];
                
                [self performSelector:@selector(theaddPicAction2) withObject:self afterDelay:3];
                
                [self performSelector:@selector(theaddPicAction3) withObject:self afterDelay:4.5];
                

                
            }else if (_imageArr.count==5){
                
                [self req:_imageArr[0] times:1];
                
                [self performSelector:@selector(theaddPicAction1) withObject:self afterDelay:1.5];
                
                [self performSelector:@selector(theaddPicAction2) withObject:self afterDelay:3];
                
                [self performSelector:@selector(theaddPicAction3) withObject:self afterDelay:4.5];
                
                [self performSelector:@selector(theaddPicAction4) withObject:self afterDelay:6];
         
            
            
        }
        
        
    }
   
    
    
}

-(void)req:(NSString *)imageStr times:(int)times
{

    NSLog(@"hid=%@",_hid);
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1063\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"hid\":\"%@\",\"photo\":\"%@\",\"no\":\"%d\",\"op\":\"1\",\"type\":\"1\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],_hid,imageStr,times];
    
    //post 请求
    
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];

}

//转发
-(void)forWardAction
{
    
    NSLog(@"hid=%@",_hid);
    NSLog(@"_price=%@",_theprice);
    NSLog(@"djgdgj=%@",codePass.text);
    
    NSString *theprice=price.text;
    NSString *contact=name.text;
    NSString *disphone=phone.text;
    
    int IntPrice=[theprice intValue];
    
    int IntPrice1=[_theprice intValue];
    
     NSMutableArray *thearr=[[NSMutableArray  alloc] init];
    
    [thearr addObject:theprice];
    [thearr addObject:contact];
    [thearr addObject:disphone];

    if (theprice.length!=0) {
        
        if (IntPrice>=IntPrice1) {
            
            if (contact.length!=0) {
                
                if (disphone.length!=0) {
            
                    PhoneClass *phoneCla=[[PhoneClass alloc] init];
                    
                    if ([phoneCla phone:disphone]==YES) {
                        
                        if (codePass.text.length!=0) {
                        
                            MoblieFriendViewController *check=[[MoblieFriendViewController alloc] init];
                            check.title=@"选择";
                            check.forWardArr=thearr;
                            check.hidesBottomBarWhenPushed=YES;
                            check.uid=_allPersonUid;
                            check.hid=_hid;
                            check.codeStr=codePass.text;
                            
                            //本地数据设为空
                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                            
                            [defaults setObject:nil forKey:@"myFriarray"];
                            
                            [defaults synchronize];
                            
                            
                            check.tabBarController.tabBar.hidden=YES;
                            [self.navigationController pushViewController:check animated:YES];
                     
                    

                         }else{
                        
                        [self.view.window showHUDWithText:@"请输入验证码" Type:ShowPhotoNo Enabled:YES];
                       }
                    }else{
                            [self.view.window showHUDWithText:@"手机号码格式不正确" Type:ShowPhotoNo Enabled:YES];
                    }
                }else{
                    [self.view.window showHUDWithText:@"请输入手机号码" Type:ShowPhotoNo Enabled:YES];
                }
                
            }else{
                [self.view.window showHUDWithText:@"请输入姓名" Type:ShowPhotoNo Enabled:YES];
            }

        }else{
            
            [self.view.window showHUDWithText:@"价格不能低于原价" Type:ShowPhotoNo Enabled:YES];
        }
        
            }else{
        [self.view.window showHUDWithText:@"请输入价格" Type:ShowPhotoNo Enabled:YES];
    }
}

//发布
-(void)commitActionTheView
{

    NSString *theprice=price.text;
    NSString *contact=name.text;
    NSString *disphone=phone.text;

    if (theprice.length!=0) {
        
        if (contact.length!=0) {
            if (disphone.length!=0) {
                PhoneClass *phoneCla=[[PhoneClass alloc] init];
                
                if ([phoneCla phone:disphone]==YES) {
                    
                    if (codePass.text.length!=0) {
                        
                        [self.view.window showHUDWithText:@"正在发布..." Type:ShowLoading Enabled:YES];
                        
                        _theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
                        _theView.backgroundColor=[UIColor blackColor];
                        _theView.tag=101;
                        _theView.alpha=0.2;
                        [self.view addSubview:_theView];
                        
                        //当前时间
                        NSDate *date=[NSDate date];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmssSS";
                        NSString *dateString = [formatter stringFromDate:date];
                        
                        //房源信息发布（转发）
                        
                        NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1057\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"hid\":\"%@\",\"fid\":\"0\",\"price\":\"%@\",\"contact\":\"%@\",\"disphone\":\"%@\",\"recievedid\":\"0\",\"validcode\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],_hid,price.text,name.text,phone.text,codePass.text];
                        
                        httpRequest=[[HttpRequestCalss alloc] init];
                        httpRequest.delegate=self;
                        [httpRequest httpRequest:strJson];
                        

                        
                    }else{
                        
                        [self.view.window showHUDWithText:@"请输入验证码" Type:ShowPhotoNo Enabled:YES];
                    }
                }else{
                    
                    [self.view.window showHUDWithText:@"手机号码格式不正确" Type:ShowPhotoNo Enabled:YES];
                }
            }else{
                [self.view.window showHUDWithText:@"请输入手机号码" Type:ShowPhotoNo Enabled:YES];
            }
   
        }else{
            [self.view.window showHUDWithText:@"请输入姓名" Type:ShowPhotoNo Enabled:YES];
        }
    }else{
        [self.view.window showHUDWithText:@"请输入价格" Type:ShowPhotoNo Enabled:YES];
   }

}
-(void)codeAction:(UIButton *)sender
{
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *thephone=phone.text;
    
    PhoneClass *phoneCla=[[PhoneClass alloc] init];
    
    if (thephone.length!=0) {
        if ([phoneCla phone:thephone]==YES) {
            
            index=60;
            
            codeButton.backgroundColor=[UIColor grayColor];
            [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(GetActionTime:) userInfo:nil repeats:YES];

            [self.view.window showHUDWithText:@"发送成功" Type:ShowPhotoYes Enabled:YES];
            NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1003\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"username\":\"%@\",\"apptype\":\"2\",\"language\":\"1\"}",dateString,thephone];
            
            [httpRequest httpRequest:strJson];
            
        }else{
            [self.view.window showHUDWithText:@"手机号码格式不正确" Type:ShowPhotoNo Enabled:YES];
        }

    }else{
        [self.view.window showHUDWithText:@"手机号码不能为空" Type:ShowPhotoNo Enabled:YES];
    }
    
}

-(void)GetActionTime:(NSTimer *)timer
{
    
    index--;
    
    NSLog(@"index=%d",index);
    
    if (index==0) {
        
        codeButton.backgroundColor=PublieCorlor;
        [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [codeButton setTitle:[[NSString alloc] initWithFormat:@"重新获取"] forState:UIControlStateNormal];
        codeButton.enabled=YES;
        [timer invalidate];
        
    }else{
        
        [codeButton setTitle:[[NSString alloc] initWithFormat:@"请等待%d秒",index] forState:UIControlStateNormal];
        codeButton.enabled=NO;
        
    }
    
    
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
   
   
        
    return _titleArr.count;
        


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   
        
        static NSString *cellIdentifier = @"myCell";
        tabCell = [tableView cellForRowAtIndexPath:indexPath];
        
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (tabCell == nil) {
            
            tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            if ( indexPath.row==6||indexPath.row==0||indexPath.row==2){
                
                tabCell.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
                
            }
            
            if (indexPath.row==0) {
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
                lable.font=[UIFont systemFontOfSize:theFont];
                lable.text=@"请填写您的期望售价";
                lable.textAlignment=NSTextAlignmentLeft;
                lable.backgroundColor=[UIColor clearColor];
                lable.textColor=[UIColor grayColor];
                [tabCell addSubview:lable];
                
            }
            if (indexPath.row==1) {
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-60, 5, 60, 30)];
                lable.text=@"万/套";
                lable.font=[UIFont systemFontOfSize:theFont];
                lable.backgroundColor=[UIColor clearColor];
                lable.textColor=[UIColor grayColor];
                [tabCell addSubview:lable];
                
                //改成输入
                price=[[UITextField alloc] init];
                price.frame=CGRectMake(100, 5, theWidth-100-40, 30);
                price.delegate=self;
                price.font=[UIFont systemFontOfSize:theFont];
                price.keyboardType=UIKeyboardTypeNumberPad;
                
                if ([self.title isEqualToString:@"我要转发"]) {
                    price.text=_theprice;
                }
                
                price.placeholder=@"请输入";
                price.borderStyle=UITextBorderStyleNone;
                price.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:price];
                
                
            }
            if (indexPath.row==2) {
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
                lable.font=[UIFont systemFontOfSize:theFont];
                
                lable.text=@"请填写您的联系方式";
                
                lable.textAlignment=NSTextAlignmentLeft;
                lable.backgroundColor=[UIColor clearColor];
                lable.textColor=[UIColor grayColor];
                [tabCell addSubview:lable];
                
                
            }else  if (indexPath.row==3) {
                
                //改成输入
                name=[[UITextField alloc] init];
                name.frame=CGRectMake(100, 5, theWidth-100-40, 30);
                name.delegate=self;
                NSString *nameStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
                
                if (nameStr!=nil) {
                    
                    name.text = nameStr;
                }else{
                    name.placeholder=@"请输入姓名";
                }

                name.borderStyle=UITextBorderStyleNone;
                name.font=[UIFont systemFontOfSize:theFont];
                name.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:name];
                
                
            }else  if (indexPath.row==4){
                
                //改成输入
                phone=[[UITextField alloc] init];
                phone.frame=CGRectMake(100, 5, theWidth-100-40, 30);
                phone.delegate=self;
                phone.font=[UIFont systemFontOfSize:theFont];
                phone.placeholder=@"请输入手机号";
                phone.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
                phone.keyboardType=UIKeyboardTypePhonePad;
                phone.borderStyle=UITextBorderStyleNone;
                phone.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:phone];
                
            }else  if (indexPath.row==5){
                
                //改成输入
                codePass=[[UITextField alloc] init];
                codePass.frame=CGRectMake(100, 5, theWidth-100-40, 30);
                codePass.delegate=self;
                codePass.font=[UIFont systemFontOfSize:theFont];
                codePass.keyboardType=UIKeyboardTypeNumberPad;
                codePass.placeholder=@"请输入验证码";
                codePass.borderStyle=UITextBorderStyleNone;
                codePass.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:codePass];
                
                codeButton=[UIButton buttonWithType:UIButtonTypeCustom];
                codeButton.frame=CGRectMake(theWidth-100, 6,80 , 28);
                [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                codeButton.backgroundColor=PublieCorlor;
                [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                codeButton.titleLabel.font=[UIFont systemFontOfSize:14];
                codeButton.layer.cornerRadius=4;
                codeButton.layer.masksToBounds=YES;
                [codeButton addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
                [tabCell addSubview:codeButton];
                
                
            }else if(indexPath.row==6){
                
                UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                nextButton.backgroundColor=PublieCorlor;
                nextButton.frame=CGRectMake(30, 60,theWidth-60 , 38);
                nextButton.titleLabel.font=[UIFont systemFontOfSize:16];
                
                if ([self.title isEqualToString:@"我要转发"]) {
                    
                    [nextButton setTitle:@"转发" forState:UIControlStateNormal];
                    [nextButton addTarget:self action:@selector(forWardAction) forControlEvents:UIControlEventTouchUpInside];
                }else{
                    
                    [nextButton setTitle:@"立即发布" forState:UIControlStateNormal];
                    [nextButton addTarget:self action:@selector(commitActionTheView) forControlEvents:UIControlEventTouchUpInside];
                }
                
                [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                nextButton.layer.cornerRadius=8;
                nextButton.layer.masksToBounds=YES;
                
                [tabCell addSubview:nextButton];
                
            }
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 90, 30)];
            lable.backgroundColor=[UIColor clearColor];
            lable.text=[_titleArr objectAtIndex:indexPath.row];
            lable.alpha=0.8;
            lable.font=[UIFont systemFontOfSize:theFont];
            [tabCell addSubview:lable];
            

        
    }
    
    return tabCell;
    
}

#pragma  mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

        
        if (indexPath.row==6) {
            
            return 460;
        }else{
            return 40;
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
    
        if (indexPath.row==0 || indexPath.row==2 || indexPath.row==6)
        {
            [price resignFirstResponder];
            [name resignFirstResponder];
            [phone resignFirstResponder];
            [codePass resignFirstResponder];
            
        }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    if (price==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 5) {
            return NO;
        }
    }
    
    if (name==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 30) {
            return NO;
        }
    }
    if (phone==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    if (codePass==textField) {
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
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    if (COMMANDINT==COMMAND1058) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:nil forKey:@"array"];
            [defaults synchronize];
            
            for (UIView *subviews in [self.view subviews]) {
                if (subviews.tag==101) {
                    [subviews removeFromSuperview];
                }
            }
            
            if (_imageArr.count!=0) {
                
                //上传图片
                [self timeAction];
                
                //上传图片提示
                
                [self alertCtr:@"6"];
                
                thepLable.text=@"正在上传图片...";
                
                
                
            }else{
                
                [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
                
                [self performSelector:@selector(suessToView) withObject:self afterDelay:1.2];
            }

        }else {
            
            [self performSelector:@selector(errToView) withObject:self afterDelay:1.2];
        }
        
     
    }else if (COMMANDINT==COMMAND1064){
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            
            imageCount++;
            
            
            if (_imageArr.count==1) {
                
                _progressView.frame=CGRectMake(2, 2, (imageCount+4)*45.2, 26);
                
            }else if (_imageArr.count==2){
                
                _progressView.frame=CGRectMake(2, 2, (imageCount+3)*45.2, 26);
                
            }else if (_imageArr.count==3){
                
                _progressView.frame=CGRectMake(2, 2, (imageCount+2)*45.2, 26);
                
            }else if (_imageArr.count==4){
                
                _progressView.frame=CGRectMake(2, 2, (imageCount+1)*45.2, 26);
                
            }else if (_imageArr.count==5){
                
                _progressView.frame=CGRectMake(2, 2, imageCount*45.2, 26);
                
            }
            
            
            if (imageCount==_imageArr.count) {
                
                
                thepLable.text=@"上传图片成功";
                
            }else{
                
                thepLable.text=@"正在上传图片...";
                
            }
            
        }else{
            
            _progressView.frame=CGRectMake(2, 2, imageCount*45.2, 26);
            thepLable.text=[[NSString alloc] initWithFormat:@"成功%d张失败%lu张",imageCount,(unsigned long)_imageArr.count-imageCount];
            
        }
        
    }
    
    NSLog(@"imageCount=%d",imageCount);
    
}

-(void)errToView
{
    
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
    }
    
    [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
}

-(void)suessToView{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    YH_FriendViewController *fri=[[YH_FriendViewController alloc] init];
   
    fri.title=@"朋友圈";
    fri.ctrType=@"2";
    [self.navigationController pushViewController:fri animated:YES];

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
    
    [self.view.window showHUDWithText:@"网络异常" Type:ShowPhotoNo Enabled:YES];
}
-(void)alertCtr:(NSString *)typeStr
{
    if ([typeStr isEqualToString:@"6"]) {
        
        
        UIView *proessView=[[UIView alloc] init];
        proessView.frame= CGRectMake(10, 10, 250, 100);
        proessView.backgroundColor=[UIColor clearColor];
        
        // 背景图像
        _trackView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 230, 30)];
        [_trackView setImage:[UIImage imageNamed:@"wait_progress_back"]];
        // 填充图像
        _progressView = [[UIImageView alloc] init];
        [_progressView setImage:[UIImage imageNamed:@"wait_progress"]];
        [_trackView addSubview:_progressView];
        [proessView addSubview:_trackView];
        [_trackView addSubview:_progressView];
        thepLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 230, 40)];
        thepLable.textAlignment = NSTextAlignmentCenter;
        _trackView.layer.cornerRadius=12;
        _progressView.layer.cornerRadius=10;
        _trackView.layer.masksToBounds=YES;
        _progressView.layer.masksToBounds=YES;
        [proessView addSubview:thepLable];
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert.view addSubview:proessView];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            imageCount=0;

            [self suessToView];
            
        }];
        
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:^{ }];
    }
}

@end
