//
//  MiddlemanViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/1.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "MiddlemanViewController.h"
#import "UIWindow+YzdHUD.h"
#import "PhoneClass.h"

@interface MiddlemanViewController ()

@end

@implementation MiddlemanViewController

static int theFont;
static int theButton_Size_W;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"个人信息";
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theFont=14;
        
        theButton_Size_W=80;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
       
        theFont=14;
        
        theButton_Size_W=80;
        
        
    }else if (IS_IPHONE_6) {  // 6
        
        theFont=18;
        
        theButton_Size_W=100;
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        theFont=18;
        
        theButton_Size_W=100;
    
    }


    
    _theTableVIew.backgroundColor=[UIColor whiteColor];

    _titleArr=[[NSMutableArray alloc] initWithObjects:
        
               @"昵        称",
               @"性        别",
               @"Q   Q   号",
               @"邮        箱",
               @"个性签名",
               @"",
               nil];
    
    
    //默认是男性
    getSexStr=@"男";
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    // 下载经纪人信息
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1079\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"apptype\":\"2\",\"language\":\"1\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
    
    //postter
   HttpRequestCalss *httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
 
}

#pragma mark UITableViewDataSource

//让分割线左对齐
-(void)viewDidLayoutSubviews {
    
    if ([_theTableVIew respondsToSelector:@selector(setSeparatorInset:)]) {
        [_theTableVIew setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_theTableVIew respondsToSelector:@selector(setLayoutMargins:)])  {
        [_theTableVIew setLayoutMargins:UIEdgeInsetsZero];
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
            
            _nickNameField=[[UITextField alloc] initWithFrame:CGRectMake(120, (theTableView_Row_h-30)/2, theWidth-120, 30)];
            _nickNameField.font=[UIFont systemFontOfSize:theFont];
            _nickNameField.backgroundColor=[UIColor clearColor];
            _nickNameField.delegate=self;
            _nickNameField.leftViewMode = UITextFieldViewModeAlways;
            _nickNameField.placeholder=@"请输入昵称";
            _nickNameField.borderStyle=UITextBorderStyleNone;
            _nickNameField.clearButtonMode=UITextFieldViewModeWhileEditing;
            
            [tabCell addSubview:_nickNameField];
            
        }
        if (indexPath.row==1) {
            
            theSexButton=[UIButton buttonWithType:UIButtonTypeCustom];
            theSexButton.frame=CGRectMake(theWidth-90, (theTableView_Row_h-30)/2,70, 30);
            [theSexButton setImage:[UIImage imageNamed:@"sex"]  forState:UIControlStateNormal ];
            [theSexButton addTarget:self action:@selector(getSexAction) forControlEvents:UIControlEventTouchUpInside];
            [tabCell addSubview:theSexButton];
 
        }
        if (indexPath.row==2) {
            
           
            _theQQNumberText=[[UITextField alloc] initWithFrame:CGRectMake(120, (theTableView_Row_h-30)/2, theWidth-120, 30)];
            _theQQNumberText.backgroundColor=[UIColor clearColor];
            _theQQNumberText.delegate=self;
            _theQQNumberText.font=[UIFont systemFontOfSize:theFont];
            _theQQNumberText.leftViewMode = UITextFieldViewModeAlways;
            _theQQNumberText.placeholder=@"请输入QQ号码";
            _theQQNumberText.borderStyle=UITextBorderStyleNone;
            _theQQNumberText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _theQQNumberText.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_theQQNumberText];

        }
        if (indexPath.row==3) {
            
            _theMailText=[[UITextField alloc] initWithFrame:CGRectMake(120, (theTableView_Row_h-30)/2, theWidth-120, 30)];
            _theMailText.font=[UIFont systemFontOfSize:theFont];
            _theMailText.backgroundColor=[UIColor clearColor];
            _theMailText.delegate=self;
            _theMailText.leftViewMode = UITextFieldViewModeAlways;
            _theMailText.placeholder=@"请输入邮箱";
            _theMailText.borderStyle=UITextBorderStyleNone;
            _theMailText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _theMailText.clearButtonMode=UITextFieldViewModeWhileEditing;
            [tabCell addSubview:_theMailText];
    
        
        }
        if (indexPath.row==4) {
            
            _textView=[[UITextView alloc] initWithFrame:CGRectMake(20, 50, theWidth-40, 100)];
            _textView.delegate=self;
            _textView.font=[UIFont systemFontOfSize:theFont];
            _textView.layer.borderWidth = 1;
            _textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            _textView.layer.cornerRadius = 6;
            [tabCell addSubview:_textView];
            
            lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 6, theWidth-10, 20)];
            lable.text=@"请输入个性签名";
            lable.font=[UIFont systemFontOfSize:theFont];
            lable.alpha=0.4;
            [_textView addSubview:lable];

            
        }
        if (indexPath.row==5) {
            
            UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            nextButton.backgroundColor=PublieCorlor;
            nextButton.frame=CGRectMake(10, 30,theWidth-20 , 40);
            [nextButton setTitle:@"提交" forState:UIControlStateNormal];
            [nextButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
            [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            nextButton.layer.cornerRadius=6;
            nextButton.titleLabel.font=[UIFont systemFontOfSize:16];
            nextButton.layer.masksToBounds=YES;
            
            [tabCell addSubview:nextButton];

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
        
        if (indexPath.row==5) {
            
            return 500;
        }
        if (indexPath.row==4) {
            
            return 160;
        }
        
        theTableView_Row_h=30;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        if (indexPath.row==5) {
            
            return 500;
        }
        if (indexPath.row==4) {
            
            return 160;
        }
        
         theTableView_Row_h=44;
        
    }else if (IS_IPHONE_6) {  // 6
        
        if (indexPath.row==5) {
            
            return 500;
        }
        if (indexPath.row==4) {
            
            return 160;
        }
        
        theTableView_Row_h=44;
        
        
    }else if(IS_IPHONE_6P){  // 6P
        
        if (indexPath.row==5) {
            
            return 500;
        }
        if (indexPath.row==4) {
            
            return 160;
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
    
    if (indexPath.row==5) {
        
        [_nickNameField resignFirstResponder];
        [_theQQNumberText resignFirstResponder];
        [_theMailText resignFirstResponder];
        
        if (_textView.text.length==0) {
            
            lable.text=@"请输入个性签名";
        }
        
        [_textView resignFirstResponder];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commitAction
{
    
    NSString *nickName=_nickNameField.text;
    NSString *qq=_theQQNumberText.text;
    NSString *maile=_theMailText.text;
    
    NSLog(@"nickName=%@",nickName);
    NSLog(@"sexStr=%@",getSexStr);
    NSLog(@"qq=%@",qq);
    NSLog(@"maile=%@",maile);

                                if (qq.length!=0 || maile.length!=0) {
                                    
                                    //当前时间
                                    NSDate *date=[NSDate date];
                                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                    formatter.dateFormat = @"yyyyMMddHHmmssSS";
                                    NSString *dateString = [formatter stringFromDate:date];
                                    
                                    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1037\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"name\":\"\",\"idcard\":\"\",\"cardno\":\"\",\"bank\":\"\",\"sex\":\"%@\",\"QQ\":\"%@\",\"email\":\"%@\",\"nickname\":\"%@\",\"signature\":\"%@\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],getSexStr,qq,maile,nickName,_textView.text];
                                    
                                    HttpRequestCalss *httpRequest=[HttpRequestCalss sharnInstance];
                                    httpRequest.delegate=self;
                                    [httpRequest httpRequest:strJson1];
                                    
                                }else{
                                    
                                    [self.view.window showHUDWithText:@"请输入QQ号或者邮箱" Type:ShowPhotoNo Enabled:YES];
                                }
                                
                            }



static bool isClick=YES;

-(void)getSexAction
{
    
    [_nickNameField resignFirstResponder];
    [_theQQNumberText resignFirstResponder];
    [_theMailText resignFirstResponder];
  
    
    if(isClick == NO)
    {
        
        [theSexButton setImage:[UIImage imageNamed:@"sex"] forState:UIControlStateNormal];
        getSexStr=@"男";
        
        isClick = YES;
    }else {
        [theSexButton setImage:[UIImage imageNamed:@"woMan"] forState: UIControlStateNormal];
        getSexStr=@"女";
        isClick = NO;
    }
    
}
#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    
    lable.text=@"";
    
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView;
{
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if (_textView==textView) {
        
        if (_textView.text.length == 0)
            return YES;
        NSInteger existedLength = _textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = _textView.text.length;
        //限制长度
        if (existedLength - selectedLength + replaceLength > 1000) {
            return NO;
        }
        
    }
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    
    return YES;
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
    if (_nickNameField==textField) {
        
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 32) {
            return NO;
        }
    }

       if (_theQQNumberText==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 32) {
            return NO;
        }
    }
    if (_theMailText==textField) {
        
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

#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1038) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
            [self performSelector:@selector(toRootViewAction) withObject:self afterDelay:1.5];
        }else{
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
        }
        
        
    }else if (COMMANDINT==COMMAND1004)
    {
        
    }else if (COMMANDINT==COMMAND1080){
        
        if ([[dic objectForKey:@"nickname"] isKindOfClass:[NSNull class]]) {
            
            _nickNameField.text=@"";
            
        }else{
            
            _nickNameField.text=[dic objectForKey:@"nickname"];
            
        }
   
        if ([[dic objectForKey:@"QQ"] isKindOfClass:[NSNull class]]) {

            _theQQNumberText.text=@"";
            
        }else{
            
            _theQQNumberText.text=[dic objectForKey:@"QQ"];
            
        }
        
        if ([[dic objectForKey:@"email"] isKindOfClass:[NSNull class]]) {
            
            _theMailText.text=@"";
            
        }else{
            
            _theMailText.text=[dic objectForKey:@"email"];
            
        }
        if ([[dic objectForKey:@"signature"] isKindOfClass:[NSNull class]]) {
            
            _textView.text=@"";
            
        }else{
            
            _textView.text=[dic objectForKey:@"signature"];
            lable.text=@"";
            
        }

    }else{
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
    }
    
    [_theTableVIew reloadData];
    
}
-(void)toRootViewAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;

{
   // NSLog(@"error = %@",error);
    
    
}


@end
