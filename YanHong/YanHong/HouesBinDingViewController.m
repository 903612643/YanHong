//
//  HouesBinDingViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/16.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "HouesBinDingViewController.h"
#import "UIWindow+YzdHUD.h"


static id json;

static int LogButton_Size;

@interface HouesBinDingViewController ()

@end

@implementation HouesBinDingViewController

static int theFont;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
     
        
        LogButton_Size=35;
        
        theFont=14;
        
        
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        
   
        LogButton_Size=35;
        
        theFont=14;
        
    }else if (IS_IPHONE_6) {  // 6
        
      
        LogButton_Size=44;
        
        theFont=18;
        
        
    }else if (IS_IPHONE_6P) {  // 6P
        
    
        
        LogButton_Size=44;
        
        theFont=18;
        
        
        
        
    }

    
    // Do any additional setup after loading the view from its nib.
    //请求数据
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1043\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\"}",dateString];
    
    //    创建AFN管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    让manager对象 不要帮我们解析数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    1、  NSString url
    NSMutableString *urlStr = [[NSMutableString alloc]initWithString:theURL];
    
    
    [urlStr appendString:strJson1];
    //解析urlStr
    NSString *str = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //    2、3、4、请求
    [manager GET:str  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSData *data = responseObject;
        
        //  NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //  NSLog(@"String = %@",string);
        //        nsdata ----- 》  json
        json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        array=[[NSArray alloc] initWithArray:[json objectForKey:@"result"]];
        
       // NSLog(@"json = %@",json);
         _m_dic = [[NSDictionary alloc] initWithDictionary:json];
        
        [_firstTableView reloadData];
        [_sencondTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //  NSLog(@"失败 = %@",error);
        
    }];
    
    
    self.title=@"房产绑定";

    
    _titleArr=[[NSMutableArray alloc] initWithObjects:
               @"身份证",
               @"楼    盘",
               @"房    号",
               
               @"",
               
               nil];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
   // NSLog(@"arr = %@",[_m_dic objectForKey:@"result"]);
    if (_firstTableView==tableView) {
        return _titleArr.count;
    }
    NSArray *arr=[_m_dic objectForKey:@"result"];
    return arr.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_firstTableView==tableView) {
      //  NSLog(@"indexPath=%ld",(long)indexPath.row);
        static NSString *cellIdentifier = @"myCell";
       // tabCell = [_firstTableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        tabCell= [tableView cellForRowAtIndexPath:indexPath];
        
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (tabCell == nil) {
            
            tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            if (indexPath.row==0) {
                
                _IdNumber=[[UITextField alloc] initWithFrame:CGRectMake(90, (theTableView_rowH_Size-30)/2,theWidth-120 , 30)];
                _IdNumber.backgroundColor=[UIColor clearColor];
                _IdNumber.delegate=self;
                _IdNumber.font=[UIFont systemFontOfSize:theFont];
                _IdNumber.leftViewMode = UITextFieldViewModeAlways;
                _IdNumber.placeholder=@"请输入身份证号";
                _IdNumber.borderStyle=UITextBorderStyleNone;
                _IdNumber.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
                _IdNumber.clearsOnBeginEditing=YES;
                _IdNumber.clearButtonMode=UITextFieldViewModeWhileEditing;
                [tabCell addSubview:_IdNumber];
                
            }
            if (indexPath.row==1) {
                
                _houesButton=[[UIButton alloc] initWithFrame:CGRectMake(90, (theTableView_rowH_Size-30)/2,theWidth-125, 30)];
                _houesButton.backgroundColor=[UIColor clearColor];
                _houesButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                
                 [_houesButton setTitle:@"请选择楼盘信息" forState:UIControlStateNormal];
                
                _houesButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
                [_houesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_houesButton addTarget:self action:@selector(houesButtonAction) forControlEvents:UIControlEventTouchUpInside ];
                [tabCell addSubview:_houesButton];
                 tabCell.accessoryType  =  UITableViewCellAccessoryDisclosureIndicator;
                _projectId=[[UILabel alloc] initWithFrame:CGRectMake(theWidth+10, 7,50, 40)];
                _projectId.backgroundColor=[UIColor clearColor];
                _projectId.text=@"id";
                [tabCell addSubview:_projectId];
                
            }
            if (indexPath.row==2) {
                
                _houesNumber=[[UITextField alloc] initWithFrame:CGRectMake(90, (theTableView_rowH_Size-30)/2, theWidth-120, 30)];
                _houesNumber.backgroundColor=[UIColor clearColor];
                _houesNumber.delegate=self;
                _houesNumber.font=[UIFont systemFontOfSize:theFont];
                _houesNumber.leftViewMode = UITextFieldViewModeAlways;
                _houesNumber.placeholder=@"请输入房号";
                _houesNumber.borderStyle=UITextBorderStyleNone;
                _houesNumber.clearsOnBeginEditing=YES;
                _houesNumber.keyboardType=UIKeyboardTypeNumberPad;
                _houesNumber.clearButtonMode=UITextFieldViewModeWhileEditing;
                [tabCell addSubview:_houesNumber];
                
            }else if (indexPath.row==3){
                
                UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                nextButton.backgroundColor=PublieCorlor;
                nextButton.frame=CGRectMake(30, 20,theWidth-60 , LogButton_Size);
                [nextButton setTitle:@"绑定" forState:UIControlStateNormal];
                [nextButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
                [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [tabCell addSubview:nextButton];
                nextButton.layer.cornerRadius=6;
                nextButton.titleLabel.font=[UIFont systemFontOfSize:16];
                nextButton.layer.masksToBounds=YES;
            }
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, (theTableView_rowH_Size-30)/2, 70, 30)];
            lable.font=[UIFont systemFontOfSize:theFont];
            lable.backgroundColor=[UIColor clearColor];
            lable.text=[_titleArr objectAtIndex:indexPath.row];
            lable.alpha=0.8;
            [tabCell addSubview:lable];
            
        }
        
    }else if (_sencondTableView==tableView){
       
        static NSString *cellIdentifier2 = @"myCell2";

        tabCell= [_sencondTableView cellForRowAtIndexPath:indexPath];
        
        tabCell.backgroundColor=[UIColor whiteColor];
        
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (tabCell == nil) {
            
            tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
        
            
            NSArray *arr=[_m_dic objectForKey:@"result"];
            
            NSDictionary *dich=[arr objectAtIndex:indexPath.row];
   
            tabCell.textLabel.text=[dich objectForKey:@"projectName"];
            tabCell.textLabel.textAlignment=NSTextAlignmentCenter;
            tabCell.textLabel.font=[UIFont systemFontOfSize:theFont];

        }
        

    }
    return tabCell;
}


static int theTableView_rowH_Size;

#pragma  mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_sencondTableView==tableView) {

        return 38;
        
        
    }else if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theTableView_rowH_Size=40;
        
        if (indexPath.row==3) {
            return 350;
        }
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theTableView_rowH_Size=40;
        
        if (indexPath.row==3) {
            
            return 380;
        }
        
        
    }else if (IS_IPHONE_6) {  // 6
        
        theTableView_rowH_Size=50;
        
        if (indexPath.row==3) {
            return 440;
        }
        
        
    }else if (IS_IPHONE_6P){
        
        theTableView_rowH_Size=60;
        
        if (indexPath.row==3) {
            return 480;
        }
        
    }
    
    return theTableView_rowH_Size;
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (_firstTableView==tableView) {
        
        if (IS_IPHONE_4_OR_LESS) {  // 4S
            
            return 10;
            
        }else if (IS_IPHONE_5) {  // 5, 5S
            
            return 10;
            
            
        }else if (IS_IPHONE_6) {  // 6
            
            return 20;
            
            
        }else if (IS_IPHONE_6P){
            
            return 20;
        }

    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_firstTableView==tableView) {
        NSLog(@"first");
        if (indexPath.row==3) {
            
            [_houesNumber resignFirstResponder];
            
            [_IdNumber resignFirstResponder];
            
        }
        
    }else if(_sencondTableView==tableView){
        
        NSLog(@"second");
        //View切换
        CATransition *cTransition = [CATransition animation];
        cTransition.duration = 3;
        cTransition.delegate = self;
        cTransition.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
        cTransition.type =   kCATransitionReveal;
        cTransition.subtype = kCATransitionFromRight;

        //把值传给_firstTableView的楼盘文本
        [_houesButton setTitle:[_titleArr2 objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
        
        // 把值传给_firstTableView的楼盘文本
        NSArray *arr=[_m_dic objectForKey:@"result"];
        NSDictionary *dich=[arr objectAtIndex:indexPath.row];
        
        
        [_houesButton setTitle:[dich objectForKey:@"projectName"] forState:UIControlStateNormal];
        
        _projectId.text=[[NSString alloc] initWithFormat:@"%@",[dich objectForKey:@"projectid"]];
        
        ////    子视图交换位置
        [_parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];

    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)houesButtonAction
{
    
    [_IdNumber resignFirstResponder];
    [_houesNumber resignFirstResponder];
    
//    //View切换
//    CATransition *cTransition = [CATransition animation];
//    cTransition.duration = 3;
//    cTransition.delegate = self;
//    cTransition.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
//    cTransition.type =   kCATransitionReveal;
//    cTransition.subtype = kCATransitionFromRight;
//    //子视图交换位置
//    [_parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [self alertCtr1:nil];
}
#pragma mark UITextFieldDelegate
//点击空白隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if (textField==_IdNumber) {
        [_IdNumber resignFirstResponder];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    if (_IdNumber==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 18) {
            return NO;
        }
    }
    if (_houesNumber==textField) {
        
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 32) {
            return NO;
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (textField==_IdNumber) {
       // NSLog(@"编辑结束");
    }
}

#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
   dic=[[NSDictionary alloc] initWithDictionary:json];
    
   // NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1032) {
        
        [self poPViewAction];
        
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
    
        
    }else {
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
    }
    
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    //NSLog(@"error = %@",error);
}

-(void)poPViewAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//提交绑定
- (void)commitAction {

//    UITextField *_IdNumber;  //身份证号
//    UITextField *_houesNumber; //房号
    
    NSString *strH=_projectId.text;
    NSString *idNumber=_IdNumber.text;
    NSString *houesNum=_houesNumber.text;
    
    NSLog(@"id=%@",idNumber);
    NSLog(@"strH=%@",strH);
    NSLog(@"houseNum=%@",houesNum);
    
    NSString *houesName=_houesButton.titleLabel.text;
    
    if (idNumber.length!=0) {
        
        if ([self validateIdentityCard:_IdNumber.text]==YES) {
            
            if (![houesName isEqualToString:@"请选择楼盘信息"] && strH.length!=0) {
                if (houesNum.length!=0) {
                    
                    //当前时间
                    NSDate *date=[NSDate date];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyyMMddHHmmssSS";
                    NSString *dateString = [formatter stringFromDate:date];
                    
                    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1031\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"idcard\":\"%@\",\"projectid\":\"%@\",\"mobile\":\"%@\",\"roomnumber\":\"%@\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],idNumber,strH,[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],houesNum];
                    
                    HttpRequestCalss *httpRequest=[HttpRequestCalss sharnInstance];
                    httpRequest.delegate=self;
                    [httpRequest httpRequest:strJson1];
                    
                    
                }else{
                    //提示
                    [self.view.window showHUDWithText:@"请输入房号" Type:ShowPhotoNo Enabled:YES];
                }
                
            }else{
                //提示
                [self.view.window showHUDWithText:@"请选择楼盘信息" Type:ShowPhotoNo Enabled:YES];
            }
            
        }else{
            //提示
            [self.view.window showHUDWithText:@"请输入有效身份证" Type:ShowPhotoNo Enabled:YES];
        }

    }else{
        [self.view.window showHUDWithText:@"身份证号码不能为空" Type:ShowPhotoNo Enabled:YES];
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
-(void)alertCtr1:(NSString *)str

{
    
    NSLog(@"array=%@",array);
    
    if (array.count!=0) {
        
        UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *sureAction1 = [UIAlertAction actionWithTitle:[array[0] objectForKey:@"projectName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [_houesButton setTitle:[array[0] objectForKey:@"projectName"] forState:UIControlStateNormal];
            _houesButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            
            _projectId.text=[[NSString alloc] initWithFormat:@"%@",[array[0] objectForKey:@"projectId"]];
            
      
        }];
    
        UIAlertAction *sureAction2 = [UIAlertAction actionWithTitle:[array[1] objectForKey:@"projectName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [_houesButton setTitle:[array[1] objectForKey:@"projectName"] forState:UIControlStateNormal];
            _houesButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            _projectId.text=[[NSString alloc] initWithFormat:@"%@",[array[1] objectForKey:@"projectId"]];
            
            
        }];
        UIAlertAction *sureAction3= [UIAlertAction actionWithTitle:[array[2] objectForKey:@"projectName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [_houesButton setTitle:[array[2] objectForKey:@"projectName"] forState:UIControlStateNormal];
            _houesButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            _projectId.text=[[NSString alloc] initWithFormat:@"%@",[array[2] objectForKey:@"projectId"]];
            
            
        }];
        UIAlertAction *sureAction4 = [UIAlertAction actionWithTitle:[array[3] objectForKey:@"projectName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [_houesButton setTitle:[array[3] objectForKey:@"projectName"] forState:UIControlStateNormal];
            _houesButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            _projectId.text=[[NSString alloc] initWithFormat:@"%@",[array[3] objectForKey:@"projectId"]];
            
            
        }];
        UIAlertAction *sureAction5 = [UIAlertAction actionWithTitle:[array[4] objectForKey:@"projectName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [_houesButton setTitle:[array[4] objectForKey:@"projectName"] forState:UIControlStateNormal];
            _houesButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            _projectId.text=[[NSString alloc] initWithFormat:@"%@",[array[4] objectForKey:@"projectId"]];
            
        }];
        
        //    UIAlertActionStyleCancel 取消风格只能有一个
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        //    把事件添加到控制器
        [alertViewCtr addAction:cancelAction];
        [alertViewCtr addAction:sureAction1];
        [alertViewCtr addAction:sureAction2];
        [alertViewCtr addAction:sureAction3];
        [alertViewCtr addAction:sureAction4];
        [alertViewCtr addAction:sureAction5];
        
        //    模态视图
        [self presentViewController:alertViewCtr animated:YES completion:^{
            
        }];

    }
    
    
}


@end
