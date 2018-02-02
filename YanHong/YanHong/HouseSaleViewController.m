//
//  HouseSaleViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/1/6.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "HouseSaleViewController.h"

#import "PicBrowserViewController.h"

#import "HouseSaleNextViewController.h"

#import "UIWindow+YzdHUD.h"




static id json;

static int rowSeconde_Size;

static int headView_Size=170;

static int TextView_Size;

static int lable_Size_W;

@interface HouseSaleViewController ()

@end

@implementation HouseSaleViewController

- (NSString *)thisYear
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    //离开界面时存储数据
    NSString *buildings=_houseNameTextFiled.text;
    NSString *address=_houseAddess.text;
   // NSString *housetype=[[NSString alloc] initWithFormat:@"%@%@%@%@",_textField4.text,_lable4.text,_textField5.text,_lable5.text];
    NSString *area=_textField2.text;
   // NSString *louceng=[[NSString alloc] initWithFormat:@"%@%@%@%@%@",allf.text,_textField.text,dijic.text,_ditextField.text,ceng.text];
    NSString *liftStr=liftLable.text;
    NSString *orientation=_orientationLable.text;
    NSString *decorationtypeStr=decorationtype.text;
    NSString *propertytypeStr=propertytype.text;
    NSString *bulidingYearStr=bulidingYear.text;
    NSString *stopTimeStr=stopTime.text;
    NSString *tiptextfStr=tiptextf.text;
    NSString *comment=_textView.text;
    
    userDef=[NSUserDefaults standardUserDefaults];
    [userDef setObject:buildings forKey:@"buildings"];
    [userDef setObject:address forKey:@"address"];
    [userDef setObject:houestypeLable.text forKey:@"housetype"];
    [userDef setObject:area forKey:@"area"];
    [userDef setObject:_textField.text forKey:@"allf"];
    [userDef setObject:_ditextField.text forKey:@"dif"];
    [userDef setObject:liftStr forKey:@"liftf"];
    [userDef setObject:orientation forKey:@"orientation"];
    [userDef setObject:decorationtypeStr forKey:@"decorationtype"];
    [userDef setObject:propertytypeStr forKey:@"propertytype"];
    [userDef setObject:bulidingYearStr forKey:@"bulidingYear"];
    [userDef setObject:stopTimeStr forKey:@"stopTime"];
    [userDef setObject:tiptextfStr forKey:@"tiptextf"];
    [userDef setObject:comment forKey:@"comment"];
    [userDef synchronize];
    
}
//提示对话框
-(void)alertCtr:(NSString *)str message:(NSString *)message cancel:(NSString *)cancelStr sure:(NSString *)sureStr
{
    
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:str message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        userDef=[NSUserDefaults standardUserDefaults];
        [userDef setObject:@"" forKey:@"buildings"];
        [userDef setObject:@"" forKey:@"address"];
        [userDef setObject:@"" forKey:@"housetype"];
        [userDef setObject:@"" forKey:@"area"];
        [userDef setObject:@"" forKey:@"allf"];
        [userDef setObject:@"" forKey:@"dif"];
        [userDef setObject:@"" forKey:@"liftf"];
        [userDef setObject:@"" forKey:@"orientation"];
        [userDef setObject:@"" forKey:@"decorationtype"];
        [userDef setObject:@"" forKey:@"propertytype"];
        [userDef setObject:@"" forKey:@"bulidingYear"];
        [userDef setObject:@"" forKey:@"stopTime"];
        [userDef setObject:@"" forKey:@"tiptextf"];
        [userDef setObject:@"" forKey:@"comment"];
        [userDef synchronize];
        
        _houseNameTextFiled.placeholder=@"请输入楼盘名称";
        _houseNameTextFiled.text=@"";
        _houseAddess.placeholder=@"请输入楼盘地址";
        _houseAddess.text=@"";
        _textField2.placeholder=@"请输入建筑面积";
        _textField2.text=@"";
        _textField.text=@"";
        _ditextField.text=@"";
        _orientationLable.text=@"请选择朝向";
        liftLable.text=@"是否有电梯";
        decorationtype.text=@"请选择装修类型";
        propertytype.text=@"请选择物业类型";
        bulidingYear.placeholder=@"请输入建筑年份";
        bulidingYear.text = [self thisYear];
        stopTime.text=@"请选择截止时间";
        tiptextf.placeholder=@"请输入标题";
        tiptextf.text=@"";
        theTishiLable.text=@"写点您房源的卖点吧！例如装修情况、小区环境等等";
        
        liftLable.alpha=0.2;
        decorationtype.alpha=0.2;
        _orientationLable.alpha=0.2;
        propertytype.alpha=0.2;
        stopTime.alpha=0.2;
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //什么都不用做
        
    }];
    //    把事件添加到控制器
    [alertViewCtr addAction:cancelAction];
    [alertViewCtr addAction:sureAction];
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^{
        
    }];
}

static int theFont;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"委托发布";
    
    if ((![[[NSUserDefaults standardUserDefaults] objectForKey:@"buildings"] isEqual:@""] && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] isEqual:@""])) {
        
        [self alertCtr:@"友情提示" message:@"您有未填写完成的房源" cancel:@"重新填写" sure:@"恢复填写"];
        
    }

    
    //返回Item
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(commitAction)];
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        rowSeconde_Size=50;
        
        TextView_Size=theHeight-100-50;
        
        theFont=14;
        
        lable_Size_W=70;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        rowSeconde_Size=50;
        
        TextView_Size=theHeight-100-50*3;
        
        theFont=14;
        
        lable_Size_W=70;
  
    }else if (IS_IPHONE_6) {  // 6
  
        rowSeconde_Size=55;
        
        TextView_Size=theHeight-100-50*5;
        
        theFont=18;
        
        lable_Size_W=80;
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        rowSeconde_Size=55;
        
        TextView_Size=theHeight-100-50*5;
        
        theFont=18;
        
        lable_Size_W=80;
        
    }

    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    

    if ((![[[NSUserDefaults standardUserDefaults] objectForKey:@"buildings"] isEqual:@""] && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] isEqual:@""])) {
        
        [self alertCtr:@"友情提示" message:@"您有未填写完成的房源" cancel:@"重新填写" sure:@"恢复填写"];
        
    }
    
    //－－－－－－－－－－－－－－－－－－－－－数据源－－－－－－－－－－－－－－－－－－
    _titleArr=[[NSMutableArray alloc] initWithObjects:
               @"楼盘名称",@"地        址",@"户        型",@"建筑面积",@"楼        层",@"电        梯",@"朝        向",@"装修类型",@"物业类型",@"建筑年份",@"截止时间",@"标        题",@"",
               nil];
    
    
    //压缩前
    _imageArrQian=[[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return _titleArr.count;

 
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   
        
        NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        
        tabCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        if (tabCell == nil) {
            
            tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            if (indexPath.row==2
                ||indexPath.row==5
                ||indexPath.row==6
                ||indexPath.row==8||indexPath.row==7||indexPath.row==10) {
                tabCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }

            if (indexPath.row==0) {
                
                //改成输入
                _houseNameTextFiled=[[UITextField alloc] init];
                _houseNameTextFiled.frame=CGRectMake(lable_Size_W+20, 5, theWidth-lable_Size_W-30, 30);
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"buildings"] isEqualToString:@""]) {
                    _houseNameTextFiled.placeholder=@"请输入楼盘名称";
                }else{
                    
                    _houseNameTextFiled.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"buildings"];
                }
                
                _houseNameTextFiled.font=[UIFont systemFontOfSize:theFont];
                _houseNameTextFiled.delegate=self;
                _houseNameTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
            
                _houseNameTextFiled.borderStyle=UITextBorderStyleNone;
                _houseNameTextFiled.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:_houseNameTextFiled];

                
                
            }
            if (indexPath.row==1) {
                
                _houseAddess=[[UITextField alloc] init];
                _houseAddess.frame=CGRectMake(lable_Size_W+20, 2, theWidth-lable_Size_W-30, 38);
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"address"] isEqualToString:@""]) {
                    _houseAddess.placeholder=@"请输入楼盘地址";
                    
                }else{
                    
                    _houseAddess.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
                }
                tiptextf.text=_houseAddess.text;
                _houseAddess.delegate=self;
                _houseAddess.font=[UIFont systemFontOfSize:theFont];
                _houseAddess.clearButtonMode=UITextFieldViewModeWhileEditing;
                _houseAddess.borderStyle=UITextBorderStyleNone;
                _houseAddess.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:_houseAddess];
     
                
            }
            if (indexPath.row==2) {
                
                houestypeLable=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"housetype"] isEqualToString:@""]) {
                    
                    houestypeLable.text=@"请选择室厅卫";
                    houestypeLable.alpha=0.2;
                    
                }else{
                    
                    houestypeLable.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"housetype"];
                    if ([houestypeLable.text isEqualToString:@"请选择室厅卫"]) {
                        houestypeLable.alpha=0.2;
                    }else{
                        houestypeLable.alpha=1;
                    }
                    
                    
                }
                houestypeLable.font=[UIFont systemFontOfSize:theFont];
                houestypeLable.textColor=[UIColor blackColor];
                houestypeLable.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:houestypeLable];

                

            }else if (indexPath.row==3){
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-50, 5, 40, 30)];
                lable.text=@"平米";
                lable.font=[UIFont systemFontOfSize:theFont];
                
                lable.backgroundColor=[UIColor clearColor];
                lable.textColor=[UIColor blackColor];
                [tabCell addSubview:lable];
                
                _textField2=[[UITextField alloc] init];
                _textField2.frame=CGRectMake(lable_Size_W+20, 5, theWidth-(lable_Size_W+20)-50, 30);
                _textField2.delegate=self;
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"area"] isEqualToString:@""]) {
                    
                    _textField2.placeholder=@"请输入建筑面积";
                    
                }else{
                    
                    _textField2.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"area"];
                }
                
                _textField2.font=[UIFont systemFontOfSize:theFont];
                _textField2.clearButtonMode=UITextFieldViewModeWhileEditing;
                _textField2.keyboardType=UIKeyboardTypePhonePad;
                _textField2.borderStyle=UITextBorderStyleNone;
                _textField2.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:_textField2];
                
                
            }else if (indexPath.row==4){
                
                allf=[[UILabel alloc] init]; //WithFrame:CGRectMake(lable_Size_W+20, 5, 40, 30)
                allf.text=@"当前";
                allf.alpha=0.2;
                allf.font=[UIFont systemFontOfSize:theFont];
                allf.textColor=[UIColor blackColor];
                allf.backgroundColor=[UIColor clearColor];
                [allf sizeToFit];
                CGFloat allfOriginX = lable_Size_W + 20;
                CGFloat allfWidth = allf.frame.size.width;
                allf.frame = CGRectMake(allfOriginX, 5, allfWidth, 30);
                [tabCell addSubview:allf];
                
                _textField=[[UITextField alloc] init];
                CGFloat textFieldOriginX = allfOriginX + allfWidth + 5;
                CGFloat textFieldWidth = rowSeconde_Size;
                _textField.frame=CGRectMake(textFieldOriginX, 5, textFieldWidth, 30);
                _textField.textAlignment=NSTextAlignmentCenter;
                _textField.font=[UIFont systemFontOfSize:theFont];
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"allf"] isEqualToString:@""]) {
                    
                }else{
                    
                    _textField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"allf"];
                }
                
                _textField.delegate=self;
                _textField.keyboardType=UIKeyboardTypePhonePad;
                _textField.borderStyle=UITextBorderStyleRoundedRect;
                _textField.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:_textField];
                
                dijic=[[UILabel alloc] init]; //WithFrame:CGRectMake(lable_Size_W+60+rowSeconde_Size, 5, 60, 30)
                dijic.text=@"层，总";
                dijic.alpha=0.2;
                dijic.font=[UIFont systemFontOfSize:theFont];
                dijic.backgroundColor=[UIColor clearColor];
                dijic.textColor=[UIColor blackColor];
                [dijic sizeToFit];
                CGFloat dijicOriginX = textFieldOriginX + textFieldWidth + 5;
                CGFloat dijicWidth = dijic.frame.size.width;
                dijic.frame = CGRectMake(dijicOriginX, 5, dijicWidth, 30);
                [tabCell addSubview:dijic];
                
                _ditextField=[[UITextField alloc] init];
                CGFloat ditextFieldOriginX = dijicOriginX + dijicWidth + 5;
                CGFloat ditextFieldWidth = rowSeconde_Size;
                _ditextField.frame=CGRectMake(ditextFieldOriginX, 5, ditextFieldWidth, 30);
                _ditextField.textAlignment=NSTextAlignmentCenter;
                _ditextField.font=[UIFont systemFontOfSize:theFont];
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"dif"] isEqualToString:@""]) {
                    
                }else{
                    
                    _ditextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"dif"];
                }
                
                _ditextField.delegate=self;
                _ditextField.keyboardType=UIKeyboardTypePhonePad;
                _ditextField.borderStyle=UITextBorderStyleRoundedRect;
                _ditextField.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:_ditextField];
                
                ceng=[[UILabel alloc] init]; //WithFrame:CGRectMake(lable_Size_W+60+rowSeconde_Size+58+rowSeconde_Size, 5, 20, 30)
                ceng.text=@"层";
                ceng.alpha=0.2;
                ceng.font=[UIFont systemFontOfSize:theFont];
                ceng.backgroundColor=[UIColor clearColor];
                ceng.textColor=[UIColor blackColor];
                [ceng sizeToFit];
                CGFloat cengOriginX = ditextFieldOriginX + ditextFieldWidth + 5;
                CGFloat cengWidth = ceng.frame.size.width;
                ceng.frame = CGRectMake(cengOriginX, 5, cengWidth, 30);
                [tabCell addSubview:ceng];

            }
            
            else  if (indexPath.row==5) {


                liftLable=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"liftf"] isEqualToString:@""]) {
                    
                    liftLable.text=@"是否有电梯";
                    liftLable.alpha=0.2;
                    
                }else{
                    
                    liftLable.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"liftf"];
                    if ([liftLable.text isEqualToString:@"是否有电梯"]) {
                        liftLable.alpha=0.2;
                    }else{
                        liftLable.alpha=1;
                    }
                    
                    
                }
                liftLable.font=[UIFont systemFontOfSize:theFont];
                
                liftLable.textColor=[UIColor blackColor];
                liftLable.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:liftLable];

                
            }else  if (indexPath.row==6){
                
                _orientationLable=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 150, 40)];
                _orientationLable.font=[UIFont systemFontOfSize:theFont];
                
                _orientationLable.backgroundColor=[UIColor clearColor];
                _orientationLable.textColor=[UIColor blackColor];
                _orientationLable.textAlignment=NSTextAlignmentLeft;
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"orientation"] isEqualToString:@""]) {
                    
                    _orientationLable.text=@"请选择朝向";
                    _orientationLable.alpha=0.2;
                    
                }else{
                    
                    _orientationLable.text=[[NSUserDefaults standardUserDefaults]  objectForKey:@"orientation"];
                    if ([_orientationLable.text isEqualToString:@"请选择朝向"]) {
                        _orientationLable.alpha=0.2;
                    }else{
                        _orientationLable.alpha=1;
                    }
                    
                }
                
                [tabCell addSubview:_orientationLable];
                
            }else if (indexPath.row==7){
                
                decorationtype=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
    
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"decorationtype"] isEqualToString:@""]) {
                    
                    decorationtype.text=@"请选择装修类型";
                    decorationtype.alpha=0.2;
                    
                }else{
                    
                    decorationtype.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"decorationtype"];
                    if ([decorationtype.text isEqualToString:@"请选择装修类型"]) {
                        decorationtype.alpha=0.2;
                    }else{
                        decorationtype.alpha=1;
                    }
                }
                decorationtype.font=[UIFont systemFontOfSize:theFont];
                decorationtype.textColor=[UIColor blackColor];
                decorationtype.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:decorationtype];
                
                
            }else  if (indexPath.row==8){
                
                propertytype=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
               
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"propertytype"] isEqualToString:@""]) {
                    
                    propertytype.text=@"请选择物业类型";
                     propertytype.alpha=0.2;
                    
                }else{
                    
                    propertytype.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"propertytype"];
                    if ([propertytype.text isEqualToString:@"请选择物业类型"]) {
                        propertytype.alpha=0.2;
                    }else{
                        propertytype.alpha=1;
                    }
                }
                

                propertytype.font=[UIFont systemFontOfSize:theFont];
                propertytype.textColor=[UIColor blackColor];
                propertytype.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:propertytype];
                
   
            }else  if (indexPath.row==9){
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-60, 5, 40, 30)];
                lable.text=@"年";
                lable.textAlignment=NSTextAlignmentRight;
                lable.font=[UIFont systemFontOfSize:theFont];
                
                lable.backgroundColor=[UIColor clearColor];
                lable.textColor=[UIColor blackColor];
                [tabCell addSubview:lable];
                
                bulidingYear=[[UITextField alloc] init];
                bulidingYear.frame=CGRectMake(lable_Size_W+20, 5, theWidth-(lable_Size_W+20)-50, 30);
                bulidingYear.delegate=self;
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"bulidingYear"] isEqualToString:@""]) {
                    
                    bulidingYear.placeholder=@"请输入建筑年份";
                    bulidingYear.text = [self thisYear];
                    
                }else{
                    
                    bulidingYear.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"bulidingYear"];
                }
                
                bulidingYear.font=[UIFont systemFontOfSize:theFont];
                bulidingYear.clearButtonMode=UITextFieldViewModeWhileEditing;
                bulidingYear.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
                bulidingYear.borderStyle=UITextBorderStyleNone;
                bulidingYear.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:bulidingYear];

                
            }else  if(indexPath.row==10){
                
                stopTime=[[UILabel alloc] initWithFrame:CGRectMake(lable_Size_W+20, 0, theWidth-(lable_Size_W+20)-30, 40)];
                stopTime.font=[UIFont systemFontOfSize:theFont];
                stopTime.backgroundColor=[UIColor clearColor];
                stopTime.textColor=[UIColor blackColor];
                stopTime.textAlignment=NSTextAlignmentLeft;
                
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"stopTime"] isEqualToString:@""]) {
                    
                    stopTime.text=@"请选择截止时间";
                    stopTime.alpha=0.2;
                    
                }else{
                    
                    stopTime.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"stopTime"];
                    if ([stopTime.text isEqualToString:@"请选择截止时间"]) {
                        stopTime.alpha=0.2;
                    }else{
                        stopTime.alpha=1;
                    }
                }
                
                [tabCell addSubview:stopTime];
                
   
            }else  if(indexPath.row==11){
                
                tiptextf=[[UITextField alloc] init];
                tiptextf.frame=CGRectMake(lable_Size_W+20, 5, theWidth-(lable_Size_W+20)-50, 30);
                tiptextf.delegate=self;
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"tiptextf"] isEqualToString:@""]) {
                    
                    tiptextf.placeholder=@"请输入标题";
                    
                }else{
                    
                    tiptextf.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"tiptextf"];
                }

                tiptextf.font=[UIFont systemFontOfSize:theFont];
                tiptextf.clearButtonMode=UITextFieldViewModeWhileEditing;
                tiptextf.borderStyle=UITextBorderStyleNone;
                tiptextf.backgroundColor=[UIColor clearColor];
                [tabCell addSubview:tiptextf];

                
            }else  if(indexPath.row==12){

                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, theWidth, 30)];
                lable.alpha=0.8;
                lable.backgroundColor=[UIColor clearColor];
                lable.text=@"房源自评";
                lable.font=[UIFont systemFontOfSize:theFont];
                [tabCell addSubview:lable];
                
                _textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 50, theWidth-20, 150)];
                _textView.delegate=self;
                _textView.font=[UIFont systemFontOfSize:theFont];
                
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"comment"] isEqualToString:@""]) {

                    theTishiLable.text=@"写点您房源的卖点吧！例如装修情况、小区环境等等";
                    
                }else{
                    
                    _textView.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"comment"];
                }

                _textView.font=[UIFont systemFontOfSize:18];
                _textView.layer.borderWidth = 1;
                _textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
                _textView.layer.cornerRadius = 6;
                [tabCell addSubview:_textView];
                
                _textView.layer.masksToBounds=YES;
                
                
                theTishiLable=[[UILabel alloc] initWithFrame:CGRectMake(15, 15, theWidth-15, 20)];
                theTishiLable.font=[UIFont systemFontOfSize:theFont];
                theTishiLable.textColor=[UIColor grayColor];
                theTishiLable.alpha=0.5;
                theTishiLable.backgroundColor=[UIColor clearColor];
                
                if (_textView.text.length==0) {
                    
                    theTishiLable.text=@"写点您房源的卖点吧！例如装修情况、小区环境等等";
                }
                
                CGSize size1 = CGSizeMake(theWidth-30, MAXFLOAT);
                theTishiLable.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize1 = [theTishiLable sizeThatFits:size1];
                theTishiLable.frame = CGRectMake(15, 15, theWidth-40, lableSize1.height);
                [_textView addSubview:theTishiLable];
                

                tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                
                
            }
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, lable_Size_W, 30)];
            lable.font=[UIFont systemFontOfSize:theFont];
            lable.backgroundColor=[UIColor clearColor];
            lable.text=[_titleArr objectAtIndex:indexPath.row];
            lable.alpha=0.8;
            [tabCell addSubview:lable];

  
    }
    return tabCell;
}


#pragma  mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row==12) {
            
            return 500;
            
        }else{
            
            return 40;
        
    }
        
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return headView_Size;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    NSLog(@"===Encoded imaged:\n%@", _imageArrQian);
    
    if (_imageArrQian.count==0) {
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,theWidth, headView_Size)];
        view.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(30, 3, theWidth-30*2, 30)];
        lable.text=@"有照片的房子电话量会提高50%";
        lable.font=[UIFont systemFontOfSize:theFont];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.textColor=[UIColor colorWithRed:240/255.0 green:151/255.0 blue:34/255.0 alpha:1];
        lable.backgroundColor=[UIColor clearColor];
        [view addSubview:lable];
        
        UIButton *imageButton=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-80)/2, 35, 70, 70)];
        imageButton.backgroundColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
        [imageButton addTarget:self action:@selector(checkImageAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:imageButton];
        
        imageViewTheButton=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageViewTheButton.backgroundColor=[UIColor grayColor];
        imageViewTheButton.image=[UIImage imageNamed:@"delePic1"];
        [imageButton addSubview:imageViewTheButton];
        
        return view;
        
    }else{

        PicView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,theWidth, headView_Size)];
        PicView.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
     
        //压缩后
        _imageArr=[[NSMutableArray alloc] init];
        
        for (int i=0; i<_imageArrQian.count; i++) {
            
            UIButton *buttonImage;
            UIButton *addImageButton1;
            
            if (i>2) {
                
                if (i==4) {
                    
                    buttonImage=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-70*3)/4*(i-2)+70*(i-3) , 10*2+70, 70, 70)];
                    
                }else{
                    
                    buttonImage=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-70*3)/4*(i-2)+70*(i-3) , 10*2+70, 70, 70)];
                    
                    
                    addImageButton1=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-70*3)/4*(i-1)+70*(i-2) , 10*2+70, 70, 70)];
                }
                
            }else{
                
                if (i==2) {
                    
                    buttonImage=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-70*3)/4*(i+1)+70*i , 10, 70, 70)];
                    
                    addImageButton1=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-70*3)/4 , 10*2+70, 70, 70)];
                    
                }else{
                    
                    buttonImage=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-70*3)/4*(i+1)+70*i , 10, 70, 70)];
                    
                    addImageButton1=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-70*3)/4*(i+2)+70*(i+1) , 10, 70, 70)];
                }
                
                
            }
            
            UIButton *delButton=[[UIButton alloc] initWithFrame:CGRectMake(50, 0, 20, 20)];
            [delButton setImage:[UIImage imageNamed:@"HUD_NO"] forState:UIControlStateNormal];
            delButton.titleLabel.text=[[NSString alloc] initWithFormat:@"%d",i];
            [delButton addTarget:self action:@selector(delImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [buttonImage addSubview:delButton];
            
            //[buttonImage addTarget:self action:@selector(picBorweseAction) forControlEvents:UIControlEventTouchUpInside];
            
            buttonImage.backgroundColor=[UIColor clearColor];
            [buttonImage setImage:_imageArrQian[i] forState:UIControlStateNormal];
            [PicView addSubview:buttonImage];
            
            // 继续添加图片
            
            [addImageButton1 setImage:[UIImage imageNamed:@"delePic1"] forState:UIControlStateNormal];
            [addImageButton1 addTarget:self action:@selector(checkImageAction) forControlEvents:UIControlEventTouchUpInside];
            [PicView addSubview:addImageButton1];
            
            UIImage *tempImg=_imageArrQian[i];
            //设置image的尺寸
            CGSize imagesize = tempImg.size;
            imagesize.height =400;
            imagesize.width =568;
            
            //对图片大小进行压缩--
            
            tempImg = [self imageWithImage:tempImg scaledToSize:imagesize];
            
            //IOS图片转base64字符串
            //0.1f压缩
            NSData *_data = UIImageJPEGRepresentation(tempImg, 0.00001f);
            
            NSString *_encodedImageStr = [_data base64Encoding];
            
            // NSLog(@"===Encoded image:\n%@", _encodedImageStr);
            
            [_imageArr addObject:_encodedImageStr];
            
        }
        
        return PicView;
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
     [_ditextField resignFirstResponder];
     [_textField resignFirstResponder];
    
    
        if (indexPath.row==5) {
          
            [self alertCtr:@"3"];
            
            
        }else if (indexPath.row==2){
            
            [self alertCtr:@"7"];
            
        }else if (indexPath.row==6){
            
            [self alertCtr:@"1"];
            
        }else if (indexPath.row==7){
            
            [self alertCtr:@"4"];

        }
        else if (indexPath.row==10){
            
            
            [self alertCtr:@"2"];
            
        }else if (indexPath.row==8){
            
            [self alertCtr:@"5"];

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
    if (_houseAddess==textField) {
        addressLable.text=@"";
        
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    if (_textField==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 3) {
            return NO;
        }
    }
    
    if (_textField2==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 5) {
            return NO;
        }
    }
    
    if (_houseAddess==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 100) {
            return NO;
        }
    }
    
    if (_houseNameTextFiled==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 30) {
            return NO;
        }
    }
  
    if (bulidingYear == textField) {
//        if (<#condition#>) {
//            <#statements#>
//        }
        NSLog(@"%zi",range.length);
    }

    
    return YES;
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    theTishiLable.text=@"";
    
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
        if (existedLength - selectedLength + replaceLength > 2001) {
            return NO;
        }
        
    }
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);
    
    NSLog(@"_imageArr=%ld",(unsigned long)_imageArr.count);
    
    HouseSaleNextViewController *houseNextView=[[HouseSaleNextViewController alloc] init];
    houseNextView.hid=[dic objectForKey:@"hid"];
    houseNextView.imageArr=_imageArr;
    houseNextView.title=@"委托发布";
    [self.navigationController pushViewController:houseNextView animated:YES];
    

}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    [self.view.window showHUDWithText:@"网络异常" Type:ShowPhotoNo Enabled:YES];
    
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    
    UIImage *theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [_imageArrQian addObject:theImage];
    
    [_tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - ZYQAssetPickerController Delegate

-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
        });
        
        for (int i=0; i<assets.count; i++) {
            
            ALAsset *asset=assets[i];
            
            UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            
            
            [_imageArrQian addObject:tempImg];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_tableView reloadData];
                
            });
            
        }
        
    });
    
}


#pragma mark - AllActon

-(void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

//对图片尺寸进行压缩--

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

-(void)picBorweseAction{
    
    PicBrowserViewController *picBrowView=[[PicBrowserViewController alloc] init];
    picBrowView.imageArray=_imageArrQian;
    picBrowView.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:picBrowView animated:YES];
    
}


-(void)checkImageAction
{
    
    UIAlertController *alertCtr=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //    按钮事件
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        //        UIImagePickerControllerCameraDeviceRear, 后置摄像头
        //        UIImagePickerControllerCameraDeviceFront 前置摄像头
        BOOL isCamera =  [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            
            NSLog(@"不支持摄像头");
            
            return;
        }
        //拍照模式
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        
        [self presentViewController:imagePicker animated:YES completion:^{
        }];
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //选择多张本地相册
        
        ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
        picker.maximumNumberOfSelection = 5-_imageArrQian.count;//最多选5张
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.showEmptyGroups=NO;
        picker.delegate=self;
        picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                
                return duration >= 5;
                
            } else {
                
                return YES;
                
            }
            
        }];
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    //    把事件添加到控制器
    [alertCtr addAction:cancelAction];
    [alertCtr addAction:sureAction];
    [alertCtr addAction:otherAction];
    //    模态视图
    [self presentViewController:alertCtr animated:YES completion:^{
        
    }];
    
}


//picker值改变时赋给stopTime
-(void)changeAction
{
    NSDate *selectedDate = datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    stopTime.text=dateString;
}


-(void)delImageAction:(UIButton *)sender
{
    
    [_imageArrQian removeObjectAtIndex:[sender.titleLabel.text intValue]];
    
    [_tableView reloadData];
    
}



-(void)commitAction
{
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *buildings=_houseNameTextFiled.text;
    NSString *address=_houseAddess.text;
    NSString *area=_textField2.text;
    NSString *housetype=houestypeLable.text;
    NSString *louceng=[[NSString alloc] initWithFormat:@"%@%@%@%@%@",allf.text,_textField.text,dijic.text,_ditextField.text,ceng.text];
    NSString *liftStr=liftLable.text;
    NSString *orientation=_orientationLable.text;
    NSString *decorationtypeStr=decorationtype.text;
    NSString *propertytypeStr=propertytype.text;
    NSString *bulidingYearStr=bulidingYear.text;
    NSString *stopTimeStr=stopTime.text;
    NSString *comment=_textView.text;
    NSString *tiptextfStr=tiptextf.text;
    
    NSLog(@"houseName=%@",buildings);
    NSLog(@"address=%@",address);
    NSLog(@"housetype=%@",housetype);
    NSLog(@"area=%@",area);
    NSLog(@"louceng=%@",louceng);
    NSLog(@"liftStr=%@",liftStr);
    NSLog(@"orientation=%@",orientation);
    NSLog(@"decorationtypeStr=%@",decorationtypeStr);
    NSLog(@"propertytypeStr=%@",propertytypeStr);
    NSLog(@"bulidingYearStr=%@",bulidingYearStr);
    NSLog(@"stopTimeStr=%@",stopTimeStr);
    NSLog(@"tiptextfStr=%@",tiptextfStr);
    NSLog(@"comment=%@",comment);
    
    
    if (buildings.length!=0) {
        
        if (address.length!=0) {
            
            if (![housetype isEqualToString:@"请选择室厅卫"]) {
                
                if (area.length!=0) {
                    
                    if ([_textField.text intValue] <=[_ditextField.text intValue]) {
                    
                    
                    if (louceng.length>4) {
                        
                        if (![liftStr isEqualToString:@"是否有电梯"]) {
                            
                            if (![orientation isEqualToString:@"请选择朝向"]) {
                                
                                if (![decorationtypeStr isEqualToString:@"请选择装修类型"]) {
                                    
                                    if (![propertytypeStr isEqualToString:@"请选择物业类型"]) {
                                    
                                        if ([bulidingYearStr integerValue] < [[self thisYear] integerValue]) {
                                            
                                            if (![stopTimeStr isEqualToString:@"请选择截止时间"]) {
                                                if (tiptextfStr.length!=0) {
                                                    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1053\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"buildings\":\"%@\",\"address1\":\"%@\",\"housetype\":\"%@\",\"area\":\"%@\",\"floor\":\"%@\",\"elevator\":\"%@\",\"orientation\":\"%@\",\"decoration\":\"%@\",\"propertytype\":\"%@\",\"buildage\":\"%@\",\"stoptime\":\"%@\",\"title\":\"%@\",\"comment\":\"%@\",\"tradetype\":\"1\",\"dealstate\":\"1\",\"disstate\":\"1\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],buildings,address,housetype,area,louceng,liftStr,orientation,decorationtypeStr,propertytypeStr,bulidingYearStr,stopTimeStr,tiptextfStr,comment];
                                                    
                                                    httpRequest=[HttpRequestCalss sharnInstance];
                                                    httpRequest.delegate=self;
                                                    [httpRequest httpRequest:strJson1];
                                                }else{
                                                    [self.view.window showHUDWithText:@"请输入标题" Type:ShowPhotoNo Enabled:YES];
                                                }
                                            }else{
                                                [self.view.window showHUDWithText:@"请选择截止时间" Type:ShowPhotoNo Enabled:YES];
                                            }
                                            
                                        }else{
                                            
                                            if (bulidingYearStr.length == 0) {
                                                if (![stopTimeStr isEqualToString:@"请选择截止时间"]) {
                                                    if (tiptextfStr.length!=0) {
                                                        NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1053\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"buildings\":\"%@\",\"address1\":\"%@\",\"housetype\":\"%@\",\"area\":\"%@\",\"floor\":\"%@\",\"elevator\":\"%@\",\"orientation\":\"%@\",\"decoration\":\"%@\",\"propertytype\":\"%@\",\"buildage\":\"%@\",\"stoptime\":\"%@\",\"title\":\"%@\",\"comment\":\"%@\",\"tradetype\":\"1\",\"dealstate\":\"1\",\"disstate\":\"1\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],buildings,address,housetype,area,louceng,liftStr,orientation,decorationtypeStr,propertytypeStr,@"未知",stopTimeStr,tiptextfStr,comment];
                                                        
                                                        httpRequest=[HttpRequestCalss sharnInstance];
                                                        httpRequest.delegate=self;
                                                        [httpRequest httpRequest:strJson1];
                                                    }else{
                                                        [self.view.window showHUDWithText:@"请输入标题" Type:ShowPhotoNo Enabled:YES];
                                                    }
                                                }else{
                                                    [self.view.window showHUDWithText:@"请选择截止时间" Type:ShowPhotoNo Enabled:YES];
                                                }
                                            }else{
                                                [self.view.window showHUDWithText:@"请输入有效的建筑年份" Type:ShowPhotoNo Enabled:YES];
                                            }
                                        }
                                        
                                    }else{
                                        [self.view.window showHUDWithText:@"请选择物业类型" Type:ShowPhotoNo Enabled:YES];
                                    }
                                }else{
                                    [self.view.window showHUDWithText:@"请选择装修类型" Type:ShowPhotoNo Enabled:YES];
                                }
                                
                            }else{
                                [self.view.window showHUDWithText:@"请选择朝向" Type:ShowPhotoNo Enabled:YES];
                            }
                            
                        }else{
                            
                            [self.view.window showHUDWithText:@"是否有电梯" Type:ShowPhotoNo Enabled:YES];
                        }
                    }else{
                        [self.view.window showHUDWithText:@"请选择室厅卫" Type:ShowPhotoNo Enabled:YES];
                    }
                   }else{
                        [self.view.window showHUDWithText:@"楼层有误" Type:ShowPhotoNo Enabled:YES];
                   }
                    
                }else{
                    [self.view.window showHUDWithText:@"请输入面积" Type:ShowPhotoNo Enabled:YES];
                }
            }else{
                [self.view.window showHUDWithText:@"请输入完整的户型" Type:ShowPhotoNo Enabled:YES];
            }
            
        }else{
            [self.view.window showHUDWithText:@"请输入地址" Type:ShowPhotoNo Enabled:YES];
        }
        
    }else{
        
        [self.view.window showHUDWithText:@"请输入楼盘名称" Type:ShowPhotoNo Enabled:YES];
    }
    
    
}
-(void)alertCtr:(NSString *)typeStr
{
    
    if ([typeStr isEqualToString:@"1"]) {
        
        UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *sureAction1 = [UIAlertAction actionWithTitle:@"东" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _orientationLable.text=@"东";
            _orientationLable.alpha=1;
            
        }];
        
        UIAlertAction *sureAction2 = [UIAlertAction actionWithTitle:@"南" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _orientationLable.text=@"南";
            _orientationLable.alpha=1;
            
        }];
        UIAlertAction *sureAction3= [UIAlertAction actionWithTitle:@"西" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _orientationLable.text=@"西";
            _orientationLable.alpha=1;
            
            
        }];
        UIAlertAction *sureAction4 = [UIAlertAction actionWithTitle:@"北" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _orientationLable.text=@"北";
            _orientationLable.alpha=1;
        }];
        UIAlertAction *sureAction5 = [UIAlertAction actionWithTitle:@"东南" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            _orientationLable.text=@"东南";
            _orientationLable.alpha=1;
        }];
        UIAlertAction *sureAction6 = [UIAlertAction actionWithTitle:@"西南" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _orientationLable.text=@"西南";
            _orientationLable.alpha=1;
            
        }];
        UIAlertAction *sureAction7 = [UIAlertAction actionWithTitle:@"东北" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _orientationLable.text=@"东北";
            _orientationLable.alpha=1;
            
        }];
        UIAlertAction *sureAction8 = [UIAlertAction actionWithTitle:@"西北" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _orientationLable.text=@"西北";
            _orientationLable.alpha=1;
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
        [alertViewCtr addAction:sureAction6];
        [alertViewCtr addAction:sureAction7];
        [alertViewCtr addAction:sureAction8];
        
        //    模态视图
        [self presentViewController:alertViewCtr animated:YES completion:^{
            
        }];
        
        
    }else if ([typeStr isEqualToString:@"2"]){
        
        // 这是一个时间选择器
        
        datePicker = [[UIDatePicker alloc] init];
        datePicker.frame = CGRectMake(((theWidth)-280)/2, 10, 280, 160);
        
        datePicker.date = [NSDate date];
        datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*24*365*10];
        datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:60*60*24*365*10];
        datePicker.datePickerMode =  UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(changeAction) forControlEvents:
         UIControlEventValueChanged ];
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert.view addSubview:datePicker];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            //picker当前时间
            NSDate *selectedDate = datePicker.date;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd";
            NSString *dateString = [formatter stringFromDate:selectedDate];
            stopTime.text=dateString;
            stopTime.alpha=1;
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            stopTime.text=@"请选择截止时间";
            
        }];
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:^{ }];
        
        
        
    }else if ([typeStr isEqualToString:@"3"]){
        
        UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *sureAction1 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            liftLable.text=@"是";
            liftLable.alpha=1;
            
        }];
        
        UIAlertAction *sureAction2 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            liftLable.text=@"否";
            liftLable.alpha=1;
            
        }];
        //    UIAlertActionStyleCancel 取消风格只能有一个
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //    把事件添加到控制器
        [alertViewCtr addAction:cancelAction];
        [alertViewCtr addAction:sureAction1];
        [alertViewCtr addAction:sureAction2];
        
        [self presentViewController:alertViewCtr animated:YES completion:^{ }];
        
        
        
    }else if ([typeStr isEqualToString:@"4"]){
        
        UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *sureAction1 = [UIAlertAction actionWithTitle:@"毛坯" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            decorationtype.text=@"毛坯";
            decorationtype.alpha=1;
            
        }];
        
        UIAlertAction *sureAction2 = [UIAlertAction actionWithTitle:@"简单装修" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            decorationtype.text=@"简单装修";
            decorationtype.alpha=1;
            
        }];
        UIAlertAction *sureAction3 = [UIAlertAction actionWithTitle:@"中档装修" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            decorationtype.text=@"中档装修";
            decorationtype.alpha=1;
            
        }];
        
        UIAlertAction *sureAction4 = [UIAlertAction actionWithTitle:@"精装修" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            decorationtype.text=@"精装修";
            decorationtype.alpha=1;
            
            
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
        
        [self presentViewController:alertViewCtr animated:YES completion:^{ }];
        
        
        
    }else if ([typeStr isEqualToString:@"5"]) {
        
        UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *sureAction1 = [UIAlertAction actionWithTitle:@"普通住宅" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            propertytype.text=@"普通住宅";
            propertytype.alpha=1;
            
        }];
        
        UIAlertAction *sureAction2 = [UIAlertAction actionWithTitle:@"写字楼" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            propertytype.text=@"写字楼";
            propertytype.alpha=1;
            
        }];
        UIAlertAction *sureAction3= [UIAlertAction actionWithTitle:@"商铺" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            propertytype.text=@"商铺";
            propertytype.alpha=1;
            
            
        }];
        UIAlertAction *sureAction4 = [UIAlertAction actionWithTitle:@"别墅" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            propertytype.text=@"别墅";
            propertytype.alpha=1;
        }];
        UIAlertAction *sureAction5 = [UIAlertAction actionWithTitle:@"酒店式公寓" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            propertytype.text=@"酒店式公寓";
            propertytype.alpha=1;
        }];
        UIAlertAction *sureAction6 = [UIAlertAction actionWithTitle:@"商住两用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            propertytype.text=@"商住两用";
            propertytype.alpha=1;
            
        }];
        UIAlertAction *sureAction7 = [UIAlertAction actionWithTitle:@"公寓" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            propertytype.text=@"公寓";
            propertytype.alpha=1;
            
        }];
        UIAlertAction *sureAction8 = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            propertytype.text=@"其他";
            propertytype.alpha=1;
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
        [alertViewCtr addAction:sureAction6];
        [alertViewCtr addAction:sureAction7];
        [alertViewCtr addAction:sureAction8];
        
        //    模态视图
        [self presentViewController:alertViewCtr animated:YES completion:^{
            
        }];
        
        
    }else if ([typeStr isEqualToString:@"7"]) {
        
        
        UIView *View=[[UIView alloc] init];
        View.frame= CGRectMake(10, 10, 250, 180);
        View.backgroundColor=[UIColor clearColor];
        
        thepickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 250, 180)];
        thepickerView.backgroundColor = [UIColor clearColor];
        thepickerView.dataSource = self;
        thepickerView.delegate = self;
        [View addSubview:thepickerView];
        
        NSArray *lableArr=@[@"室",@"厅",@"卫"];
        
        for (int i=0; i<lableArr.count; i++) {
            
            UILabel *labe=[[UILabel alloc] initWithFrame:CGRectMake((250-250/7*3)/4*(i+1)+250/7*i+25, 70, 250/7, 40)];
            labe.textColor=[UIColor blackColor];
            labe.textAlignment=NSTextAlignmentCenter;
            labe.text=lableArr[i];
            [thepickerView addSubview:labe];
            
        }
        
        
        _shiArry =@[@"1",@"2",@"3",@"4",@"5",@"6"];
        _tiArry =@[@"0",@"1",@"2",@"3",@"4",@"5",@"6"];
        _weiArry =@[@"0",@"1",@"2",@"3",@"4",@"5",@"6"];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert.view addSubview:View];
        
        
        value1=@"1";
        value2=@"";
        value3=@"";
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            if (([value2 isEqualToString:@""] && ![value3 isEqualToString:@""]) ||[value2 isEqualToString:@"0"]){
                
                houestypeLable.text=[[NSString alloc] initWithFormat:@"%@室%@卫",value1,value3];
                
            }else if (([value2 isEqualToString:@""] && [value3 isEqualToString:@""]) ||([value2 isEqualToString:@"0"] && [value3 isEqualToString:@"0"])){
                
                houestypeLable.text=[[NSString alloc] initWithFormat:@"%@室",value1];
                
            }else if (([value3 isEqualToString:@""]||[value3 isEqualToString:@"0"]) && (![value2 isEqualToString:@""] ||![value2 isEqualToString:@"0"])){
                
                houestypeLable.text=[[NSString alloc] initWithFormat:@"%@室%@厅",value1,value2];
                
            }else{
                
                houestypeLable.text=[[NSString alloc] initWithFormat:@"%@室%@厅%@卫",value1,value2,value3];
                
            }
            houestypeLable.alpha=1;
            
        }];
        
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:^{ }];
        
    }
    
    
    
}

#pragma mark UIPickerViewDataSource

//返回的列数
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}

//返回的行数
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (component == 0) {
        
        return _shiArry.count;
        
    }else if(component == 1)
    {
        return _tiArry.count;
        
    }else{
        return _weiArry.count;
    }
    
}

#pragma mark UIPickerViewDelegate

//返回的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    //    component 列数
    //    row  行数
    if (component == 0) {
        
        return [_shiArry objectAtIndex:row];
        
    }else if(component == 1)
    {
        return [_tiArry objectAtIndex:row];
        
    }else{
        
        return [_weiArry objectAtIndex:row];
        
    }
    
}
//选择的事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;{
    
    if (component == 0) {
        
        value1=[_shiArry objectAtIndex:row];
        
        
    }else if(component == 1)
    {
        value2=[_tiArry objectAtIndex:row];
        
        
    }else{
        
        value3=[_weiArry objectAtIndex:row];
        
        
    }
    
    
}
//返回列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
{
    return 70;
}
//返回行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;
{
    return 30;
}

@end
