//
//  YH_FriendRemarksViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/3/16.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_FriendRemarksViewController.h"
#import  "UIWindow+YzdHUD.h"

@interface YH_FriendRemarksViewController ()

@end

@implementation YH_FriendRemarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"备注信息";
    

    array = @[
              
              @{
                  @"title": @"",
                  
                  @"datas": @[@""]
                  
                  
                  },
              
              ];

    _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    
    UIView *ButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
    UIButton *homeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
    homeButton.backgroundColor = [UIColor clearColor];
    [homeButton setTitle:@"完成" forState:UIControlStateNormal];
    homeButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [homeButton addTarget:self action:@selector(finalishAction) forControlEvents:UIControlEventTouchUpInside];
    
    [ButtonView addSubview:homeButton];
    //创建分享按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:ButtonView];
    
}
-(void)finalishAction
{
    
    if (![textfield.text isEqualToString:[_dict objectForKey:@"nickname"]] && textfield.text.length!=0) {
        
        [self.view.window showHUDWithText:@"正在备注..." Type:ShowLoading Enabled:YES];
        
        //当前时间
        NSDate *date=[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSS";
        NSString *dateString = [formatter stringFromDate:date];
        
        NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1101\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"frienduid\":\"%@\",\"remarkname\":\"%@\",\"apptype\":\"2 \"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],[_dict objectForKey:@"uid"],textfield.text];
        
        httpRequest=[HttpRequestCalss sharnInstance];
        httpRequest.delegate=self;
        [httpRequest httpRequest:strJson];
        

    }else{
        
        
    }
    
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
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.section==0) {

            
            textfield=[[UITextField alloc] initWithFrame:CGRectMake(20,2, theWidth-40, 40)];
            textfield.backgroundColor=[UIColor clearColor];
            textfield.font=[UIFont systemFontOfSize:16];
            textfield.delegate=self;
            textfield.text=[_dict objectForKey:@"nickname"];
            textfield.leftViewMode = UITextFieldViewModeAlways;
            textfield.placeholder=@"添加备注名";
            textfield.borderStyle=UITextBorderStyleNone;
            textfield.clearButtonMode=UITextFieldViewModeWhileEditing;
            [cell addSubview:textfield];

        
            
    }
        
        
  }
    
    return cell;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    
    if (textfield==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 20) {
            return NO;
        }
    }
        return YES;
}

#pragma mark UITableViewDelegate


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 25)];
    view1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, theWidth-40, 20)];
    label.font=[UIFont systemFontOfSize:14];
    label.backgroundColor=[UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.text=@"备注名";
    [view1 addSubview:label];
    return view1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSMutableDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);

    if (COMMANDINT==COMMAND1102) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            
            //本地数据设为空
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:nil forKey:@"myFriarray"];
            
            [defaults synchronize];
    
            
            //添加 字典，将label的值通过key值设置传递
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:textfield.text,@"friname", nil];
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"notificationfriname" object:nil userInfo:dict];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else{
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];

        }
    }else{
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
    }
    
    //[_tableView reloadData];
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    // NSLog(@"error = %@",error);
    
    
}


@end
