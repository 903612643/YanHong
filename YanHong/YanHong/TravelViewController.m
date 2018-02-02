//
//  TravelViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/1/21.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "TravelViewController.h"
#import "UIWindow+YzdHUD.h"
#import "PicBrowserViewController.h"
#import "YH_FriendViewController.h"
#import "PhoneClass.h"

@interface TravelViewController ()

@end

@implementation TravelViewController

static int headView_Size=170;

static int theFont;

static int lable_Size_W;

static int rowSeconde_Size;

static int TheSexButton_Sex_w;
static int TheSexButton_Sex_h;

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
    NSString *rentStr=_textField7.text;
    NSString *paytypeStr=_payTypeTextField.text;
    NSString *deviceStr=_deviceTextField.text;
    NSString *tiptextfStr=tiptextf.text;
    NSString *comment=_textView.text;
    NSString *usernameStr=_userNameTextField.text;
    NSString *userphoneStr=_userPhoneTextField.text;
    
    
    userDef=[NSUserDefaults standardUserDefaults];
    [userDef setObject:buildings forKey:@"thebuildings"];
    [userDef setObject:address forKey:@"theaddress"];
    [userDef setObject:houestypeLable.text forKey:@"thehousetype"];
    [userDef setObject:area forKey:@"thearea"];
    [userDef setObject:_textField.text forKey:@"theallf"];
    [userDef setObject:_ditextField.text forKey:@"thedif"];
    [userDef setObject:liftStr forKey:@"theliftf"];
    [userDef setObject:orientation forKey:@"theorientation"];
    [userDef setObject:decorationtypeStr forKey:@"thedecorationtype"];
    [userDef setObject:propertytypeStr forKey:@"thepropertytype"];
    [userDef setObject:bulidingYearStr forKey:@"thebulidingYear"];
    [userDef setObject:rentStr forKey:@"therent"];
    [userDef setObject:paytypeStr forKey:@"thepaytype"];
    [userDef setObject:deviceStr forKey:@"thedeviceStr"];
    [userDef setObject:tiptextfStr forKey:@"thetiptextf"];
    [userDef setObject:comment forKey:@"thecomment"];
    [userDef setObject:usernameStr forKey:@"theusernameStr"];
    [userDef setObject:userphoneStr forKey:@"theuserphoneStr"];
    [userDef synchronize];

    
}

//提示对话框
-(void)alertCtr:(NSString *)str message:(NSString *)message cancel:(NSString *)cancelStr sure:(NSString *)sureStr
{
    
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:str message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        userDef=[NSUserDefaults standardUserDefaults];
        [userDef setObject:@"" forKey:@"thebuildings"];
        [userDef setObject:@"" forKey:@"theaddress"];
        [userDef setObject:@"" forKey:@"theshi"];
        [userDef setObject:@"" forKey:@"thehousetype"];
        [userDef setObject:@"" forKey:@"theallf"];
        [userDef setObject:@"" forKey:@"thedif"];
        [userDef setObject:@"" forKey:@"theliftf"];
        [userDef setObject:@"" forKey:@"theorientation"];
        [userDef setObject:@"" forKey:@"thedecorationtype"];
        [userDef setObject:@"" forKey:@"thepropertytype"];
        [userDef setObject:@"" forKey:@"thebulidingYear"];
        [userDef setObject:@"" forKey:@"therent"];
        [userDef setObject:@"" forKey:@"thepaytype"];
        [userDef setObject:@"" forKey:@"thedeviceStr"];
        [userDef setObject:@"" forKey:@"thetiptextf"];
        [userDef setObject:@"" forKey:@"thecomment"];
        [userDef setObject:@"" forKey:@"theusernameStr"];
        [userDef setObject:@"" forKey:@"theuserphoneStr"];
        [userDef synchronize];
        
        _houseNameTextFiled.placeholder=@"请输入楼盘名称";
        _houseNameTextFiled.text=@"";
        _houseAddess.placeholder=@"请输入楼盘地址";
        _houseAddess.text=@"";
        _textField2.placeholder=@"请输入建筑面积";
        _textField2.text=@"";
        
        _textField4.text=@"";
        _textField5.text=@"";
        _textField6.text=@"";
        
        _textField.text=@"";
        _ditextField.text=@"";
        houestypeLable.text=@"请选择室厅卫";
        _orientationLable.text=@"请选择朝向";
        liftLable.text=@"是否有电梯";
        decorationtype.text=@"请选择装修类型";
        propertytype.text=@"请选择物业类型";
        bulidingYear.placeholder=@"请输入建筑年份";
        bulidingYear.text=@"";
        tiptextf.placeholder=@"请输入标题";
        tiptextf.text=@"";
        theTishiLable.text=@"写点您房源的卖点吧！例如装修情况、小区环境等等";
        
        _userNameTextField.placeholder=@"请输入姓名";
        _userNameTextField.text=@"";
        _userPhoneTextField.placeholder=@"请输入手机号码";
        _userPhoneTextField.text=@"";
        
        zuJin.text=@"请输入租金 元/月";
        
        _payTypeLable.text=@"请输入付款方式";
        
        _deviceLable.text=@"请输入配套设施";

        
        liftLable.alpha=0.2;
        houestypeLable.alpha=0.2;
        decorationtype.alpha=0.2;
        _orientationLable.alpha=0.2;
        propertytype.alpha=0.2;
     
        
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

static int TextView_Size;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.title=@"旅行短租";

    //返回Item
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(commitAction)];
    
    if ((![[[NSUserDefaults standardUserDefaults] objectForKey:@"thebuildings"] isEqual:@""] && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"theaddress"] isEqual:@""])) {
        
        [self alertCtr:@"友情提示" message:@"您有未填写完成的房源" cancel:@"重新填写" sure:@"恢复填写"];
    
    }
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        TheSexButton_Sex_w=60;
        TheSexButton_Sex_h=30;
        
        
        rowSeconde_Size=50;

        theFont=14;
        
        TextView_Size=theHeight+50;
        
        lable_Size_W=70;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        TheSexButton_Sex_w=60;
        TheSexButton_Sex_h=30;
        
        rowSeconde_Size=50;
        
        TextView_Size=theHeight-50;
        
        theFont=14;
        
        lable_Size_W=70;
        
    }else if (IS_IPHONE_6) {  // 6
        
        TheSexButton_Sex_w=70;
        TheSexButton_Sex_h=30;
        
        
        rowSeconde_Size=55;
        
        TextView_Size=theHeight;
        
        theFont=18;
        
        lable_Size_W=80;
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        TheSexButton_Sex_w=70;
        TheSexButton_Sex_h=30;
        
        rowSeconde_Size=55;
        
        TextView_Size=theHeight;
        
        theFont=18;
        
        lable_Size_W=80;
        
    }
    
    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    
//－－－－－－－－－－－－－－－－－－－－－数据源－－－－－－－－－－－－－－－－－－
    _titleArr=[[NSMutableArray alloc] initWithObjects:
               @"楼盘名称",@"地        址",@"户        型",@"建筑面积",@"楼        层",@"电        梯",@"朝        向",@"装修类型",@"物业类型",@"建筑年份",@"租        金",@"付款方式",@"配套设施",@"标        题",@"",@"姓        名",@"性        别",@"手  机  号",@"",
               nil];
    
    getSexStr=[[NSString alloc] init];
    //默认是男性
    getSexStr=@"男";
    
    //压缩前
    _imageArrQian=[[NSMutableArray alloc] init];
    
    imageCount=0;
    
    
}
-(void)popAction
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}
-(void)nextAction
{
    
    UIAlertController *alertCtr=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //    按钮事件
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        
        BOOL isCamera =  [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
        
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
   
    NSString *mycellId = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
   
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:mycellId];
    

    if (myCell==nil) {
        
        myCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycellId];
        
        myCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.row==2||indexPath.row==5||indexPath.row==6||indexPath.row==7||indexPath.row==8) {
            myCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (indexPath.row==0) {
            
            //改成输入
            _houseNameTextFiled=[[UITextField alloc] init];
            _houseNameTextFiled.frame=CGRectMake(lable_Size_W+20, 5, theWidth-lable_Size_W-30, 30);
            
            _houseNameTextFiled.font=[UIFont systemFontOfSize:theFont];
            
            _houseNameTextFiled.delegate=self;
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thebuildings"] isEqualToString:@""]) {
                _houseNameTextFiled.placeholder=@"请输入楼盘名称";
            }else{
                
                _houseNameTextFiled.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thebuildings"];
            }

            _houseNameTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
            _houseNameTextFiled.borderStyle=UITextBorderStyleNone;
            _houseNameTextFiled.backgroundColor=[UIColor clearColor];
            [myCell addSubview:_houseNameTextFiled];
 
        }
        if (indexPath.row==1) {
            
            
            _houseAddess=[[UITextField alloc] init];
            _houseAddess.frame=CGRectMake(lable_Size_W+20, 2, theWidth-lable_Size_W-30, 38);
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"theaddress"] isEqualToString:@""]) {
                _houseAddess.placeholder=@"请输入楼盘地址";
                
            }else{
                
                _houseAddess.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"theaddress"];
                
            }
            tiptextf.text=_houseAddess.text;
            _houseAddess.delegate=self;
            _houseAddess.font=[UIFont systemFontOfSize:theFont];
            _houseAddess.clearButtonMode=UITextFieldViewModeWhileEditing;
            _houseAddess.borderStyle=UITextBorderStyleNone;
            _houseAddess.backgroundColor=[UIColor clearColor];
            [myCell addSubview:_houseAddess];
            
        }
        if (indexPath.row==2) {
            
            
            houestypeLable=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thehousetype"] isEqualToString:@""]) {
                
                houestypeLable.text=@"请选择室厅卫";
                houestypeLable.alpha=0.2;
                
            }else{
                
                houestypeLable.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thehousetype"];
                if ([houestypeLable.text isEqualToString:@"请选择室厅卫"]) {
                    houestypeLable.alpha=0.2;
                }else{
                    houestypeLable.alpha=1;
                }
                
                
            }
            houestypeLable.font=[UIFont systemFontOfSize:theFont];
            houestypeLable.textColor=[UIColor blackColor];
            houestypeLable.backgroundColor=[UIColor clearColor];
            [myCell addSubview:houestypeLable];

            
        }else if (indexPath.row==3){

            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-50, 5, 40, 30)];
            lable.text=@"平米";
            lable.font=[UIFont systemFontOfSize:theFont];
            lable.backgroundColor=[UIColor clearColor];
            lable.textColor=[UIColor blackColor];
            [myCell addSubview:lable];
            
            _textField2=[[UITextField alloc] init];
            _textField2.frame=CGRectMake(100, 5, theWidth-lable_Size_W-60, 30);
            _textField2.delegate=self;
            _textField2.clearButtonMode=UITextFieldViewModeWhileEditing;
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thearea"] isEqualToString:@""]) {
                _textField2.placeholder=@"请输入建筑面积";
            }else{
                
                _textField2.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thearea"];
            }

            _textField2.font=[UIFont systemFontOfSize:theFont];
            _textField2.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _textField2.borderStyle=UITextBorderStyleNone;
            _textField2.backgroundColor=[UIColor clearColor];
            [myCell addSubview:_textField2];

            
        }else  if (indexPath.row==4) {
            
            
            allf=[[UILabel alloc] initWithFrame:CGRectMake(lable_Size_W+20, 5, 20, 30)];
            allf.text=@"共";
            allf.alpha=0.2;
            allf.font=[UIFont systemFontOfSize:theFont];
            allf.textColor=[UIColor blackColor];
            allf.backgroundColor=[UIColor clearColor];
            [myCell addSubview:allf];
            
            _textField=[[UITextField alloc] init];
            _textField.frame=CGRectMake(lable_Size_W+40, 5, rowSeconde_Size, 30);
            _textField.textAlignment=NSTextAlignmentCenter;
            _textField.font=[UIFont systemFontOfSize:theFont];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"theallf"] isEqualToString:@""]) {
                
            }else{
                
                _textField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"theallf"];
            }

            _textField.delegate=self;
            _textField.keyboardType=UIKeyboardTypePhonePad;
            _textField.borderStyle=UITextBorderStyleRoundedRect;
            _textField.backgroundColor=[UIColor clearColor];
            [myCell addSubview:_textField];
            
            dijic=[[UILabel alloc] initWithFrame:CGRectMake(lable_Size_W+40+rowSeconde_Size, 5, 20, 30)];
            dijic.text=@"第";
            dijic.alpha=0.2;
            dijic.font=[UIFont systemFontOfSize:theFont];
            dijic.backgroundColor=[UIColor clearColor];
            dijic.textColor=[UIColor blackColor];
            [myCell addSubview:dijic];
            
            _ditextField=[[UITextField alloc] init];
            _ditextField.frame=CGRectMake(lable_Size_W+40+rowSeconde_Size+20, 5, rowSeconde_Size, 30);
            _ditextField.textAlignment=NSTextAlignmentCenter;
            _ditextField.font=[UIFont systemFontOfSize:theFont];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thedif"] isEqualToString:@""]) {
                
            }else{
                
                _ditextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thedif"];
            }
            
            _ditextField.delegate=self;
            _ditextField.keyboardType=UIKeyboardTypePhonePad;
            _ditextField.borderStyle=UITextBorderStyleRoundedRect;
            _ditextField.backgroundColor=[UIColor clearColor];
            [myCell addSubview:_ditextField];
            
            ceng=[[UILabel alloc] initWithFrame:CGRectMake(lable_Size_W+40+rowSeconde_Size+20+rowSeconde_Size, 5, 20, 30)];
            ceng.text=@"层";
            ceng.alpha=0.2;
            ceng.font=[UIFont systemFontOfSize:theFont];
            ceng.backgroundColor=[UIColor clearColor];
            ceng.textColor=[UIColor blackColor];
            [myCell addSubview:ceng];
            
            
        }else  if (indexPath.row==5){
            
            
            liftLable=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"theliftf"] isEqualToString:@""]) {
                
                liftLable.text=@"是否有电梯";
                liftLable.alpha=0.2;
                
            }else{
                
                liftLable.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"theliftf"];
                if ([liftLable.text isEqualToString:@"是否有电梯"]) {
                    liftLable.alpha=0.2;
                }else{
                    liftLable.alpha=1;
                }

                
            }
            liftLable.font=[UIFont systemFontOfSize:theFont];
            
            liftLable.textColor=[UIColor blackColor];
            liftLable.backgroundColor=[UIColor clearColor];
            [myCell addSubview:liftLable];

            
            
        }else if (indexPath.row==6){
           
            
            _orientationLable=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 150, 40)];
            _orientationLable.font=[UIFont systemFontOfSize:theFont];
            
            _orientationLable.backgroundColor=[UIColor clearColor];
            _orientationLable.textColor=[UIColor blackColor];
            _orientationLable.textAlignment=NSTextAlignmentLeft;
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"theorientation"] isEqualToString:@""]) {
                
                _orientationLable.text=@"请选择朝向";
                _orientationLable.alpha=0.2;
                
            }else{
                
                _orientationLable.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"theorientation"];
                
                if ([_orientationLable.text isEqualToString:@"请选择朝向"]) {
                    
                    _orientationLable.alpha=0.2;
                    
                }else{
                    
                    _orientationLable.alpha=1;
                }

                
            }
            
            [myCell addSubview:_orientationLable];

            
        }else  if (indexPath.row==7){
            
            decorationtype=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thedecorationtype"] isEqualToString:@""]) {
                
                decorationtype.text=@"请选择装修类型";
                decorationtype.alpha=0.2;
                
            }else{
                
                decorationtype.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thedecorationtype"];
                if ([decorationtype.text isEqualToString:@"请选择装修类型"]) {
                    decorationtype.alpha=0.2;
                }else{
                    decorationtype.alpha=1;
                }
               
            }
            decorationtype.font=[UIFont systemFontOfSize:theFont];
            decorationtype.textColor=[UIColor blackColor];
            decorationtype.backgroundColor=[UIColor clearColor];
            [myCell addSubview:decorationtype];

    
        }else  if (indexPath.row==8){
            
            propertytype=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 150, 30)];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thepropertytype"] isEqualToString:@""]) {
                
                propertytype.text=@"请选择物业类型";
                propertytype.alpha=0.2;
                
            }else{
                
                propertytype.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thepropertytype"];
                if ([propertytype.text isEqualToString:@"请选择物业类型"]) {
                    propertytype.alpha=0.2;
                }else{
                    propertytype.alpha=1;
                }
            
            }
            
            
            propertytype.font=[UIFont systemFontOfSize:theFont];
            propertytype.textColor=[UIColor blackColor];
            propertytype.backgroundColor=[UIColor clearColor];
            [myCell addSubview:propertytype];
            

            
        }else  if (indexPath.row==9){
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-60, 5, 40, 30)];
            lable.text=@"年";
            lable.textAlignment=NSTextAlignmentRight;
            lable.font=[UIFont systemFontOfSize:theFont];
            
            lable.backgroundColor=[UIColor clearColor];
            lable.textColor=[UIColor blackColor];
            [myCell addSubview:lable];
            
            bulidingYear=[[UITextField alloc] init];
            bulidingYear.frame=CGRectMake(lable_Size_W+20, 5, theWidth-(lable_Size_W+20)-50, 30);
            bulidingYear.delegate=self;
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thebulidingYear"] isEqualToString:@""]) {
                
                bulidingYear.placeholder=@"请输入建筑年份";
            }else{
                
                bulidingYear.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thebulidingYear"];
            }

            bulidingYear.font=[UIFont systemFontOfSize:theFont];
            bulidingYear.clearButtonMode=UITextFieldViewModeWhileEditing;
            bulidingYear.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            bulidingYear.borderStyle=UITextBorderStyleNone;
            bulidingYear.backgroundColor=[UIColor clearColor];
            [myCell addSubview:bulidingYear];

            
        }else  if (indexPath.row==10){
            
            _textField7=[[UITextField alloc] init];
            _textField7.frame=CGRectMake(lable_Size_W+20, 2, theWidth-lable_Size_W-30, 38);
            _textField7.delegate=self;
            _textField7.font=[UIFont systemFontOfSize:theFont];
            _textField7.clearButtonMode=UITextFieldViewModeWhileEditing;
            _textField7.borderStyle=UITextBorderStyleNone;
            _textField7.backgroundColor=[UIColor clearColor];
            _textField7.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            [myCell addSubview:_textField7];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"therent"] isEqualToString:@""]) {
                
                _textField7.placeholder=@"请输入租金 元/月";
                
            }else{
                _textField7.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"therent"];
            }
  
        }else  if (indexPath.row==11){
            
            _payTypeTextField=[[UITextField alloc] init];
            _payTypeTextField.frame=CGRectMake(lable_Size_W+20, 2, theWidth-lable_Size_W-30, 38);
            _payTypeTextField.delegate=self;
            _payTypeTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
            _payTypeTextField.font=[UIFont systemFontOfSize:theFont];
            _payTypeTextField.borderStyle=UITextBorderStyleNone;
            _payTypeTextField.backgroundColor=[UIColor clearColor];
            [myCell addSubview:_payTypeTextField];
            
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thepaytype"] isEqualToString:@""]) {
                
                _payTypeTextField.placeholder=@"请输入付款方式";
                
            }else{
                _payTypeTextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thepaytype"];
            }

            
        }else if (indexPath.row==12){
            
            _deviceTextField=[[UITextField alloc] init];
            _deviceTextField.frame=CGRectMake(lable_Size_W+20, 2, theWidth-lable_Size_W-30, 38);
            _deviceTextField.delegate=self;
            _deviceTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
            _deviceTextField.font=[UIFont systemFontOfSize:theFont];
            _deviceTextField.borderStyle=UITextBorderStyleNone;
            _deviceTextField.backgroundColor=[UIColor clearColor];
            [myCell addSubview:_deviceTextField];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thedeviceStr"] isEqualToString:@""]) {
                
                _deviceTextField.placeholder=@"请输入配套设施";
                
            }else{
                _deviceTextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thedeviceStr"];
            }
            

            
        }else if (indexPath.row==13){
            
            
            tiptextf=[[UITextField alloc] init];
            
            tiptextf.frame=CGRectMake(lable_Size_W+20, 5, theWidth-(lable_Size_W+20)-50, 30);
            tiptextf.delegate=self;
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thetiptextf"] isEqualToString:@""]) {
                
                tiptextf.placeholder=@"请输入标题";
                
            }else{
                
                tiptextf.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thetiptextf"];
            }
            tiptextf.font=[UIFont systemFontOfSize:theFont];
            tiptextf.clearButtonMode=UITextFieldViewModeWhileEditing;
            tiptextf.borderStyle=UITextBorderStyleNone;
            tiptextf.backgroundColor=[UIColor clearColor];
            [myCell addSubview:tiptextf];

            
        }else if (indexPath.row==14){
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, theWidth, 30)];
            lable.alpha=1;
            lable.backgroundColor=[UIColor clearColor];
            lable.text=@"描        述";
            lable.font=[UIFont systemFontOfSize:theFont];
            [myCell addSubview:lable];
            
            _textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 50, theWidth-20, 150)];
            _textView.delegate=self;
            _textView.font=[UIFont systemFontOfSize:theFont];

            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"thecomment"] isEqualToString:@""]) {
                
                theTishiLable.text=@"如装修状况、配套设施、小区环境、交通状况等。";
                
            }else{
                
                _textView.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"thecomment"];
            }
            
            _textView.font=[UIFont systemFontOfSize:18];
            _textView.layer.borderWidth = 1;
            _textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            _textView.layer.cornerRadius = 6;
            [myCell addSubview:_textView];
            
            _textView.layer.masksToBounds=YES;
            
            
            theTishiLable=[[UILabel alloc] initWithFrame:CGRectMake(15, 15, theWidth-15, 20)];
            theTishiLable.font=[UIFont systemFontOfSize:theFont];
            theTishiLable.textColor=[UIColor grayColor];
            theTishiLable.alpha=0.5;
            theTishiLable.backgroundColor=[UIColor clearColor];
            
            if (_textView.text.length==0) {
                
                theTishiLable.text=@"如装修状况、配套设施、小区环境、交通状况等。";
            }
            
            CGSize size1 = CGSizeMake(theWidth-30, MAXFLOAT);
            theTishiLable.numberOfLines = 0;
            //    ios8使用的方法
            CGSize lableSize1 = [theTishiLable sizeThatFits:size1];
            theTishiLable.frame = CGRectMake(15, 15, theWidth-40, lableSize1.height);
            [_textView addSubview:theTishiLable];
            
            

            
            
        }else if (indexPath.row==15){
            
            _userNameTextField=[[UITextField alloc] init];
            _userNameTextField.frame=CGRectMake(lable_Size_W+20, 2, theWidth-lable_Size_W-30, 38);
        
            _userNameTextField.delegate=self;
            _userNameTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
            _userNameTextField.font=[UIFont systemFontOfSize:theFont];
            _userNameTextField.borderStyle=UITextBorderStyleNone;
            _userNameTextField.backgroundColor=[UIColor clearColor];
            [myCell addSubview:_userNameTextField];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"theusernameStr"] isEqualToString:@""]) {
                
                _userNameTextField.placeholder=@"请输入姓名";
                
            }else{
                
                _userNameTextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"theusernameStr"];
            }

            
        }else if (indexPath.row==16) {
            
            getTextButton=[UIButton buttonWithType:UIButtonTypeCustom];
            getTextButton.frame=CGRectMake(theWidth-TheSexButton_Sex_w-30, (40-TheSexButton_Sex_h)/2,TheSexButton_Sex_w, TheSexButton_Sex_h);
            [getTextButton setImage:[UIImage imageNamed:@"sex"]  forState:UIControlStateNormal ];
            [getTextButton addTarget:self action:@selector(getSexAction) forControlEvents:UIControlEventTouchUpInside];
            [myCell addSubview:getTextButton];

        }else if (indexPath.row==17){
            
            _userPhoneTextField=[[UITextField alloc] init];
            _userPhoneTextField.frame=CGRectMake(lable_Size_W+20, 2, theWidth-lable_Size_W-30, 38);
            _userPhoneTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    
            _userPhoneTextField.delegate=self;
            _userPhoneTextField.font=[UIFont systemFontOfSize:theFont];
            _userPhoneTextField.borderStyle=UITextBorderStyleNone;
            _userPhoneTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _userPhoneTextField.backgroundColor=[UIColor clearColor];
            [myCell addSubview:_userPhoneTextField];
            
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"theuserphoneStr"] isEqualToString:@""]) {
                
                _userPhoneTextField.placeholder=@"请输入手机号码";
                
            }else{
                _userPhoneTextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"theuserphoneStr"];
            }
            

        }
        
    }
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, lable_Size_W, 30)];
    lable.font=[UIFont systemFontOfSize:theFont];
    lable.backgroundColor=[UIColor clearColor];
    lable.text=[_titleArr objectAtIndex:indexPath.row];
    lable.alpha=0.8;
    [myCell addSubview:lable];
    
    
    return myCell;
    
    
}

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

-(void)commitAction
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *buildings=_houseNameTextFiled.text;
    NSString *address=_houseAddess.text;
    NSString *housetype=houestypeLable.text;
    NSString *area=_textField2.text;
    NSString *louceng=[[NSString alloc] initWithFormat:@"%@%@%@%@%@",allf.text,_textField.text,dijic.text,_ditextField.text,ceng.text];
    NSString *liftStr=liftLable.text;
    NSString *orientation=_orientationLable.text;
    NSString *decorationtypeStr=decorationtype.text;
    NSString *propertytypeStr=propertytype.text;
    NSString *bulidingYearStr=bulidingYear.text;
    NSString *rentStr=_textField7.text;
    NSString *paytypeStr=_payTypeTextField.text;
    NSString *deviceStr=_deviceTextField.text;
    NSString *tiptextfStr=tiptextf.text;
    NSString *comment=_textView.text;
    NSString *usernameStr=_userNameTextField.text;
    NSString *userphoneStr=_userPhoneTextField.text;
    
    if ([getSexStr isEqualToString:@"男"]) {
        getSexStr=@"1";
        
    }else{
        getSexStr=@"2";
    }
    if ([liftLable.text isEqualToString:@"是"]) {
        
        liftLable.text=@"1";
        
    }else{
        liftLable.text=@"2";
    }
    
    if (buildings.length!=0) {
        
        if (address.length!=0) {
            
            if (![housetype isEqualToString:@"请选择室厅卫"]) {
                
                
                if (area.length!=0) {
                    
                    if (louceng.length>4) {
                        
                        if ([_textField.text intValue] >=[_ditextField.text intValue]) {

                        
                        if (![liftStr isEqualToString:@"是否有电梯"]) {
                            
                            if (![orientation isEqualToString:@"请选择朝向"]) {
                                
                                if (![decorationtypeStr isEqualToString:@"请选择装修类型"]) {
                                    if (![propertytypeStr isEqualToString:@"请选择物业类型"]) {
                                        if (bulidingYearStr.length!=0) {
                                            
                                            if (rentStr.length!=0) {
                                                
                                                if (paytypeStr.length!=0) {
                                                    
                                                    if (deviceStr.length!=0) {
                                                        if (tiptextfStr.length!=0) {
                                                            if (usernameStr.length!=0) {
                                                                if (userphoneStr.length!=0) {
                                                           
                                                                    
                                                                    [self.view.window showHUDWithText:@"正在发布..." Type:ShowLoading Enabled:YES];
                                                                    
                                                                    _theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
                                                                    _theView.backgroundColor=[UIColor blackColor];
                                                                    _theView.tag=101;
                                                                    _theView.alpha=0.2;
                                                                    [self.view addSubview:_theView];
                                                                    
                                                                        NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1077\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"buildings\":\"%@\",\"address1\":\"%@\",\"housetype\":\"%@\",\"area\":\"%@\",\"floor\":\"%@\",\"elevator\":\"%@\",\"orientation\":\"%@\",\"decoration\":\"%@\",\"propertytype\":\"%@\",\"buildage\":\"%@\",\"paytype\":\"%@\",\"mating\":\"%@\",\"title\":\"%@\",\"comment\":\"%@\",\"tradetype\":\"2\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],buildings,address,housetype,area,louceng,liftStr,orientation,decorationtypeStr,propertytypeStr,bulidingYearStr,paytypeStr,deviceStr,tiptextfStr,comment];

                                                                        httpRequest=[HttpRequestCalss sharnInstance];
                                                                        httpRequest.delegate=self;
                                                                        [httpRequest httpRequest:strJson1];
                                                            
                                                            }else{
                                                                [self.view.window showHUDWithText:@"请输入手机号码" Type:ShowPhotoNo Enabled:YES];
                                                            }
                                                        }else{
                                                            [self.view.window showHUDWithText:@"请输入姓名" Type:ShowPhotoNo Enabled:YES];
                                                        }
                                                        
                                                    }else{
                                                        [self.view.window showHUDWithText:@"请输入标题" Type:ShowPhotoNo Enabled:YES];
                                                    }
                                                }else{
                                                    [self.view.window showHUDWithText:@"请输入配套设施" Type:ShowPhotoNo Enabled:YES];
                                                }
                                                
                                            }else{
                                                [self.view.window showHUDWithText:@"请输入付款方式" Type:ShowPhotoNo Enabled:YES];
                                            }
                                        }else{
                                            [self.view.window showHUDWithText:@"请输入租金" Type:ShowPhotoNo Enabled:YES];
                                            
                                        }
                                    }else{
                                        [self.view.window showHUDWithText:@"请输入建筑年份" Type:ShowPhotoNo Enabled:YES];
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
                        [self.view.window showHUDWithText:@"楼层有误" Type:ShowPhotoNo Enabled:YES];
                    }
                }else{
                    [self.view.window showHUDWithText:@"请输入楼层" Type:ShowPhotoNo Enabled:YES];
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
-(void)againCommitAction
{
    
    NSString *rentStr=_textField7.text;
    NSString *usernameStr=_userNameTextField.text;
    NSString *userphoneStr=_userPhoneTextField.text;
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //房源信息发布（转发）
    
    NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1057\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"hid\":\"%@\",\"fid\":\"0\",\"price\":\"%@\",\"contact\":\"%@\",\"disphone\":\"%@\",\"recievedid\":\"0\",\"validcode\":\"\",\"tradetype\":\"2\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[dic objectForKey:@"hid"],rentStr,usernameStr,userphoneStr];
    
    httpRequest=[HttpRequestCalss sharnInstance];
    httpRequest.delegate=self;
    [httpRequest httpRequest:strJson];

    
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row==14) {
        
        return 210;
        
    }else if (indexPath.row==18){
        
        return 400;
        
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
        [imageButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:imageButton];
        
        imageViewTheButton=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageViewTheButton.backgroundColor=[UIColor grayColor];
        imageViewTheButton.image=[UIImage imageNamed:@"delePic1"];
        [imageButton addSubview:imageViewTheButton];
        
        
        return view;
        
    }else{
        
        PicView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,theWidth, headView_Size)];
        PicView.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [_theTableView addSubview:PicView];
        
        //已选择的照片
        
        
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
            [addImageButton1 addTarget:self action:@selector(checkPicAction) forControlEvents:UIControlEventTouchUpInside];
            [PicView addSubview:addImageButton1];
            
            UIImage *tempImg=_imageArrQian[i];
            //设置image的尺寸
            CGSize imagesize = tempImg.size;
            imagesize.height =320;
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
-(void)delImageAction:(UIButton *)sender
{
    
    [_imageArrQian removeObjectAtIndex:[sender.titleLabel.text intValue]];
    
    [_theTableView reloadData];
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
        
    }else if (indexPath.row==6){
        
        [self alertCtr:@"1"];
        
    }else if (indexPath.row==7){
        
        [self alertCtr:@"4"];
        
    }else if (indexPath.row==8){
        
        [self alertCtr:@"5"];
        
    }else if (indexPath.row==2){
        
        [self alertCtr:@"7"];
        
        
    }
    
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
    
    if (_textField4==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 2) {
            return NO;
        }
    }
    
    if (_textField5==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 2) {
            return NO;
        }
    }
    if (_textField6==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 2) {
            return NO;
        }
    }
    if (_textField7==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 20) {
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
    if (_deviceTextField==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 30) {
            return NO;
        }
    }
    if (_userNameTextField==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 30) {
            return NO;
        }
    }
    if (_userPhoneTextField==textField) {
        if (string.length == 0)
            return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    return YES;
}
#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    theTishiLable.text=@"";
    
    return YES;
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
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1078) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            hid=[dic objectForKey:@"hid"];
            //上传第二个协议
            [self againCommitAction];
            
        }else {
            
            [self performSelector:@selector(errToView) withObject:self afterDelay:1.2];
        }

    }else if (COMMANDINT==COMMAND1058){
        
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
           
            
        }else{
            
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
    
    YH_FriendViewController *fri=[[YH_FriendViewController alloc] init];
    fri.title=@"朋友圈";
    fri.ctrType=@"2";
    [self.navigationController pushViewController:fri animated:YES];
    
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
    }
    
    [self.view.window showHUDWithText:@"请求失败" Type:ShowPhotoNo Enabled:YES];

}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    
    UIImage *theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [_imageArrQian addObject:theImage];
    
    [_theTableView reloadData];
    
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
                
              [_theTableView reloadData];
                
            });
            
        }
        
    });
    
}

-(void)checkPicAction
{
       [self nextAction];
    
}

//提示对话框
-(void)alertCtr1:(NSString *)str message:(NSString *)message cancel:(NSString *)cancelStr sure:(NSString *)sureStr
{
    
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:str message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self nextAction];
        
    }];
    //    把事件添加到控制器
    [alertViewCtr addAction:cancelAction];
    [alertViewCtr addAction:sureAction];
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^{
        
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

-(void)timeAction
{
    
    NSLog(@"_imageArr=%ld",(unsigned long)_imageArr.count);
    
    NSLog(@"_imageArrQian=%@",_imageArrQian);

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

-(void)req:(NSString *)imageStr times:(int)times
{
    
    NSLog(@"_imageArr.count=%luld",(unsigned long)_imageArr.count);
    
    NSLog(@"hid=%@",hid);
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1063\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"hid\":\"%@\",\"photo\":\"%@\",\"no\":\"%d\",\"op\":\"1\",\"type\":\"2\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],hid,imageStr,times];
    
    //post 请求
    
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
    
    
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
        
        
    }else if ([typeStr isEqualToString:@"6"]){
        
        
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
            
            if (imageCount!=_imageArr.count) {
                
                [self performSelector:@selector(suessToView) withObject:self afterDelay:0.5];
                
            }else{
                
                [self performSelector:@selector(suessToView) withObject:self afterDelay:0.5];
            }
   
        }];
        
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:^{ }];
    
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
