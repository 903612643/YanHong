//
//  YH_MyViewController.m
//  YanHong
//
//  Created by anbaoxing on 16/2/26.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_MyViewController.h"
#import "YH_MyOperationData.h"
#import "YH_MyOperationCell.h"
#import "YH_WalletViewController.h"
#import "MyInfoViewController.h"
#import "MiddlemanViewController.h"
#import "HouesBinDingViewController.h"
#import "SetPassWordViewController.h"
#import "SuggestViewController.h"
#import "WebViewController.h"
#import "YH_MyGuestViewController.h"
#import "YH_FriendViewController.h"
#import "YH_OpinionViewController.h"
#import "YH_SetMyPhoneViewController.h"
#import "YH_MyHousePropertyViewController.h"
#import "LoginViewController.h"

#import <ShareSDK/ShareSDK.h>

@interface YH_MyViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YH_MyViewController

//登陆界面
-(void)logViewAction
{
    LoginViewController *homeLogin=[[LoginViewController alloc] init];
    homeLogin.title=@"登录";
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:homeLogin];
    [self presentViewController:nac animated:YES completion:^{
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        NSString *imagStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"headpicture"];
        
        if (imagStr!=nil) {
            
            NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:[[NSUserDefaults standardUserDefaults] objectForKey:@"headpicture"]];
            
            UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
            
            [headButton setImage:_decodedImage forState:UIControlStateNormal];
            
        }else{
            
            [headButton setImage:[UIImage imageNamed:@"my_head"] forState:UIControlStateNormal];
            
            
        }
        if (self.dataSource.count!=4) {
            
             [self inputTheFourthGroupData];
        }
        
        
//        for (UIView *subviews in [theBView subviews]) {
//            
//    
//            if (subviews.tag==106) {
//                [subviews removeFromSuperview];
//            }
//        }

        [self HttpDate];
        
    }else{
        
        dataArray = @[@"-",@"-",@"-",@"-"];
        
        if (dataArray.count > 0) {
            
            for (int i = 0; i < dataArray.count; i++) {
                UIView *view = [self.view viewWithTag:i + 1];
                UILabel *label = view.subviews[1];
                label.text = dataArray[i];
                CGPoint labelCenter = label.center;
                [label sizeToFit];
                CGFloat labelWidth = label.frame.size.width;
                CGFloat labelHeight = label.frame.size.height;
                CGFloat viewWidth = view.frame.size.width;
                if (labelWidth >= viewWidth) {
                    label.frame = CGRectMake(0, 0, viewWidth, labelHeight);
                    label.adjustsFontSizeToFitWidth = YES;
                    label.numberOfLines = 0;
                }
                label.center = labelCenter;
            }
            
        }

        for (UIView *subviews in [theBView subviews]) {
            
            if (subviews.tag==104) {
                [subviews removeFromSuperview];
            }
            if (subviews.tag==105) {
                [subviews removeFromSuperview];
            }
            if (subviews.tag==106) {
                [subviews removeFromSuperview];
            }
        }

        nameLabel.text=@"请登录";
        
        [headButton setImage:[UIImage imageNamed:@"my_head"] forState:UIControlStateNormal];
        
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    for (UIView *subviews in [self.view subviews]) {
        
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
        if (subviews.tag==102) {
            [subviews removeFromSuperview];
        }
    }

}

static int LableButton_Size_H;
static int LableButton_Size_W;
static int LableButton_Size_X;
static int LableButton_Size_Y;
static int LableButton_Font;

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S

        
        LableButton_Size_H=22;
        LableButton_Size_W=60;
        LableButton_Size_X=90;
        LableButton_Size_Y=50;
        LableButton_Font=10;
        
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        
        
        LableButton_Size_H=22;
        LableButton_Size_W=60;
        LableButton_Size_X=100;
        LableButton_Size_Y=55;
        LableButton_Font=10;
        
        
    }else if (IS_IPHONE_6) {  // 6
        
        
        LableButton_Size_H=22;
        LableButton_Size_W=70;
        LableButton_Size_X=120;
        LableButton_Size_Y=55;
        LableButton_Font=12;
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        
        
        LableButton_Size_H=22;
        LableButton_Size_W=70;
        LableButton_Size_X=120;
        LableButton_Size_Y=55;
        LableButton_Font=12;
        
        
    }


    
    isClick=YES;
    
    [self buildNavigation];
    [self buildInterface];
    
 
}
-(void)bangDingAction
{

    for (UIView *subviews in [self.tabBarController.view subviews]) {
        
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
        if (subviews.tag==102) {
            [subviews removeFromSuperview];
        }
    }
    
    isClick = YES;
    
     YH_MyHousePropertyViewController *mid=[[YH_MyHousePropertyViewController alloc] init];
    mid.title=@"我的房产";
     mid.hidesBottomBarWhenPushed=YES;
     [self.navigationController pushViewController:mid animated:YES];

    
}
-(void)addUserActon
{
    for (UIView *subviews in [self.tabBarController.view subviews]) {
        
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
        if (subviews.tag==102) {
            [subviews removeFromSuperview];
        }
    }
    
    isClick = YES;

    
    SuggestViewController *log=[[SuggestViewController alloc] init];
    log.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:log animated:YES];
    
}
-(void)HttpDate
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    // 下载经纪人信息
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1021\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
    
    //postter
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
    //关于
    NSString *strJson2 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1019\",\"uid\":\"%@\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"keyname\":\"c107\",\"apptype\":\"2\"}",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],dateString];
    
    //postter
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url2=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url2 parameters:strJson2 success:^(id responseObject) {
        
    } fail:^{
        
    }];

    
    //判断是否业主
    NSString *strJson3 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1045\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    
    //postter
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url3=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url3 parameters:strJson3 success:^(id responseObject) {
        
    } fail:^{
        
    }];

}

- (void)buildNavigation {
    
    self.navigationController.navigationBar.translucent = NO; //使导航栏与界面的颜色保持一致
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]]; //去除导航栏的分割线
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:47/255.0 green:53/255.0 blue:61/255.0 alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"我的";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonItem)];
    
}

-(void)addHeadAction
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        UIAlertController *alertCtr=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //    按钮事件
        //    UIAlertActionStyleCancel 取消风格只能有一个
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancel");
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
            //选择相册模式
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            //    UIImagePickerControllerSourceTypeSavedPhotosAlbum 保存到相册的
            //    UIImagePickerControllerSourceTypePhotoLibrary 所有相册资源
            imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }];
        //    把事件添加到控制器
        [alertCtr addAction:cancelAction];
        [alertCtr addAction:sureAction];
        [alertCtr addAction:otherAction];
        //    模态视图
        [self presentViewController:alertCtr animated:YES completion:^{
        }];

    }else{
        [self logViewAction];
    }
    
}
- (void)buildInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    theBView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 130)];
    theBView.backgroundColor=[UIColor colorWithRed:47/255.0 green:53/255.0 blue:61/255.0 alpha:1.0];
    
    [self.view addSubview:theBView];
    

    headButton=[[UIButton alloc] init];
    
    if (IS_IPHONE_6P ) {
        
        headButton.frame=CGRectMake(15, 10, 100, 100);
        headButton.layer.cornerRadius=50;

    }else if (IS_IPHONE_6){
        
        headButton.frame=CGRectMake(15, 10, 90, 90);
        headButton.layer.cornerRadius=45;
        
    }
    
    headButton.layer.masksToBounds=YES;
   
    NSString *imagStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"headpicture"];
    
    
    if (imagStr!=nil) {
        
        NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:[[NSUserDefaults standardUserDefaults] objectForKey:@"headpicture"]];
        
        UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
        
        [headButton setImage:_decodedImage forState:UIControlStateNormal];
        
    }else{
        
        [headButton setImage:[UIImage imageNamed:@"my_head"] forState:UIControlStateNormal];
    }

    [headButton addTarget:self action:@selector(addHeadAction) forControlEvents:UIControlEventTouchUpInside];
    [theBView addSubview:headButton];
   

    
    //昵称
    nameLabel = [[UILabel alloc] init];
    
    nameLabel.frame = CGRectMake(120, 10, 200, 20);
    
    NSString *nameStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
    
    if (nameStr!=nil) {
        
        nameLabel.text=nameStr;
    }
    
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:18];
    [theBView addSubview:nameLabel];
    
    //箭头
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    arrowBtn.frame = CGRectMake(theWidth - 33, 50, 15, 30);
    arrowBtn.tintColor = [UIColor whiteColor];
    [arrowBtn setImage:[UIImage imageNamed:@"my_arrow"] forState:UIControlStateNormal];
    [arrowBtn addTarget:self action:@selector(arrowBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [theBView addSubview:arrowBtn];
    
    //红色按钮
    NSArray *titleArray = @[@"我的客户(个)",@"朋友圈(条)",@"微广场(条)",@"我的钱包(元)"];
    
    if ([[NSUserDefaults standardUserDefaults]  objectForKey:@"uid"]!=nil) {
        
        dataArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"myViewarray"]];
        
        if (dataArray==nil) {
            
            dataArray = @[@"0",@"0",@"0",@"0"];
        }

    }else{
        dataArray = @[@"0",@"0",@"0",@"0"];
    }
    
    for (int i = 0; i < titleArray.count; i++) {
        
        //背景框
        UIView *view = [[UIView alloc] init];
        CGFloat viewWidth = theWidth / titleArray.count;
        CGFloat viewHeight = 60;
        view.frame = CGRectMake(viewWidth * i, 130, viewWidth, viewHeight);
        view.backgroundColor = [UIColor colorWithRed:244/255.0 green:47/255.0 blue:55/255.0 alpha:1.0];
        view.tag = i + 1;
        [self.view addSubview:view];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.text = titleArray[i];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(viewWidth / 2, viewHeight / 3);
        [view addSubview:titleLabel];
        
        //数据
        dataLabel = [[UILabel alloc] init];
        dataLabel.textColor = [UIColor whiteColor];
        dataLabel.font = [UIFont boldSystemFontOfSize:18];
        dataLabel.textAlignment=NSTextAlignmentCenter;
        dataLabel.text = dataArray[i];
        [dataLabel sizeToFit];
        dataLabel.center = CGPointMake(viewWidth / 2, viewHeight * 2 / 3);
        [view addSubview:dataLabel];
        
        UILabel *lineLabel;
        if (i != 0) {
            //分割线
            lineLabel = [[UILabel alloc] init];
            lineLabel.frame = CGRectMake(viewWidth * i, 130, 0.5, viewHeight);
            lineLabel.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:lineLabel];
        }
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        [tapGesture addTarget:self action:@selector(viewSelect:)];
        
        [view addGestureRecognizer:tapGesture];
        
        //适配
        if (IS_IPHONE_4_OR_LESS) {
            viewWidth = theWidth / 4;
            viewHeight = 40;
            view.frame = CGRectMake(viewWidth * i, 100, viewWidth, viewHeight);
            
            titleLabel.font = [UIFont systemFontOfSize:11];
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(viewWidth / 2, viewHeight / 3);
            
            dataLabel.font = [UIFont boldSystemFontOfSize:14];
            [dataLabel sizeToFit];
            dataLabel.center = CGPointMake(viewWidth / 2, viewHeight * 2 / 3);
            
            lineLabel.frame = CGRectMake(viewWidth * i, 100, 0.5, viewHeight);
        }else if (IS_IPHONE_5) {
            viewWidth = theWidth / 4;
            viewHeight = 50;
            view.frame = CGRectMake(viewWidth * i, 110, viewWidth, viewHeight);
            
            titleLabel.font = [UIFont systemFontOfSize:11];
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(viewWidth / 2, viewHeight / 3);
            
            dataLabel.font = [UIFont boldSystemFontOfSize:15];
            [dataLabel sizeToFit];
            dataLabel.center = CGPointMake(viewWidth / 2, viewHeight * 2 / 3);
            
            lineLabel.frame = CGRectMake(viewWidth * i, 110, 0.5, viewHeight);
        }
    }
    
    //操作列表
    CGRect tableViewRect = CGRectMake(0, 190, theWidth, theHeight - 303);
    _tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[YH_MyOperationCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    
    [self inputFirstGroupData];
    [self inputTheSecondGroupData];
    [self inputTheThirdGroupData];
    [self inputTheFourthGroupData];

    
    NSLog(@"self.data=%@",self.dataSource);
    
    //适配
    if (IS_IPHONE_4_OR_LESS) {
        
        headButton.frame = CGRectMake(10, 10, 70, 70);
        headButton.layer.cornerRadius = 35;
        
        nameLabel.frame = CGRectMake(90, 10, 200, 15);
        nameLabel.font = [UIFont boldSystemFontOfSize:14];
        
        signatureLabel.frame = CGRectMake(90, 30, 200, 10);
        signatureLabel.font = [UIFont systemFontOfSize:11];
        
        arrowBtn.frame = CGRectMake(theWidth - 32, 33, 12, 24);
        
        _tableView.frame = CGRectMake(0, 140, theWidth, theHeight -  253);
    }else if (IS_IPHONE_5) {
        
        headButton.frame = CGRectMake(10, 10, 80, 80);
        headButton.layer.cornerRadius = 40;
        
        nameLabel.frame = CGRectMake(100, 10, 200, 20);
        nameLabel.font = [UIFont boldSystemFontOfSize:16];
        
        signatureLabel.frame = CGRectMake(100, 35, 200, 10);
        signatureLabel.font = [UIFont systemFontOfSize:11];
        
        arrowBtn.frame = CGRectMake(theWidth - 32, 38, 12, 24);
        
        _tableView.frame = CGRectMake(0, 160, theWidth, theHeight -  273);
    }
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }

    return _dataSource;
}

- (void)inputFirstGroupData {
    
    NSMutableArray *firstGroup = [[NSMutableArray alloc] init];
    
    YH_MyOperationData *data11 = [[YH_MyOperationData alloc] init];
    data11.iconImage = [UIImage imageNamed:@"my_invite"];      //图标
    data11.title = @"邀请好友";
    [firstGroup addObject:data11];
    
    YH_MyOperationData *data12 = [[YH_MyOperationData alloc] init];
    data12.iconImage = [UIImage imageNamed:@"my_info"];      //图标
    data12.title = @"消息";
    [firstGroup addObject:data12];
    
    YH_MyOperationData *data13 = [[YH_MyOperationData alloc] init];
    data13.iconImage = [UIImage imageNamed:@"my_advice"];      //图标
    data13.title = @"意见反馈";
    [firstGroup addObject:data13];
    
    [self.dataSource addObject:firstGroup];
}

- (void)inputTheSecondGroupData {
    
    NSMutableArray *theSecondGroup = [[NSMutableArray alloc] init];
    
    YH_MyOperationData *data21 = [[YH_MyOperationData alloc] init];
    data21.iconImage = [UIImage imageNamed:@"my_owner"];      //图标
    data21.title = @"我的房产";
    [theSecondGroup addObject:data21];
    
    YH_MyOperationData *data22 = [[YH_MyOperationData alloc] init];
    data22.iconImage = [UIImage imageNamed:@"my_data"];      //图标
    data22.title = @"个人信息";
    [theSecondGroup addObject:data22];
    
    YH_MyOperationData *data23 = [[YH_MyOperationData alloc] init];
    data23.iconImage = [UIImage imageNamed:@"my_pwd"];      //图标
    data23.title = @"修改密码";
    [theSecondGroup addObject:data23];
    
    YH_MyOperationData *data24 = [[YH_MyOperationData alloc] init];
    data24.iconImage = [UIImage imageNamed:@"phone_fee1"];      //图标
    data24.title = @"更换手机";
    [theSecondGroup addObject:data24];
    
    [self.dataSource addObject:theSecondGroup];
}

- (void)inputTheThirdGroupData {
    
    NSMutableArray *theThirdGroup = [[NSMutableArray alloc] init];
    
    YH_MyOperationData *data31 = [[YH_MyOperationData alloc] init];
    data31.iconImage = [UIImage imageNamed:@"my_about"];      //图标
    data31.title = @"关于";
    [theThirdGroup addObject:data31];
    
    [self.dataSource addObject:theThirdGroup];
}

- (void)inputTheFourthGroupData {
    
    NSMutableArray *theFourthGroup = [[NSMutableArray alloc] init];
    YH_MyOperationData *data41 = [[YH_MyOperationData alloc] init];
    data41.iconImage = [UIImage imageNamed:@"my_exit"];      //图标
    data41.title = @"退出";
    [theFourthGroup addObject:data41];
    [self.dataSource addObject:theFourthGroup];
    
}

#pragma mark - UITableViewDelegate

//让分割线左对齐
-(void)viewDidLayoutSubviews {
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = _dataSource[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //适配
    if (IS_IPHONE_6P){
        
        return 42;
    }else if (IS_IPHONE_6){
        return 42;
    }
    
    return 36;
    
}

- (YH_MyOperationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YH_MyOperationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray *group = _dataSource[indexPath.section];
    YH_MyOperationData *data = group[indexPath.row];
    cell.data = data;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //判断是否登陆
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        if (indexPath.section == 3) {
            
            NSLog(@"%@",cell.textLabel.text);
            
            [self alertAction];
            
        }else{
            
            UILabel *label = cell.subviews[3];
            NSLog(@"cell:%@",label.text);
            
            if ([label.text isEqualToString:@"消息"]) {
                
                MyInfoViewController *myInfo=[[MyInfoViewController alloc] init];
                myInfo.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:myInfo animated:YES];
                
            }else if ([label.text isEqualToString:@"个人信息"])
            {
                MiddlemanViewController *mid=[[MiddlemanViewController alloc] init];
                mid.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:mid animated:YES];
                
            }else if ([label.text isEqualToString:@"我的房产"])
            {
                YH_MyHousePropertyViewController *mid=[[YH_MyHousePropertyViewController alloc] init];
                mid.title=@"我的房产";
                mid.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:mid animated:YES];
                
            }
            else if ([label.text isEqualToString:@"修改密码"])
            {
                SetPassWordViewController *mid=[[SetPassWordViewController alloc] init];
                mid.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:mid animated:YES];
                
            }else if ([label.text isEqualToString:@"关于"])
            {
                WebViewController *spe=[[WebViewController alloc] init];
                spe.title=@"关于";
                UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:spe];
                spe.HouesStr=theUrl;
                [self presentViewController:navigation animated:YES completion:nil];
            }else if ([label.text isEqualToString:@"邀请好友"])
            {
                [self shareContent];
            }else if ([label.text isEqualToString:@"意见反馈"])
            {
                YH_OpinionViewController *opin=[[YH_OpinionViewController alloc] init];
                opin.title=@"意见反馈";
                opin.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:opin animated:YES];
                
            }else if ([label.text isEqualToString:@"更换手机"])
            {
                YH_SetMyPhoneViewController *opin=[[YH_SetMyPhoneViewController alloc] init];
                opin.title=@"修改绑定手机";
                opin.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:opin animated:YES];
                
            }
            
            
        }

    }else{
        [self logViewAction];
    }
    
}

- (void)rightBarButtonItem {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        if(isClick == NO)
            
        {
            for (UIView *subviews in [self.tabBarController.view subviews]) {
                
                if (subviews.tag==101) {
                    [subviews removeFromSuperview];
                }
                if (subviews.tag==102) {
                    [subviews removeFromSuperview];
                }
            }
            
            isClick = YES;
            
        }else {
            
            //创建popView
            [self thePopView];
            
            isClick = NO;
            
        }
        

    }else{
        
        [self logViewAction];
    }
    
}

- (void)arrowBtnClicked:(UIButton *)btn {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        MiddlemanViewController *mid=[[MiddlemanViewController alloc] init];
        mid.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:mid animated:YES];

    }else{
        [self logViewAction];
    }
    
}

- (void)viewSelect:(UITapGestureRecognizer *)tapGesture {
    UILabel *titleLabel = [tapGesture.view.subviews firstObject];
    NSLog(@"title:%@",titleLabel.text);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        if (tapGesture.view.tag == 4) {
            YH_WalletViewController *walletVC = [[YH_WalletViewController alloc] init];
            walletVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:walletVC animated:YES];
        }else if (tapGesture.view.tag == 1) {
            YH_MyGuestViewController *walletVC = [[YH_MyGuestViewController alloc] init];
            walletVC.title=@"客户管理";
            walletVC.hidesBottomBarWhenPushed=YES;
            
            UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:walletVC];
            
            [self presentViewController:nac animated:YES completion:^{
                
            }];
            
            
        }else if (tapGesture.view.tag == 2) {
            
            YH_FriendViewController *walletVC = [[YH_FriendViewController alloc] init];
            walletVC.title=@"朋友圈";
            walletVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:walletVC animated:YES];
        }

    }else{
        
        [self logViewAction];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
//注销提示
-(void)alertAction{
    
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:nil message:@"是否退出当前账号？" preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.view.window showHUDWithText:@"正在退出..." Type:ShowLoading Enabled:YES];
        
        _theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
        _theView.backgroundColor=[UIColor blackColor];
        _theView.tag=101;
        _theView.alpha=0.2;
        [self.tabBarController.view addSubview:_theView];
        
        //当前时间
        NSDate *date=[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSS";
        NSString *dateString = [formatter stringFromDate:date];
        
        //手机号码正确，请求数据
        NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1013\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"logintype\":\"1\",\"apptype\":\"1\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
        httpRequest=[HttpRequestCalss sharnInstance];
        httpRequest.delegate=self;
        [httpRequest httpRequest:strJson1];
        
    }];
    //    把事件添加到控制器
    [alertViewCtr addAction:cancelAction];
    [alertViewCtr addAction:sureAction];
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"dic=%@",dic);
    
    //uid为nil不对请求包进行操作
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        if (COMMANDINT==COMMAND1014) {
            
            for (UIView *subviews in [self.tabBarController.view subviews]) {
                if (subviews.tag==101) {
                    [subviews removeFromSuperview];
                }
            }
        

            
            if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
                
                [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoYes Enabled:YES];
                
                //注销
                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                
                //发布保存的数据设为空
                [userDef setObject:@"" forKey:@"buildings"];
                [userDef setObject:@"" forKey:@"address"];
                [userDef setObject:@"" forKey:@"shi"];
                [userDef setObject:@"" forKey:@"ting"];
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
                
                //出租保存的数据设为空
                [userDef setObject:@"" forKey:@"thebuildings"];
                [userDef setObject:@"" forKey:@"theaddress"];
                [userDef setObject:@"" forKey:@"theshi"];
                [userDef setObject:@"" forKey:@"theting"];
                [userDef setObject:@"" forKey:@"thewei"];
                [userDef setObject:@"" forKey:@"thearea"];
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
                
                [userDef setObject:nil forKey:@"array"];
                [userDef setObject:nil forKey:@"myFriarray"];
                [userDef setObject:nil forKey:@"myViewarray"];
                [userDef setObject:nil forKey:@"myGuest"];
                
                //删除用户uid
                [userDef removeObjectForKey:@"uid"];
                
                
                [userDef synchronize];
                //
                addLastDataIsYes=YES;
                [self.dataSource removeLastObject];
                
                for (UIView *subviews in [theBView subviews]) {
                    
                    if (subviews.tag==104) {
                        [subviews removeFromSuperview];
                    }
                    if (subviews.tag==105) {
                        [subviews removeFromSuperview];
                    }
                    if (subviews.tag==106) {
                        [subviews removeFromSuperview];
                    }
                }
                
                nameLabel.text=@"请登录";
                
                dataArray = @[@"-",@"-",@"-",@"-"];
                
                if (dataArray.count > 0) {
                    
                    for (int i = 0; i < dataArray.count; i++) {
                        UIView *view = [self.view viewWithTag:i + 1];
                        UILabel *label = view.subviews[1];
                        label.text = dataArray[i];
                        CGPoint labelCenter = label.center;
                        [label sizeToFit];
                        CGFloat labelWidth = label.frame.size.width;
                        CGFloat labelHeight = label.frame.size.height;
                        CGFloat viewWidth = view.frame.size.width;
                        if (labelWidth >= viewWidth) {
                            label.frame = CGRectMake(0, 0, viewWidth, labelHeight);
                            label.adjustsFontSizeToFitWidth = YES;
                            label.numberOfLines = 0;
                        }
                        label.center = labelCenter;
                    }
                }
                
                [headButton setImage:[UIImage imageNamed:@"my_head"] forState:UIControlStateNormal];
                
                
            }else{
                
                [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
                
            }
            
            
        }else if (COMMANDINT==COMMAND1022){
            
            if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]){
                
                nameLabel.text=[dic objectForKey:@"name"];
                
            }
            
        }else if (COMMANDINT==COMMAND1020){
            
            theUrl=[dic objectForKey:@"url"];
            
        }else if(COMMANDINT==COMMAND1046){
            
            if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
                
                
                LableButton1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                LableButton1.frame=CGRectMake(LableButton_Size_X, LableButton_Size_Y,LableButton_Size_W , LableButton_Size_H);
                LableButton1.tag=104;
                [LableButton1 setTitle:@"全民经纪人" forState:UIControlStateNormal];
                LableButton1.titleLabel.font=[UIFont systemFontOfSize:LableButton_Font];
                LableButton1.layer.borderWidth = 1.5;
                LableButton1.layer.borderColor = [UIColor whiteColor].CGColor;
                [LableButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                LableButton2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                LableButton2.frame=CGRectMake(LableButton_Size_X+LableButton_Size_W+5, LableButton_Size_Y,LableButton_Size_W/2 , LableButton_Size_H);
                LableButton2.tag=105;
                [LableButton2 setTitle:@"业主" forState:UIControlStateNormal];
                LableButton2.titleLabel.font=[UIFont systemFontOfSize:LableButton_Font];
                LableButton2.layer.borderWidth = 1.5;
                LableButton2.layer.borderColor = [UIColor clearColor].CGColor;
                [LableButton2 setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                
                [theBView addSubview:LableButton1];
                [theBView addSubview:LableButton2];
                
                //签名
                signatureLabel = [[UILabel alloc] init];
                signatureLabel.frame = CGRectMake(120, 35, 200, 10);
                signatureLabel.textColor = [UIColor whiteColor];
                signatureLabel.tag=106;
                signatureLabel.font = [UIFont systemFontOfSize:12];
                [theBView addSubview:signatureLabel];
                
                
                NSString *signatureStr=[dic objectForKey:@"signature"];
                
                if ([signatureStr isKindOfClass:[NSNull class]]) {
                    
                    signatureLabel.text=@"个性签名";
                    
                }else{
                    
                    signatureLabel.text=[dic objectForKey:@"signature"];
                    
                }
                
                NSString *imagStr=[dic objectForKey:@"headpicture"];
                
                if (![imagStr isEqual:[NSNull null]]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"headpicture"] forKey:@"headpicture"];
                    
                    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:[dic objectForKey:@"headpicture"]];
                    
                    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
                    
                    [headButton setImage:_decodedImage forState:UIControlStateNormal];

                    
                    
                }else{
                    
                    [headButton setImage:[UIImage imageNamed:@"my_head"] forState:UIControlStateNormal];
                    
                }
                
                int k=[[dic objectForKey:@"isowner"] intValue];
                
                if (k==1) {
                    
                    LableButton2.layer.borderColor = [UIColor whiteColor].CGColor;
                    [LableButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                
                dataArray = @[[[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"customercount"]],[[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"circleoffriendscount"]],@"0",[[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"walletbalance"]]];
                
                //添加到本地数据
                NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setObject:encodemenulist forKey:@"myViewarray"];
                
                [defaults synchronize];
                
                
                if (dataArray.count > 0) {
                    
                    for (int i = 0; i < dataArray.count; i++) {
                        UIView *view = [self.view viewWithTag:i + 1];
                        UILabel *label = view.subviews[1];
                        label.text = dataArray[i];
                        CGPoint labelCenter = label.center;
                        [label sizeToFit];
                        CGFloat labelWidth = label.frame.size.width;
                        CGFloat labelHeight = label.frame.size.height;
                        CGFloat viewWidth = view.frame.size.width;
                        if (labelWidth >= viewWidth) {
                            label.frame = CGRectMake(0, 0, viewWidth, labelHeight);
                            label.adjustsFontSizeToFitWidth = YES;
                            label.numberOfLines = 0;
                        }
                        label.center = labelCenter;
                    }
                }
            }else{
                
                [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
            }
            
        }else if(COMMANDINT==COMMAND1100){
            
            //上传成功，重新下载
            if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
                
                //当前时间
                NSDate *date=[NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmssSS";
                NSString *dateString = [formatter stringFromDate:date];
                
                //判断是否业主
                NSString *strJson3 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1045\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
                
                //postter
                httpRequest=[[HttpRequestCalss alloc] init];
                
                NSString *url3=[NSString stringWithFormat:THE_POSTURL];
                
                httpRequest.delegate=self;
                
                [url3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                [httpRequest postJSONWithUrl:url3 parameters:strJson3 success:^(id responseObject) {
                    
                } fail:^{
                    
                }];
                
                
            }else{
                
                [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
            }
            
            
        }else if (dic==nil || dic.count==0){
            
            [self.view.window showHUDWithText:@"系统繁忙，请稍后再试！" Type:ShowPhotoNo Enabled:YES];
        }

    }
    
    
    [_tableView reloadData];
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    [self.view.window showHUDWithText:@"网络已断开连接" Type:ShowPhotoNo Enabled:YES];
    
    for (UIView *subviews in [self.tabBarController.view subviews]) {
        if (subviews.tag==101) {
            [subviews removeFromSuperview];
        }
    }
    
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    
    UIImage *theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //[headButton setImage:theImage forState:UIControlStateNormal];
    
    NSData *_data = UIImageJPEGRepresentation(theImage, 0.000001f);
    
    NSString *_encodedImageStr = [_data base64Encoding];
    
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    // 上传我的头像
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1099\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"headpicture\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],_encodedImageStr];
    
    //postter
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];

    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)shareContent
{
    //判断是否登陆，由登陆状态判断启动页面
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        //1、构造分享内容
        //1.1、要分享的图片（以下分别是网络图片和本地图片的生成方式的示例）
        
        //id<ISSCAttachment> remoteAttachment = [ShareSDKCoreService attachmentWithUrl:@"http://f.hiphotos.bdimg.com/album/w%3D2048/sign=df8f1fe50dd79123e0e09374990c5882/cf1b9d16fdfaaf51e6d1ce528d5494eef01f7a28.jpg"];
        
        id<ISSCAttachment> localAttachment = [ShareSDKCoreService attachmentWithPath:[[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"]];
        
        //1.2、以下参数分别对应：内容、默认内容、图片、标题、链接、描述、分享类型
        id<ISSContent> publishContent = [ShareSDK content:@"下载衍宏网，注册全民经纪人，周推1套，年赚26万"
                                           defaultContent:nil
                                                    image:localAttachment
                                                    title:@"邀请您一起用衍宏网，让人脉变财富"
                                                      url:@"http://fir.im/b3nc"
                                              description:nil
                                                mediaType:SSPublishContentMediaTypeNews];
        
        
        //1.5、分享菜单栏选项排列位置和数组元素index相关(非必要)
        NSArray *shareList = [ShareSDK customShareListWithType:
                              // SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                              // SHARE_TYPE_NUMBER(ShareTypeFacebook),
                              SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                              SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                              // SHARE_TYPE_NUMBER(ShareTypeSMS),
//                              SHARE_TYPE_NUMBER(ShareTypeQQ),
//                              SHARE_TYPE_NUMBER(ShareTypeQQSpace),
                              // SHARE_TYPE_NUMBER(ShareTypeMail),
                              //   SHARE_TYPE_NUMBER(ShareTypeCopy),
                              nil];
        
        //1+、创建弹出菜单容器（iPad应用必要，iPhone应用非必要）
        id<ISSContainer> container = [ShareSDK container];
        [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionUp];
        //2、展现分享菜单
        [ShareSDK showShareActionSheet:container
                             shareList:shareList
                               content:publishContent
                         statusBarTips:NO
                           authOptions:nil
                          shareOptions:nil
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    
                                    NSLog(@"=== response state :%zi ",state);
                                    
                                    //可以根据回调提示用户。
                                    if (state == SSResponseStateSuccess)
                                    {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                        message:nil
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"确定"
                                                                              otherButtonTitles:nil, nil];
                                        [alert show];
                                    }
                                    else if (state == SSResponseStateFail)
                                    {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                        message:[NSString stringWithFormat:@"%@",[error errorDescription]]
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"确定"
                                                                              otherButtonTitles:nil, nil];
                                        [alert show];
                                    }
                                }];
        
    }else{
        
        
    }
    
}

-(void)thePopView
{

    UIButton *_theButton=[[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_theButton addTarget:self action:@selector(rightBarButtonItem) forControlEvents:UIControlEventTouchUpInside];
    _theButton.backgroundColor=[UIColor blackColor];
    _theButton.alpha=0.3;
    _theButton.tag=102;
    [_theButton bringSubviewToFront:self.view];
    
    [self.tabBarController.view addSubview:_theButton];
    
    
    popview=[[UIView alloc] initWithFrame:CGRectMake(theWidth-120-20, 60, 120, 80)];
    popview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    popview.tag=101;
    [popview bringSubviewToFront:_theButton];
    [self.tabBarController.view addSubview:popview];
    
    UIButton *addsaleButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, (80-1)/2)];
    addsaleButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [addsaleButton setTitle:@"  推新用户" forState:UIControlStateNormal];
    addsaleButton.alpha=0.6;
    [addsaleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addsaleButton addTarget:self action:@selector(addUserActon) forControlEvents:UIControlEventTouchUpInside];
    [popview addSubview:addsaleButton];
    
    UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 41, 120, 1)];
    lineview.alpha=0.6;
    lineview.backgroundColor=[UIColor grayColor];
    [popview addSubview:lineview];
    
    UIButton *addrentButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 41, 120, (80-1)/2)];
    addrentButton.titleLabel.font=[UIFont systemFontOfSize:16];
    addrentButton.alpha=0.6;
    [addrentButton setTitle:@"  我的房产" forState:UIControlStateNormal];
    [addrentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addrentButton addTarget:self action:@selector(bangDingAction) forControlEvents:UIControlEventTouchUpInside];
    [popview addSubview:addrentButton];
    
    UIImageView *addimageView1=[[UIImageView alloc] initWithFrame:CGRectMake(5, 40/3, 20, 20)];
    addimageView1.image=[UIImage imageNamed:@"13"];
    [popview addSubview:addimageView1];
    
    UIImageView *addimageView2=[[UIImageView alloc] initWithFrame:CGRectMake(5, 40/4*2+20+10, 20, 20)];
    addimageView2.image=[UIImage imageNamed:@"14"];
    [popview addSubview:addimageView2];
    
    
}


@end
