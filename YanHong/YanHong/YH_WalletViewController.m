//
//  YH_WalletViewController.m
//  YanHong
//
//  Created by anbaoxing on 16/2/27.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_WalletViewController.h"
#import "YH_WalletFunctioinData.h"
#import "YH_WalletFunctionCell.h"
#import "YH_BillViewController.h"
#import "HuaFeiChongZhi.h"
#import "WebViewController.h"
#import "YH_AllBillViewController.h"
#import "UIWindow+YzdHUD.h"
#import "YH_BingDingBankCardViewController.h"
#import "YH_WithDarwCashViewController.h"

@interface YH_WalletViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YH_WalletViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self buildNavigation];
    [self buildInterface];
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];

    //佣金细则
    NSString *strJson2 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1019\",\"uid\":\"%@\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"keyname\":\"c106\",\"apptype\":\"2\"}",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],dateString];
    
    //postter
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url2=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url2 parameters:strJson2 success:^(id responseObject) {
        
    } fail:^{
        
    }];

    //钱包--收入支出金额获取
    NSString *strJson3= [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1085\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    
    
    //postter
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url3=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url3 parameters:strJson3 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
    
    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
  
}
-(void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)buildNavigation {
    
    self.navigationItem.title = @"钱包";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 50, 20);
    [rightBtn setImage:[UIImage imageNamed:@"my_bill"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBBIClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
}

- (void)rightBBIClicked {
    
   // YH_BillViewController *billVC = [[YH_BillViewController alloc] init];
    YH_AllBillViewController *billVC = [[YH_AllBillViewController alloc] init];
    billVC.title=@"账单明细";
    billVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:billVC animated:YES];
}

- (void)buildInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *theBView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 130)];
    theBView.backgroundColor=[UIColor colorWithRed:47/255.0 green:53/255.0 blue:61/255.0 alpha:1.0];
    [self.view addSubview:theBView];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]]; //去除导航栏的分割线
    
    //余额
    accountLabel = [[UILabel alloc] init];
    accountLabel.frame = CGRectMake(0, 20, theWidth, 38);
    accountLabel.textColor = [UIColor whiteColor];
    accountLabel.textAlignment = NSTextAlignmentCenter;
    accountLabel.font = [UIFont boldSystemFontOfSize:36];
    [theBView addSubview:accountLabel];
    
    UILabel *balanceLabel = [[UILabel alloc] init];
    balanceLabel.frame = CGRectMake(0, 70, theWidth, 15);
    balanceLabel.textColor = [UIColor whiteColor];
    balanceLabel.textAlignment = NSTextAlignmentCenter;
    balanceLabel.font = [UIFont boldSystemFontOfSize:18];
    balanceLabel.text = @"余额(元)";
    [theBView addSubview:balanceLabel];
    
    //红色按钮
    NSArray *titleArray = @[@"佣金收入(元)",@"投资金融(元)",@"消费支出(元)"];
    
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"0.00",@"0.00",@"0.00", nil];
    
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
         UILabel  *dataLabel = [[UILabel alloc] init];
        dataLabel.textColor = [UIColor whiteColor];
        dataLabel.font = [UIFont boldSystemFontOfSize:18];
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
        
        //适配
        if (IS_IPHONE_4_OR_LESS) {
            
            viewWidth = theWidth / 3;
            viewHeight = 50;
            view.frame = CGRectMake(viewWidth * i, 100, viewWidth, viewHeight);
            
            titleLabel.font = [UIFont systemFontOfSize:13];
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(viewWidth / 2, viewHeight / 3);
            
            dataLabel.font = [UIFont boldSystemFontOfSize:15];
            [dataLabel sizeToFit];
            dataLabel.center = CGPointMake(viewWidth / 2, viewHeight * 2 / 3);
            
            lineLabel.frame = CGRectMake(viewWidth * i, 100, 0.5, viewHeight);
            
        }else if (IS_IPHONE_5) {
            viewWidth = theWidth / 3;
            viewHeight = 50;
            view.frame = CGRectMake(viewWidth * i, 110, viewWidth, viewHeight);
            
            titleLabel.font = [UIFont systemFontOfSize:13];
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(viewWidth / 2, viewHeight / 3);
            
            dataLabel.font = [UIFont boldSystemFontOfSize:15];
            [dataLabel sizeToFit];
            dataLabel.center = CGPointMake(viewWidth / 2, viewHeight * 2 / 3);
            
            lineLabel.frame = CGRectMake(viewWidth * i, 110, 0.5, viewHeight);
        }
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        [tapGesture addTarget:self action:@selector(viewSelect:)];
        
        [view addGestureRecognizer:tapGesture];
    }
  
    //功能表单
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    CGRect collectionViewRect = CGRectMake(0, 190, theWidth, theHeight);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewRect collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[YH_WalletFunctionCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    
    [self inputData];
    
    //适配
    if (IS_IPHONE_4_OR_LESS) {
        accountLabel.frame = CGRectMake(0, 10, theWidth, 38);
        accountLabel.font = [UIFont systemFontOfSize:28];
        
        balanceLabel.frame = CGRectMake(0, 50, theWidth, 15);
        balanceLabel.font = [UIFont systemFontOfSize:16];
        
        collectionView.frame = CGRectMake(0, 150, theWidth, theHeight );
    }else if (IS_IPHONE_5) {
        accountLabel.frame = CGRectMake(0, 10, theWidth, 38);
        accountLabel.font = [UIFont systemFontOfSize:28];
        
        balanceLabel.frame = CGRectMake(0, 50, theWidth, 15);
        balanceLabel.font = [UIFont systemFontOfSize:16];
        
        collectionView.frame = CGRectMake(0, 160, theWidth, theHeight );
    }
    UIButton *withdarwCashButton=[[UIButton alloc] initWithFrame:CGRectMake(0, theHeight-120, theWidth, 60)];
    withdarwCashButton.titleLabel.font=[UIFont systemFontOfSize:25];
    withdarwCashButton.backgroundColor=[UIColor colorWithRed:47/255.0 green:53/255.0 blue:61/255.0 alpha:1.0];
    [withdarwCashButton addTarget:self action:@selector(withdarwCashAction) forControlEvents:UIControlEventTouchUpInside];
    [withdarwCashButton bringSubviewToFront:self.view];
    [withdarwCashButton setTitle:@"申请提现" forState:UIControlStateNormal];
    [self.view addSubview:withdarwCashButton];
    
}
-(void)withdarwCashAction
{
    YH_WithDarwCashViewController *withctr=[[YH_WithDarwCashViewController alloc] init];
    withctr.title=@"提现";
    withctr.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:withctr animated:YES];
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

- (void)inputData {
    
    YH_WalletFunctioinData *data1 = [[YH_WalletFunctioinData alloc] init];
    data1.iconImage = [UIImage imageNamed:@"pic4"];
    data1.title = @"众贷金融";
   // [self.dataSource addObject:data1];
    
    YH_WalletFunctioinData *data2 = [[YH_WalletFunctioinData alloc] init];
    data2.iconImage = [UIImage imageNamed:@"phone_fee1"];
    data2.title = @"手机充值";
    [self.dataSource addObject:data2];
    
    YH_WalletFunctioinData *data3 = [[YH_WalletFunctioinData alloc] init];
    data3.iconImage = [UIImage imageNamed:@"property_fee1"];
    data3.title = @"物业缴费";
   // [self.dataSource addObject:data3];
    
    YH_WalletFunctioinData *data4 = [[YH_WalletFunctioinData alloc] init];
    data4.iconImage = [UIImage imageNamed:@"wallet_card"];
    data4.title = @"银行卡";
    [self.dataSource addObject:data4];
    
    YH_WalletFunctioinData *data5 = [[YH_WalletFunctioinData alloc] init];
    data5.iconImage = [UIImage imageNamed:@"wallet_rules"];
    data5.title = @"佣金细则";
    [self.dataSource addObject:data5];
    
    YH_WalletFunctioinData *data6 = [[YH_WalletFunctioinData alloc] init];
    //data6.iconImage = [UIImage imageNamed:@"wallet_add"];
    data6.title = nil;
    [self.dataSource addObject:data6];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake(theWidth, 10);
    return headerSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize footerSize = CGSizeMake(theWidth, 10);
    return footerSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeMake(theWidth / 3 - 1, theWidth / 3 - 1);
    return itemSize;
}

- (YH_WalletFunctionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YH_WalletFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    YH_WalletFunctioinData *data = _dataSource[indexPath.row];
    cell.data = data;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YH_WalletFunctionCell *cell = (YH_WalletFunctionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UILabel *label = cell.subviews[2];
    
    NSLog(@"%@",label.text);
    
    if ([label.text isEqualToString:@"手机充值"]) {
        
        HuaFeiChongZhi *pay=[[HuaFeiChongZhi alloc] init];
        pay.hidesBottomBarWhenPushed=YES;
        pay.title=@"充值";
        [self.navigationController pushViewController:pay animated:YES];
    }else if ([label.text isEqualToString:@"佣金细则"]){
        
        WebViewController *spe=[[WebViewController alloc] init];
        spe.title=@"佣金细则";
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:spe];
        spe.HouesStr=theUrl;
        [self presentViewController:navigation animated:YES completion:nil];
        
    }else if ([label.text isEqualToString:@"银行卡"]){
        
        YH_BingDingBankCardViewController *pay=[[YH_BingDingBankCardViewController alloc] init];
        pay.hidesBottomBarWhenPushed=YES;
        pay.title=@"绑定银行卡";
        [self.navigationController pushViewController:pay animated:YES];
    }
    
}

- (void)viewSelect:(UITapGestureRecognizer *)tapGesture {
    UILabel *titleLabel = [tapGesture.view.subviews firstObject];
    NSLog(@"title:%@",titleLabel.text);
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
    
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1020){
        
        theUrl=[dic objectForKey:@"url"];
        
    }else if (COMMANDINT==COMMAND1086){
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            accountLabel.text =[dic objectForKey:@"balance"];
            
            
            [dataArray removeAllObjects];
            
            NSLog(@"fadsf%@",[dic objectForKey:@"income"]);
            
            [dataArray addObject:[dic objectForKey:@"income"]];
            
            [dataArray addObject:[dic objectForKey:@"investment"]];
            
            [dataArray addObject:[dic objectForKey:@"expenditure"]];
            
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
        
    }
    
}



//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    // NSLog(@"error = %@",error);
    
    //[self.view.window showHUDWithText:@"网络异常" Type:ShowPhotoNo Enabled:YES];

    accountLabel.text=@"-";
    
    [dataArray removeAllObjects];
    
    
    [dataArray addObject:@"-"];
    
    [dataArray addObject:@"-"];
    
    [dataArray addObject:@"-"];
    
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
    

    
}

@end
