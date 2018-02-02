//
//  YH_BingDingBankCardViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/4/7.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_BingDingBankCardViewController.h"
#import "UIWindow+YzdHUD.h"

@interface YH_BingDingBankCardViewController ()

@end

@implementation YH_BingDingBankCardViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    array = @[
              
              @{
                  @"title": @"实名身份信息",
                  
                  @"datas": @[@"姓名",@"身份证号"]
                  },
              
              @{
                  @"title" : @"只能关联与实名身份一致的储蓄卡",
                  @"datas": @[@"银行卡号", @"开户银行",@""]
                  }
              ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return array.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    NSDictionary *dict=[array objectAtIndex:section];
    NSArray *arr=[dict objectForKey:@"datas"];
    
    return arr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIder = @"cell";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIder];
        
        cell.backgroundColor=[UIColor whiteColor];
        
        if (indexPath.section==0) {
            
            if (indexPath.row==0) {
                //改成输入
                _nameTextFiled=[[UITextField alloc] init];
                _nameTextFiled.frame=CGRectMake(100, 0, theWidth-110, 60);
                _nameTextFiled.backgroundColor=[UIColor greenColor
                                                     ];
                //_houseNameTextFiled.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
                _nameTextFiled.placeholder=@"请输入姓名";
                
                _nameTextFiled.font=[UIFont systemFontOfSize:18];
        
                _nameTextFiled.delegate=self;
                
                _nameTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
                
                _nameTextFiled.borderStyle=UITextBorderStyleNone;
                _nameTextFiled.backgroundColor=[UIColor clearColor];
                [cell addSubview:_nameTextFiled];

            }else{
    
                _idCardTextFiled=[[UITextField alloc] init];
                _idCardTextFiled.frame=CGRectMake(100, 0, theWidth-110, 60);
                _idCardTextFiled.placeholder=@"请输入身份证号码";
                
                _idCardTextFiled.font=[UIFont systemFontOfSize:18];
                
                _idCardTextFiled.delegate=self;
                
                _idCardTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
                
                _idCardTextFiled.borderStyle=UITextBorderStyleNone;
                _idCardTextFiled.backgroundColor=[UIColor clearColor];
                [cell addSubview:_idCardTextFiled];

            }
            
            
        
        }else if (indexPath.section==1){
            
            if (indexPath.row==0) {
                _bankIdTextFiled=[[UITextField alloc] init];
                _bankIdTextFiled.frame=CGRectMake(100, 0, theWidth-110, 60);
                _bankIdTextFiled.placeholder=@"请输入有银联标记的储蓄卡号";
                
                _bankIdTextFiled.font=[UIFont systemFontOfSize:18];
                
                _bankIdTextFiled.delegate=self;
                
                _bankIdTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
                
                _bankIdTextFiled.borderStyle=UITextBorderStyleNone;
                _bankIdTextFiled.backgroundColor=[UIColor clearColor];
                [cell addSubview:_bankIdTextFiled];
            }else if(indexPath.row==1){
                
                _bankCountTextFiled=[[UITextField alloc] init];
                _bankCountTextFiled.frame=CGRectMake(100, 0, theWidth-110, 60);
                _bankCountTextFiled.placeholder=@"请输入开户银行";
                
                _bankCountTextFiled.font=[UIFont systemFontOfSize:18];
                
                _bankCountTextFiled.delegate=self;
                
                _bankCountTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
                
                _bankCountTextFiled.borderStyle=UITextBorderStyleNone;
                _bankCountTextFiled.backgroundColor=[UIColor clearColor];
                [cell addSubview:_bankCountTextFiled];
            }else{
                
               UIButton *saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
                saveButton.backgroundColor=PublieCorlor;
                [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                saveButton.frame=CGRectMake(10, 20, theWidth-20,44);
                saveButton.titleLabel.font=[UIFont systemFontOfSize:16];
                saveButton.layer.cornerRadius=6;
                saveButton.layer.masksToBounds=YES;
                [saveButton setTitle:@"保存" forState:UIControlStateNormal ];
                [saveButton addTarget:self action:@selector(saveAction) forControlEvents: UIControlEventTouchUpInside ];
                [cell addSubview:saveButton];
                
            }
        
       }
        
    }
    
    NSDictionary *dict=[array objectAtIndex:indexPath.section];
    NSArray *arr=[dict objectForKey:@"datas"];
    cell.textLabel.alpha=0.6;
    cell.textLabel.text=arr[indexPath.row];
    
    return cell;
}



#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (indexPath.section==1) {
        
        if (indexPath.row==2) {
            
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
    
    NSDictionary *dict = [array objectAtIndex:section];
    
    label.text =[dict objectForKey:@"title"];
    
    [view1 addSubview:label];
    
    return view1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    if (_idCardTextFiled==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 18) {
            return NO;
        }
    }
    if (_bankIdTextFiled==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 18) {
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


-(void)saveAction
{
    
    if (_nameTextFiled.text.length!=0) {
        
        if (_idCardTextFiled.text.length!=0) {
            
            if ([self validateIdentityCard:_idCardTextFiled.text]==YES){
                
                if (_bankIdTextFiled.text!=0) {
                    
                    if (_bankCountTextFiled.text!=0) {
                        
                        [self.view.window showHUDWithText:@"正在绑定..." Type:ShowLoading Enabled:YES];
                        
                        UIView  *_theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
                        _theView.backgroundColor=[UIColor blackColor];
                        _theView.tag=101;
                        _theView.alpha=0.2;
                        [self.view addSubview:_theView];
                        
                        //当前时间
                        NSDate *date=[NSDate date];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmssSS";
                        NSString *dateString = [formatter stringFromDate:date];
                        
                        NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1047\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"name\":\"%@\",\"idnumber\":\"%@\",\"cardno\":\"%@\",\"bank\":\"%@\",\"apptype\":\"2 \"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],_nameTextFiled.text,_idCardTextFiled.text,_bankIdTextFiled.text,_bankCountTextFiled.text];
                        
                        httpRequest=[HttpRequestCalss sharnInstance];
                        httpRequest.delegate=self;
                        [httpRequest httpRequest:strJson];

                        
                    }else{
                        
                        [self.view.window showHUDWithText:@"请输入开户银行" Type:ShowPhotoNo Enabled:YES];
                    }
                }else{
                    [self.view.window showHUDWithText:@"请输入银行卡号" Type:ShowPhotoNo Enabled:YES];
                }

            }else{
                
                [self.view.window showHUDWithText:@"身份证号码格式错误" Type:ShowPhotoNo Enabled:YES];
            }
        }else{
            [self.view.window showHUDWithText:@"请输入身份证号码" Type:ShowPhotoNo Enabled:YES];
        }
        
    }else{
        [self.view.window showHUDWithText:@"请输入姓名" Type:ShowPhotoNo Enabled:YES];
    }
    
    

}
//判断是否是身份证号码
-(BOOL)validateIdentityCard:(NSString *)identityCard
{
    if (identityCard.length <= 0) {
        
        return NO;
        
    }else{
        
        NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
        
        BOOL theYes = [identityCardPredicate evaluateWithObject:identityCard];
        
        if (theYes) {
            
            return YES;
            
        }else{
            
            return NO;
            
        }
        
    }
    
}


#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSMutableDictionary alloc] initWithDictionary:json];
    
    
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
    }
    
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1048) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];

            
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
    // NSLog(@"error = %@",error);
    
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
    }
}

@end
