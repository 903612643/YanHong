//
//  SuggestViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/9.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "SuggestViewController.h"
#import "UIWindow+YzdHUD.h"
#import "AFNetworking.h"
#import "PhoneClass.h"

static id json;

static int theTableView_rowH_Size;

static int TheSexButton_Sex_w;
static int TheSexButton_Sex_h;
static int LogButton_Size;

static int theFont;

@interface SuggestViewController ()

@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"推荐新客户";
    
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        TheSexButton_Sex_w=70;
        TheSexButton_Sex_h=30;
        
        LogButton_Size=38;
        
        theFont=14;
        
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
    
        TheSexButton_Sex_w=70;
        TheSexButton_Sex_h=30;
        
        LogButton_Size=38;
        theFont=14;
        
    }else if (IS_IPHONE_6) {  // 6

        TheSexButton_Sex_w=70;
        TheSexButton_Sex_h=35;
        
        LogButton_Size=44;
        
        theFont=18;
        
        
    }else if (IS_IPHONE_6P) {  // 6P
        

        TheSexButton_Sex_w=70;
        TheSexButton_Sex_h=35;
        
        LogButton_Size=44;
        
        theFont=18;

        
        
        
    }
    
    //    //取消系统自带的返回按钮
    //[self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //请求数据
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
         NSLog(@"json = %@",json);
         _m_dic = [[NSDictionary alloc] initWithDictionary:json];
        
        array=[[NSArray alloc] initWithArray:[json objectForKey:@"result"]];
        
        [_theTableView reloadData];
        [_theTableView2 reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //  NSLog(@"失败 = %@",error);
        
    }];

    
    
    _titleArr=[[NSMutableArray alloc] initWithObjects:
               @"姓名",
               @"手机",
               @"性别",
               @"意向",
               @"备注",
               @"",
               nil];
    
    getSexStr=[[NSString alloc] init];
    //默认是男性
    getSexStr=@"男";
    
}

-(void)popAction{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

-(void)houesButtonAction1
{
    
    //View切换
    CATransition *cTransition = [CATransition animation];
    cTransition.duration = 3;
    cTransition.delegate = self;
    cTransition.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
    cTransition.type =   kCATransitionReveal;
    cTransition.subtype = kCATransitionFromRight;
    //子视图交换位置
    [_parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
 
}

-(void)getAction
{
    [self.navigationController popViewControllerAnimated:YES];
   
}
#pragma mark UITableViewDataSource

//让分割线左对齐
-(void)viewDidLayoutSubviews {
    
    if ([_theTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_theTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_theTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_theTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    if (_theTableView==tableView) {
        
        return _titleArr.count;
       
    }
        NSArray *arr=[_m_dic objectForKey:@"result"];
    
        return arr.count;

} //section 包含的cell 行数row

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
        if (_theTableView==tableView) {
            static NSString *cellIdentifier = @"myCell2";
            tabCell = [_theTableView dequeueReusableCellWithIdentifier:cellIdentifier];

           if (tabCell == nil) {
            tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
               
               tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
               
            if (indexPath.row==0) {
                //姓名
                _theTextField=[[UITextField alloc] initWithFrame:CGRectMake(100, (theTableView_rowH_Size-40)/2, theWidth-97, 40)];
                _theTextField.font=[UIFont systemFontOfSize:theFont];
                _theTextField.backgroundColor=[UIColor clearColor];
                _theTextField.delegate=self;
                _theTextField.placeholder=@"请输入姓名";
                _thePhoneText.textAlignment=NSTextAlignmentRight;
                _theTextField.borderStyle=UITextBorderStyleNone;
                _theTextField.clearsOnBeginEditing=YES;
                _theTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
                [tabCell addSubview:_theTextField];
            }
            if (indexPath.row==1) {
                //手机号码
                _thePhoneText=[[UITextField alloc] initWithFrame:CGRectMake(100, (theTableView_rowH_Size-40)/2, theWidth-96, 40)];
                _thePhoneText.font=[UIFont systemFontOfSize:theFont];
                _thePhoneText.backgroundColor=[UIColor clearColor];
                _thePhoneText.delegate=self;
                _thePhoneText.leftViewMode = UITextFieldViewModeAlways;
                _thePhoneText.placeholder=@"请输入手机号码";
                _thePhoneText.borderStyle=UITextBorderStyleNone;
                _thePhoneText.clearsOnBeginEditing=YES;
                _thePhoneText.keyboardType=UIKeyboardTypeNumberPad;
                _thePhoneText.clearButtonMode=UITextFieldViewModeWhileEditing;
                [tabCell addSubview:_thePhoneText];
            }
            if (indexPath.row==2) {
                
                getTextButton=[UIButton buttonWithType:UIButtonTypeCustom];
                getTextButton.frame=CGRectMake(theWidth-TheSexButton_Sex_w-10, (theTableView_rowH_Size-30)/2,TheSexButton_Sex_w, 30);
                [getTextButton setImage:[UIImage imageNamed:@"sex"]  forState:UIControlStateNormal ];
                [getTextButton addTarget:self action:@selector(getSexAction) forControlEvents:UIControlEventTouchUpInside];
                [tabCell addSubview:getTextButton];
                
            }
            if (indexPath.row==3) {
                
                _houesButton=[[UIButton alloc] initWithFrame:CGRectMake(100, (theTableView_rowH_Size-40)/2,theWidth-35-100, 40)];
                _houesButton.backgroundColor=[UIColor clearColor];
                _houesButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                _houesButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
                [_houesButton setTitle:@"请选择楼盘信息" forState:UIControlStateNormal];
                [_houesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                _houesButton.alpha=0.6;
                [_houesButton addTarget:self action:@selector(houesButtonAction) forControlEvents:UIControlEventTouchUpInside ];
                [tabCell addSubview:_houesButton];
                tabCell.accessoryType  =  UITableViewCellAccessoryDisclosureIndicator;
                
                _projectId=[[UILabel alloc] initWithFrame:CGRectMake(theWidth+10, (theTableView_rowH_Size-40)/2,10, 40)];
                _projectId.backgroundColor=[UIColor clearColor];
                _projectId.text=@"id";
                [tabCell addSubview:_projectId];
            }
            if (indexPath.row==4) {
                //推荐人
                _theNameText=[[UITextField alloc] initWithFrame:CGRectMake(100, (theTableView_rowH_Size-40)/2,theWidth-96, 40)];
                _theNameText.backgroundColor=[UIColor clearColor];
                _theNameText.delegate=self;
                _theNameText.font=[UIFont systemFontOfSize:theFont];
                _theNameText.leftViewMode = UITextFieldViewModeAlways;
                _theNameText.placeholder=@"可以不填写";
                _theNameText.borderStyle=UITextBorderStyleNone;
                _theNameText.clearsOnBeginEditing=YES;
                _theNameText.clearButtonMode=UITextFieldViewModeWhileEditing;
                [tabCell addSubview:_theNameText];
                
            }else if (indexPath.row==5){
                
                UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                nextButton.backgroundColor=PublieCorlor;
                nextButton.frame=CGRectMake(30, 30,theWidth-60 , LogButton_Size);
                [nextButton setTitle:@"提交" forState:UIControlStateNormal];
                nextButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
                [nextButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
                [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [tabCell addSubview:nextButton];
                nextButton.layer.cornerRadius=8;
                nextButton.layer.masksToBounds=YES;
                
                UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(30, 50+LogButton_Size, 40, 20)];
                lable1.text=@"提示：";
                lable1.backgroundColor=[UIColor clearColor];
                lable1.textColor=[UIColor redColor];
                lable1.font=[UIFont systemFontOfSize:12];
                [tabCell addSubview:lable1];
                
                UILabel *lable3=[[UILabel alloc] initWithFrame:CGRectMake(60, 50+LogButton_Size, theWidth-80, 20)];
                lable3.text=@"如多次推荐无效客户，经查实，将取消全民经纪人资格。";
                lable3.textColor=[UIColor grayColor];
                lable3.font=[UIFont systemFontOfSize:12];
                [tabCell addSubview:lable3];
                
                
            }
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, (theTableView_rowH_Size-30)/2, 70, 30)];
            lable.font=[UIFont systemFontOfSize:theFont];
            lable.backgroundColor=[UIColor clearColor];
            lable.text=[_titleArr objectAtIndex:indexPath.row];
            lable.alpha=0.6;
            [tabCell addSubview:lable];
            
        }
    }else if (_theTableView2==tableView)
    {
        
        static NSString *cellIdentifier2 = @"myCell2";
        tabCell = [_theTableView2 dequeueReusableCellWithIdentifier:cellIdentifier2];
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        tabCell.backgroundColor=[UIColor whiteColor];
        if (tabCell == nil) {
            tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
            
            NSArray *arr=[_m_dic objectForKey:@"result"];
            
            NSDictionary *dich=[arr objectAtIndex:indexPath.row];
            
            tabCell.textLabel.textAlignment=NSTextAlignmentCenter;
            tabCell.textLabel.text=[dich objectForKey:@"projectName"];
            tabCell.textLabel.font=[UIFont systemFontOfSize:theFont];

            
        }
        

    }
    
    return tabCell;
    
} //cell 创建单元格
static bool isClick=YES;

-(void)getSexAction
{
    if(isClick == NO)
    {
        [getTextButton setImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
        getSexStr=@"男";
        
        isClick = YES;
    }else {
        [getTextButton setImage:[UIImage imageNamed:@"woMan"] forState: UIControlStateNormal];
          getSexStr=@"女";
        isClick = NO;
    }

}


#pragma  mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        if (indexPath.row==5) {
            
            return 400;
        }
        theTableView_rowH_Size=44;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        if (indexPath.row==5) {
            
            return 400;
        }
        
        theTableView_rowH_Size=44;
        
    }else if (IS_IPHONE_6) {  // 6
        
        if (indexPath.row==5) {
            
            return 400;
        }
        
        theTableView_rowH_Size=44;
        
        return theTableView_rowH_Size;
        
    }else if(IS_IPHONE_6P){  // 6P
        
        if (indexPath.row==5) {
            
            return 400;
        }
        
        theTableView_rowH_Size=44;
    }
    
    
    return theTableView_rowH_Size;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (_theTableView2==tableView) {
        return 2;
    }
    return 15;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    if (_theTableView2==tableView) {
        return 1;
    }
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_theTableView2==tableView) {
//        
//        UITextField *_theTextField;  //姓名
//        UITextField *_thePhoneText; //手机号
//        UITextField *_theNameText; //推荐人
//        UITextField *_theTypeText; //类型
//        UITextField *_thePassText; //验证码
        
        //View切换
//        CATransition *cTransition = [CATransition animation];
//        cTransition.duration = 3;
//        cTransition.delegate = self;
//        cTransition.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
//        cTransition.type =   kCATransitionReveal;
//        cTransition.subtype = kCATransitionFromRight;
//       // 把值传给_firstTableView的楼盘文本
//        NSArray *arr=[_m_dic objectForKey:@"result"];
//        NSDictionary *dich=[arr objectAtIndex:indexPath.row];
//
//        [_houesButton setTitle:[dich objectForKey:@"projectName"] forState:UIControlStateNormal];
//        _projectId.text=[[NSString alloc] initWithFormat:@"%@",[dich objectForKey:@"projectid"]];
//            ////    子视图交换位置
//        [_parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        
        
      
        
    }else if(_theTableView==tableView){
        
        
        if (indexPath.row==3) {
           
//            //View切换
//            CATransition *cTransition = [CATransition animation];
//            cTransition.duration = 3;
//            cTransition.delegate = self;
//            cTransition.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
//            cTransition.type =   kCATransitionReveal;
//            cTransition.subtype = kCATransitionFromRight;
//            ////    子视图交换位置
//            [_parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];

            [self alertCtr1:nil];
            
  
        }else if (indexPath.row==5){
            
            [_theTextField resignFirstResponder];
            [_thePhoneText resignFirstResponder];
            [_theNameText resignFirstResponder];
            [_theTypeText resignFirstResponder];
            [_thePassText resignFirstResponder];
            
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)houesButtonAction
{
    [_theTextField resignFirstResponder];
    [_thePhoneText resignFirstResponder];
    [_theNameText resignFirstResponder];
    [_theTypeText resignFirstResponder];
    [_thePassText resignFirstResponder];
   
    [self alertCtr1:nil];
    
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    
    [textField resignFirstResponder];
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
    if (_theTextField==textField) {
       
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 20) {
            return NO;
        }
    }
    if (_theNameText==textField) {
        
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 50) {
            return NO;
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
   
}


- (void)commitAction{

    
    NSString *thename=_theTextField.text;
    NSString *phone=_thePhoneText.text;
    NSString *strH=_projectId.text;
    NSString *houesName=_houesButton.titleLabel.text;
    NSString *beizhu=_theNameText.text;
    NSLog(@"name=%@",thename);
    NSLog(@"phone=%@",phone);
    NSLog(@"strH=%@",strH);
    NSLog(@"beizhu=%@",beizhu);
    NSLog(@"getSex=%@",getSexStr);
    
    PhoneClass *phoneCtr=[[PhoneClass alloc] init];

    if (thename.length!=0) {
        
        if ([self name:[thename substringToIndex:1]]==NO) {
            
            if ([phoneCtr phone:phone]==YES) {
                if ((![houesName isEqualToString:@"请选择楼盘信息"]) && strH.length!=0) {
                    
                    [self.view.window showHUDWithText:@"正在提交..." Type:ShowLoading Enabled:YES];
                    
                    _theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
                    _theView.backgroundColor=[UIColor blackColor];
                    _theView.tag=101;
                    _theView.alpha=0.2;
                    [self.view addSubview:_theView];
                    
                    
                    //请求数据
                    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1023\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"137889283\",\"uid\":\"%@\",\"name\":\"%@\",\"mobile\":\"%@\",\"gender\":\"%@\",\"houses\":\"%@\",\"remarks\":\"%@\"}",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],thename,phone,getSexStr,strH,beizhu];
                    HttpRequestCalss *httpRequest=[HttpRequestCalss sharnInstance];
                    httpRequest.delegate=self;
                    [httpRequest httpRequest:strJson1];
                    
                    
                }else{
                    //提示
                    [self.view.window showHUDWithText:@"请选择楼盘信息" Type:ShowPhotoNo Enabled:YES];
                }
                
            }else{
                //提示
                [self.view.window showHUDWithText:@"手机格式不正确" Type:ShowPhotoNo Enabled:YES];
            }

            
            
        }else{
            [self.view.window showHUDWithText:@"开头不能为非法字符或数字" Type:ShowPhotoNo Enabled:YES];
        }
        
        
    }else{
        //提示
        [self.view.window showHUDWithText:@"姓名不能为空" Type:ShowPhotoNo Enabled:YES];
    }
   
    
}

#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
    }

    dic=[[NSDictionary alloc] initWithDictionary:json];
   // NSLog(@"委托后的数据：%@",dic);

    
    if (COMMANDINT==COMMAND1024) {
        
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"myGuest"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //推荐成功
            NSString *str=[[NSString alloc] initWithFormat:@"%@是否继续？",[dic objectForKey:@"errmsg"]];
            [self alertCtr:str];
            
            
        }else{
            
            NSString *str=[[NSString alloc] initWithFormat:@"%@是否继续？",[dic objectForKey:@"errmsg"]];
            [self alertCtr:str];
            
        }
        
        
      
    }
        

    
    
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
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
//提示对话框
-(void)alertCtr:(NSString *)str
{
    
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [self dismissViewControllerAnimated:YES completion:^{
//        }];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //    把事件添加到控制器
    [alertViewCtr addAction:cancelAction];
    [alertViewCtr addAction:sureAction];
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^{
        
    }];
    
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
            
            NSLog(@"_projectId.text=%@",_projectId.text);
            
            
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

//判断用户开开头字符是数字或其他字符
-(BOOL)name:(NSString *)name;
{
    
    
    NSString *NubStr = @"^[0-9]*$";
    
    NSString *OthStr = @"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NubStr];
    
    BOOL isMatch1 = [pred1 evaluateWithObject:name];
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", OthStr];
    
    BOOL isMatch2 = [pred2 evaluateWithObject:name];
    
    
    if (!isMatch2 || isMatch1) {
        
        
        return YES;
        
    }
    
    
    return NO;
}

@end
