//
//  VisitViewController.m
//  YanHong
//
//  Created by anbaoxing on 16/3/25.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "VisitViewController.h"
#import "UIWindow+YzdHUD.h"
#import "LinkViewController.h"
#import "YH_MyGuestViewController.h"


@interface VisitViewController () <UITextFieldDelegate>

@property (nonatomic, assign) BOOL agree;

@property (nonatomic, strong) UIView *extentView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation VisitViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"notificationname" object:nil];
    
    [self setUpView];
}
- (void)tongzhi:(NSNotification *)text{
    
   // NSLog(@"%@",text.userInfo[@"guestname"]);

    UIView *view = [_scrollView viewWithTag:50];
    UITextField *textField = view.subviews[1];
    
    textField.text=text.userInfo[@"guestname"];
    
}
- (void)setUpView {
    self.navigationItem.title = @"预约看房";
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的预约" style:UIBarButtonItemStylePlain target:self action:@selector(rightBBIClicked)];
    
    //滑动背景
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, theWidth, theHeight - 64);
    _scrollView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    [self.view addSubview:_scrollView];
    
    //城市栏
    UIView *townView = [[UIView alloc] init];
    townView.frame = CGRectMake(0, 0, theWidth, 50);
    townView.backgroundColor = [UIColor colorWithRed:235/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    [_scrollView addSubview:townView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(extentViewAction)];
    [townView addGestureRecognizer:tapGesture];
    
    UILabel *townLabel = [[UILabel alloc] init];
    townLabel.text = _projectName;
    [townLabel sizeToFit];
    CGFloat townWidth = townLabel.frame.size.width;
    townLabel.frame = CGRectMake(20, 15, townWidth, 20);
    [townView addSubview:townLabel];
    townLabel.tag = 31;
    
    townImageView = [[UIImageView alloc] init];
    townImageView.frame = CGRectMake(theWidth - 40, 15, 20, 20);
    townImageView.image = [UIImage imageNamed:@"see_top"];
    [townView addSubview:townImageView];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(10, 40, theWidth - 20, 1);
    lineLabel.backgroundColor = [UIColor redColor];
    [townView addSubview:lineLabel];
    
    //优惠描述框
    UIView *privilegeView = [[UIView alloc] init];
    privilegeView.frame = CGRectMake(0, 50, theWidth, 100);
    privilegeView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:privilegeView];
    
    NSArray *imageArray = @[[UIImage imageNamed:@"disb"],
                            [UIImage imageNamed:@"advisor"],
                            [UIImage imageNamed:@"borrow"]];
    NSArray *detailArray = @[@"房价折扣: 享9.8折, 需提前一天备报",
                             @"专属顾问服务: 房源推荐, 购房咨询, 现场带看",
                             @"低息金融贷款: 1~100万，月利率低至0.5%"];
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = CGRectMake(10, 10 + 30 * i, 20, 20);
        iconView.image = imageArray[i];
        [privilegeView addSubview:iconView];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.frame = CGRectMake(40, 10 + 30 * i, theWidth - 40, 20);
        detailLabel.text = detailArray[i];
        [privilegeView addSubview:detailLabel];
        
        if (IS_IPHONE_6) {
            detailLabel.font = [UIFont systemFontOfSize:15];
        }else if (IS_IPHONE_5) {
            detailLabel.frame = CGRectMake(35, 10 + 30 * i, theWidth - 40, 20);
            detailLabel.font = [UIFont systemFontOfSize:14];
        }else if (IS_IPHONE_4_OR_LESS) {
            detailLabel.frame = CGRectMake(35, 10 + 30 * i, theWidth - 40, 20);
            detailLabel.font = [UIFont systemFontOfSize:14];
        }
    }
    
    //报名信息
    NSArray *promptArray = @[@"姓        名",@"手  机  号",@"预约时间",@"购房需求",@"备        注"];
    NSArray *placehoulderArray = @[@"请选择姓名",@"请输入手机号码",@"请选择预约时间",@"请选择购房需求",@"请输入备注信息"];
    for (int j = 0; j < promptArray.count; j++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 170 + 51 * j, theWidth, 50);
        view.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:view];
        view.tag = 50 + j;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = promptArray[j];
        [label sizeToFit];
        CGFloat labelWidth = label.frame.size.width;
        label.frame = CGRectMake(10, 0, labelWidth, 50);
        [view addSubview:label];
        
        CGFloat textFieldOriginX = labelWidth + 20;
        
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(textFieldOriginX, 0, theWidth / 2 - 10, 50);
        textField.placeholder = placehoulderArray[j];
        
        if (j == 0) {
            
    
            NSString *nameStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
            
            if (nameStr!=nil) {
                
                textField.text = nameStr;
            }

            
            
        }else if (j == 1){
            
            textField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
        }
        
        if (j != 1 && j != 4) {
            [textField setEnabled:NO];
        }
        textField.delegate = self;
        [view addSubview:textField];
        
        if (j == 0 || j == 2 || j == 3) {
            //向右箭头
            CGFloat directionHeight = 14;
            CGFloat directionWidth = directionHeight * 26 / 50;
            CGFloat directionOriginX = theWidth - directionWidth - 10;
            CGFloat directionOriginY = (view.frame.size.height - directionHeight) / 2;
            UIImageView *directionView = [[UIImageView alloc] init];
            directionView.frame = CGRectMake(directionOriginX, directionOriginY, directionWidth, directionHeight);
            directionView.image = [UIImage imageNamed:@"4"];
            [view addSubview:directionView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
            [tapGesture addTarget:self action:@selector(tapTarget:)];
            [view addGestureRecognizer:tapGesture];
        }
        
        if (IS_IPHONE_4_OR_LESS) {
            
            view.frame = CGRectMake(0, 170 + 41 * j, theWidth, 40);
            
            label.font = [UIFont systemFontOfSize:15];
            [label sizeToFit];
            CGFloat labelWidth = label.frame.size.width;
            label.frame = CGRectMake(10, 0, labelWidth, 40);
            
            CGFloat textFieldOriginX = labelWidth + 20;
            textField.frame = CGRectMake(textFieldOriginX, 0, theWidth / 2 - 10, 40);
            textField.font = [UIFont systemFontOfSize:15];
        }
    }
    
    //协议
    _agree = YES;
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(10, 435, 20, 20);
    [agreeBtn setImage:[UIImage imageNamed:@"disagree"] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeProtocol:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:agreeBtn];
    
    UILabel *agreeLabel = [[UILabel alloc] init];
    agreeLabel.text = @"我同意";
    [agreeLabel sizeToFit];
    CGFloat agreeWidth = agreeLabel.frame.size.width;
    agreeLabel.frame = CGRectMake(40, 435, agreeWidth, 20);
    [_scrollView addSubview:agreeLabel];
    
    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    protocolBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [protocolBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [protocolBtn setTitle:@"《衍宏地产新房委托协议》" forState:UIControlStateNormal];
    [protocolBtn sizeToFit];
    CGFloat proBtnWidth = protocolBtn.frame.size.width;
    CGFloat proBtnOriginX = agreeLabel.frame.origin.x + agreeWidth;
    protocolBtn.frame = CGRectMake(proBtnOriginX, 435, proBtnWidth, 20);
    [protocolBtn addTarget:self action:@selector(protocolClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:protocolBtn];
    
    //报名按钮
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    applyBtn.layer.cornerRadius = 5;
    [applyBtn setBackgroundColor:[UIColor redColor]];
    applyBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyBtn setTitle:@"立即报名" forState:UIControlStateNormal];
    [applyBtn sizeToFit];
    applyBtn.frame = CGRectMake(10, 465, theWidth - 20, 38);
    [applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:applyBtn];
    
    //城市伸展栏
    _extentView = [[UIView alloc] init];
    _extentView.frame = CGRectMake(0, 50, theWidth, 0);
    _extentView.backgroundColor = [UIColor lightGrayColor];
    _extentView.clipsToBounds = YES;
    [_scrollView addSubview:_extentView];
    
    int count = 0;
    for (int x = 0; x < _projectDatas.count; x++) {
        NSDictionary *dict = _projectDatas[x];
        
        if (![dict[@"projectName"] isEqualToString:_projectName]) {
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 51 * count, theWidth - 20, 50);
            label.text = [NSString stringWithFormat:@"    %@",dict[@"projectName"]];
            label.userInteractionEnabled = YES;
            [_extentView addSubview:label];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
            [tapGesture addTarget:self action:@selector(selectTown:)];
            [label addGestureRecognizer:tapGesture];
            
            count++;
            
            UILabel *lineLabel = [[UILabel alloc]init];
            lineLabel.frame = CGRectMake(0, 50 * count, theWidth, 1);
            lineLabel.backgroundColor = [UIColor whiteColor];
            [_extentView addSubview:lineLabel];
        }
    }
    
    if (IS_IPHONE_5) {
        agreeLabel.font = [UIFont systemFontOfSize:16];
        [agreeLabel sizeToFit];
        CGFloat agreeWidth = agreeLabel.frame.size.width;
        agreeLabel.frame = CGRectMake(40, 435, agreeWidth, 20);
        
        protocolBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [protocolBtn sizeToFit];
        CGFloat proBtnWidth = protocolBtn.frame.size.width;
        CGFloat proBtnOriginX = agreeLabel.frame.origin.x + agreeWidth;
        protocolBtn.frame = CGRectMake(proBtnOriginX, 435, proBtnWidth, 20);
    }else if (IS_IPHONE_4_OR_LESS) {
        agreeBtn.frame = CGRectMake(10, 384, 20, 20);
        
        agreeLabel.font = [UIFont systemFontOfSize:16];
        [agreeLabel sizeToFit];
        CGFloat agreeWidth = agreeLabel.frame.size.width;
        agreeLabel.frame = CGRectMake(40, 384, agreeWidth, 20);
        
        protocolBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [protocolBtn sizeToFit];
        CGFloat proBtnWidth = protocolBtn.frame.size.width;
        CGFloat proBtnOriginX = agreeLabel.frame.origin.x + agreeWidth;
        protocolBtn.frame = CGRectMake(proBtnOriginX, 384, proBtnWidth, 20);
        
        applyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [applyBtn sizeToFit];
        applyBtn.frame = CGRectMake(10, 414, theWidth - 20, 35);
        [applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    CGFloat totalHeight = applyBtn.frame.origin.y + applyBtn.frame.size.height;
    if (totalHeight > (theHeight - 84)) {
        _scrollView.contentSize = CGSizeMake(theWidth, totalHeight + 20);
    }
}

-(void)popAction{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}

- (void)rightBBIClicked {
    
    NSLog(@"我的预约");
    
}

- (void)extentViewAction {
    
    if (_extentView.frame.size.height > 0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            _extentView.frame = CGRectMake(0, 50, theWidth, 0);
        }];
        townImageView.image = [UIImage imageNamed:@"see_top"];
    }else {
        
        [UIView animateWithDuration:0.25 animations:^{
            _extentView.frame = CGRectMake(0, 50, theWidth, 51 * (_projectDatas.count - 1) - 2);
        }];
        
        townImageView.image = [UIImage imageNamed:@"see_top3"];
        
    }
}

- (void)selectTown:(UITapGestureRecognizer *)tapGesture {
    
    NSLog(@"%@",_projectID);
    UILabel *label1 = (UILabel *)tapGesture.view;
    UILabel *label2 = [_scrollView viewWithTag:31];
    label2.text = label1.text;
    [label2 sizeToFit];
    _projectName = label1.text;
    NSLog(@"%@",_projectName);
    
    [_extentView removeFromSuperview];
    _extentView = nil;
    
    _extentView = [[UIView alloc] init];
    _extentView.frame = CGRectMake(0, 50, theWidth, 51 * (_projectDatas.count - 1) - 2);
    _extentView.backgroundColor = [UIColor lightGrayColor];
    _extentView.clipsToBounds = YES;
    [_scrollView addSubview:_extentView];
    
    int count = 0;
    for (int x = 0; x < _projectDatas.count; x++) {
        NSDictionary *dict = _projectDatas[x];
        
        NSString *townName = [NSString stringWithFormat:@"    %@",dict[@"projectName"]];
                              
        if (![townName isEqualToString:_projectName]) {
            
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 51 * count, theWidth - 20, 50);
            label.text = [NSString stringWithFormat:@"    %@",dict[@"projectName"]];
            label.userInteractionEnabled = YES;
            [_extentView addSubview:label];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
            [tapGesture addTarget:self action:@selector(selectTown:)];
            [label addGestureRecognizer:tapGesture];
            
            count++;
            
            UILabel *lineLabel = [[UILabel alloc]init];
            lineLabel.frame = CGRectMake(0, 50 * count, theWidth, 1);
            lineLabel.backgroundColor = [UIColor whiteColor];
            [_extentView addSubview:lineLabel];
        }else{
            _projectID = dict[@"projectId"];
        }
    }
    NSLog(@"%@",_projectID);
    [self extentViewAction];
}

- (void)tapTarget:(UITapGestureRecognizer *)tapGesture {
    
    if (tapGesture.view.tag == 50) {
        
        YH_MyGuestViewController *guest=[[YH_MyGuestViewController alloc] init];
        guest.ctrType=@"1";
        UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:guest];
        
        guest.title=@"客户管理";
        
        [self presentViewController:nac animated:YES completion:^{
            
        }];

    }else if (tapGesture.view.tag == 52) {
        
        [self alertCtr];
        
    }else if (tapGesture.view.tag == 53) {
        
        [self alertCtr1];
        
    }
}

-(void)alertCtr {
    
    UIView *view = [_scrollView viewWithTag:52];
    UITextField *textField = view.subviews[1];
    
    // 这是一个时间选择器
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.frame = CGRectMake(((theWidth)-280)/2, 10, 280, 160);
    
    datePicker.date = [[NSDate date] dateByAddingTimeInterval:3600 * 24];
    datePicker.minimumDate = [[NSDate date] dateByAddingTimeInterval:3600 * 24];
    datePicker.datePickerMode =  UIDatePickerModeDate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:datePicker];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //picker当前时间
        NSDate *selectedDate = datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateString = [formatter stringFromDate:selectedDate];
        textField.text = dateString;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{ }];
}

-(void)alertCtr1
{
    UIView *view = [_scrollView viewWithTag:53];
    UITextField *textField = view.subviews[1];
    
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *sureAction1 = [UIAlertAction actionWithTitle:@"刚需" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        textField.text = @"刚需";
        
    }];
    
    UIAlertAction *sureAction2 = [UIAlertAction actionWithTitle:@"改善" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        textField.text = @"改善";
        
    }];
    UIAlertAction *sureAction3= [UIAlertAction actionWithTitle:@"养生" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        textField.text = @"养生";
        
        
    }];
    UIAlertAction *sureAction4 = [UIAlertAction actionWithTitle:@"投资" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        textField.text = @"投资";
    }];
    UIAlertAction *sureAction5 = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        textField.text = @"其他";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //    把事件添加到控制器
    [alertViewCtr addAction:cancelAction];
    [alertViewCtr addAction:sureAction1];
    [alertViewCtr addAction:sureAction2];
    [alertViewCtr addAction:sureAction3];
    [alertViewCtr addAction:sureAction4];
    [alertViewCtr addAction:sureAction5];
    
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:nil];
    
}

- (void)gainSecurityCode {
    //获取手机输入框
    UIView *view = [_scrollView viewWithTag:51];
    UITextField *textField = view.subviews[1];
    
    if (textField.text.length != 0) {
        //当前时间
        NSDate *date=[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSS";
        NSString *dateString = [formatter stringFromDate:date];
        
        //进入下载我的客户信息
        NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1003\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"username\":\"%@\",\"logintype\":\"1\",\"apptype\":\"2\",\"language\":\"1\"}",dateString,textField.text];
        
        //post 请求
        
        httpRequest=[[HttpRequestCalss alloc] init];
        
        NSString *url1=[NSString stringWithFormat:THE_POSTURL];
        
        httpRequest.delegate=self;
        
        [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
            
        } fail:^{
            
        }];
    }else{
        [self alertViewWithMessage:@"手机号码不能为空"];
    }
}

- (void)agreeProtocol:(UIButton *)btn {
    
    NSLog(@"%d",_agree);
    if (_agree) {
        _agree = NO;
        [btn setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
    }else{
        _agree = YES;
        [btn setImage:[UIImage imageNamed:@"disagree"] forState:UIControlStateNormal];
    }
    
}

- (void)applyAction {
    if (_agree) {
        //获取姓名
        UIView *nameView = [_scrollView viewWithTag:50];
        UITextField *nameTextField = nameView.subviews[1];
        
        if (nameTextField.text.length !=0) {
            //获取手机输入框
            UIView *mobileView = [_scrollView viewWithTag:51];
            UITextField *mobileTextField = mobileView.subviews[1];
            
            if (mobileTextField.text.length != 0) {
                //获取验证码
                UIView *dateView = [_scrollView viewWithTag:52];
                UITextField *dateTextField = dateView.subviews[1];
                

                    //获取备注信息
                    UIView *remarkView = [_scrollView viewWithTag:54];
                    UITextField *remarkTextField = remarkView.subviews[1];
                    
                    //获取购房需求
                    UIView *demandView = [_scrollView viewWithTag:53];
                    UITextField *demandTextField = demandView.subviews[1];
                    
                    if (demandTextField.text.length != 0) {
                        //当前时间
                        NSDate *date=[NSDate date];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmssSS";
                        NSString *dateString = [formatter stringFromDate:date];
                        
                        //进入下载我的客户信息
                        NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1015\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"name\":\"%@\",\"mobile\":\"%@\",\"projectid\":\"%@\",\"validcode\":\"123\",\"ordertime\":\"%@\",\"remark\":\"%@\",\"demand\":\"%@\",\"apptype\":\"2\",\"language\":\"1\"}",dateString,nameTextField.text,mobileTextField.text,_projectID,dateTextField.text,remarkTextField.text,demandTextField.text];
                        
                        NSLog(@"%@",strJson1);
                        //post 请求
                        
                        httpRequest=[[HttpRequestCalss alloc] init];
                        
                        NSString *url1=[NSString stringWithFormat:THE_POSTURL];
                        
                        httpRequest.delegate=self;
                        
                        [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        
                        [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
                            
                        } fail:^{
                            
                        }];
                        
                    }else{
                        [self alertViewWithMessage:@"购房需求不能为空"];
                    }
                
            }else{
                [self alertViewWithMessage:@"手机号码不能为空"];
            }
        }else {
            [self alertViewWithMessage:@"请选择姓名"];
        }
    }else{
        [self alertViewWithMessage:@"请同意委托协议"];
    }
}

#pragma mark UITextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

#pragma mark HttpRequestClassDelegate

-(void)dissActon
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic = [[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"%@",dic);
    
     if (COMMANDINT==COMMAND1020){

        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {

            NSURL *Url =[NSURL URLWithString:[dic objectForKey:@"url"]];

            request = [[NSURLRequest alloc] initWithURL:Url];
            
            [webView loadRequest:request];
            
        }else{
            
            for (UIView *subviews in [self.view subviews]) {
                if (subviews.tag==101) {
                    [subviews removeFromSuperview];
                }
            }
           
        }
     
     }else if (COMMANDINT==COMMAND1016){
         
         if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
             
             [self alertViewWithMessage:[dic objectForKey:@"errmsg"]];
             
         }else{
             
             
             [self alertViewWithMessage:[dic objectForKey:@"errmsg"]];
         }

         
     }else{
         
         [self alertViewWithMessage:[dic objectForKey:@"errmsg"]];
         
     }
    
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    [self alertViewWithMessage:error.localizedDescription];
    
}

-(void)alertViewWithMessage:(NSString *)msg{
    //初始化UIAlertController
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    //定义一个UIAlertAction
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    //添加到UIAlertController
    [alertC addAction:action];
    //实现跳转
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)protocolClicked:(UIButton *)btn {
    
//    LinkViewController *linkVC = [[LinkViewController alloc] init];
//    linkVC.navigationItem.title = @"热门楼盘";
//    linkVC.projectID = _projectID;
//    linkVC.keyName = @"c104";
//    UINavigationController *linkNac = [[UINavigationController alloc] initWithRootViewController:linkVC];
//    [self presentViewController:linkNac animated:YES completion:nil];
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //佣金细则
    NSString *strJson2 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1019\",\"uid\":\"%@\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"keyname\":\"c105\",\"apptype\":\"2\"}",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],dateString];
    
    //postter
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url2=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url2 parameters:strJson2 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
    self.title=@"衍宏地产新房委托协议";
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight+300)];
    view.backgroundColor=[UIColor blackColor];
    view.alpha=0.5;
    view.tag=100;
    [view bringSubviewToFront:self.view];
    [self.view addSubview:view];
    
    webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(20, 0, theWidth-40, theHeight-100);
    webView.delegate = self;
    webView.tag=101;
    [webView bringSubviewToFront:view];
    webView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:webView];
    
    UIButton *sureButton=[[UIButton alloc] initWithFrame:CGRectMake(0, theHeight-100-44, theWidth-40, 44)];
    sureButton.backgroundColor=[UIColor colorWithRed:35/255.0 green:40/255.0 blue:47/255.0 alpha:1];
    sureButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [sureButton addTarget:self action:@selector(sureProAction) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [webView addSubview:sureButton];
    

    
}

-(void)sureProAction
{
    self.title=@"预约看房";
    
    for (UIView *subView in [self.view subviews]) {
        
        if (subView.tag==101 ) {
            
            [subView removeFromSuperview];
        }
        if (subView.tag==100) {
            
            [subView removeFromSuperview];
            
        }
        
    }
    
}

@end
