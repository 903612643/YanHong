//
//  YH_WithDarwCashViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/4/13.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_WithDarwCashViewController.h"
#import "UIWindow+YzdHUD.h"

@interface YH_WithDarwCashViewController ()

@end

@implementation YH_WithDarwCashViewController

-(void)httpData
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1105\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"apptype\":\"2 \"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    
    httpRequest=[[HttpRequestCalss alloc] init];
    httpRequest.delegate=self;
    [httpRequest httpRequest:strJson];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    

    
    [self httpData];
    
}

-(void)popAction{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{

    
    return 4;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIder = @"cell";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIder];
        
        cell.backgroundColor=[UIColor whiteColor];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        

            if (indexPath.row==0) {
                
                //改成输入
                _bankCountTextFiled=[[UITextField alloc] init];
                _bankCountTextFiled.frame=CGRectMake(100, 0, theWidth-110, 60);
                _bankCountTextFiled.backgroundColor=[UIColor greenColor];
                
                NSString *cdStr=[dic objectForKey:@"cardno"];
                
                if ([dic objectForKey:@"bank"]!=nil) {
                    
                    _bankCountTextFiled.text=[[NSString alloc] initWithFormat:@"%@（尾号%@）",[dic objectForKey:@"bank"],[cdStr substringWithRange:NSMakeRange(cdStr.length-4,4)]];
                    
                }else{
                    
                    _bankCountTextFiled.placeholder=@"开户银行";
                    
                }
                
                _bankCountTextFiled.font=[UIFont systemFontOfSize:18];
                
                _bankCountTextFiled.delegate=self;
                _bankCountTextFiled.enabled=NO;
                _bankCountTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
                
                _bankCountTextFiled.borderStyle=UITextBorderStyleNone;
                _bankCountTextFiled.backgroundColor=[UIColor clearColor];
                [cell addSubview:_bankCountTextFiled];
                
            }else if(indexPath.row==1){
                
                _nameTextFiled=[[UITextField alloc] init];
                _nameTextFiled.frame=CGRectMake(100, 0, theWidth-110, 60);
                _nameTextFiled.enabled=NO;
                _nameTextFiled.font=[UIFont systemFontOfSize:18];
                
                if ([dic objectForKey:@"name"]!=nil) {
                    
                    _nameTextFiled.text=[dic objectForKey:@"name"];
                    
                }else{
                    _nameTextFiled.placeholder=@"开户名";
                    
                }

                
                _nameTextFiled.delegate=self;
                _nameTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
                
                _nameTextFiled.borderStyle=UITextBorderStyleNone;
                _nameTextFiled.backgroundColor=[UIColor clearColor];
                [cell addSubview:_nameTextFiled];
                
                
            }else if (indexPath.row==2){
                
                _moneyTextFiled=[[UITextField alloc] init];
                _moneyTextFiled.frame=CGRectMake(100, 0, theWidth-110, 60);
                
                _moneyTextFiled.font=[UIFont systemFontOfSize:18];
                
                _moneyTextFiled.delegate=self;
                _moneyTextFiled.placeholder=@"请输入提现金额";
                _moneyTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
                
                _moneyTextFiled.borderStyle=UITextBorderStyleNone;
                _moneyTextFiled.backgroundColor=[UIColor clearColor];
                [cell addSubview:_moneyTextFiled];
                
            }else if (indexPath.row==3){
                
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, theWidth-40, 30)];
                label1.font=[UIFont systemFontOfSize:16];
                label1.textColor = [UIColor grayColor];
                label1.text =@"每次提现不能少于2000元";
                [cell addSubview:label1];
                
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, theWidth-40, 30)];
                label2.font=[UIFont systemFontOfSize:16];
                label2.textColor = [UIColor grayColor];
                label2.text =@"预计到账：2015-04-10前（5个工作日左右）";
                [cell addSubview:label2];
                
                UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, theWidth-40, 30)];
                label3.font=[UIFont systemFontOfSize:16];
                label3.textColor = [UIColor grayColor];
                label3.text =@"遇到国家法定节假日则相应延时";
                [cell addSubview:label3];
                
     
                UIButton *saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
                saveButton.backgroundColor=PublieCorlor;
                [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                saveButton.frame=CGRectMake(10, 150, theWidth-20,44);
                saveButton.titleLabel.font=[UIFont systemFontOfSize:16];
                saveButton.layer.cornerRadius=6;
                saveButton.layer.masksToBounds=YES;
                [saveButton setTitle:@"确认提现" forState:UIControlStateNormal ];
                [saveButton addTarget:self action:@selector(saveAction) forControlEvents: UIControlEventTouchUpInside ];
                [cell addSubview:saveButton];

            }
            
            
        
        
    }
    
    NSArray *arr=@[@"银行卡",@"开户名",@"金额",@""];
    cell.textLabel.alpha=0.6;
    cell.textLabel.text=arr[indexPath.row];
    
    return cell;
    
}



#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (indexPath.section==0) {
        
        if (indexPath.row==3) {
            
            return 500;
        }
    }
    return 60;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 40)];
    view1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, theWidth-40, 40)];
    label.font=[UIFont systemFontOfSize:14];
    label.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    label.textColor = [UIColor grayColor];
    
    label.text =@"请确保您的银行卡开户名与您实名认证一致";
    
    [view1 addSubview:label];
    
    return view1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

{
    if (indexPath.row==3) {
        
        [_nameTextFiled resignFirstResponder];
        [_moneyTextFiled resignFirstResponder];
        [_bankCountTextFiled resignFirstResponder];
    }
    
}

#pragma mark UITextFieldDelegate

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
    
    if (_nameTextFiled==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 30) {
            return NO;
        }
    }
    if (_moneyTextFiled==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 7) {
            return NO;
        }
    }
   
    if (_bankCountTextFiled==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 30) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSMutableDictionary alloc] initWithDictionary:json];
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1106) {
    
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            
            
        }else{
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
        }
        
    }else if (COMMANDINT==COMMAND1108){
        
        for (UIView *subView in [self.view subviews]) {
            if (subView.tag==101) {
                [subView removeFromSuperview];
            }
            
        }
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
            
        }else{
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
        }
        
    }else{
        
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
    }
    
    [_tableView reloadData];
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    [self.view.window showHUDWithText:@"请求失败" Type:ShowPhotoNo Enabled:YES];
    for (UIView *subView in [self.view subviews]) {
        if (subView.tag==101) {
            [subView removeFromSuperview];
        }
        
    }
}

-(void)saveAction
{
    
         if (_bankCountTextFiled.text.length!=0) {
             
             if (_moneyTextFiled.text.length!=0) {
                 if ([_moneyTextFiled.text intValue]>=2000) {
                     UIView  *_theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
                     _theView.backgroundColor=[UIColor blackColor];
                     _theView.tag=101;
                     _theView.alpha=0.2;
                     [self.view addSubview:_theView];
                     
                     [self.view.window showHUDWithText:@"请稍等..." Type:ShowLoading Enabled:YES];
                     
                     //当前时间
                     NSDate *date=[NSDate date];
                     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                     formatter.dateFormat = @"yyyyMMddHHmmssSS";
                     NSString *dateString = [formatter stringFromDate:date];
                     
                     NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1107\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"bankname\":\"%@\",\"cardno\":\"%@\",\"name\":\"%@\",\"money\":\"%@\",\"apptype\":\"2 \"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],_bankCountTextFiled.text,[dic objectForKey:@"cardno"],_nameTextFiled.text,_moneyTextFiled.text];
                     
                     httpRequest=[[HttpRequestCalss alloc] init];
                     httpRequest.delegate=self;
                     [httpRequest httpRequest:strJson];
                     
                 }else{
                     [self.view.window showHUDWithText:@"提现不能小于2000元" Type:ShowPhotoNo Enabled:YES];
                     
                 }

             }else{
                 [self.view.window showHUDWithText:@"请输入提款金额" Type:ShowPhotoNo Enabled:YES];
             }
             
             
            }else{
                
                [self.view.window showHUDWithText:@"请绑定银行卡" Type:ShowPhotoNo Enabled:YES];
            }
 
    
    
}

@end
