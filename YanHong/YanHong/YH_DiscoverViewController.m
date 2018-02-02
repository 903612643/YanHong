//
//  YH_DiscoverViewController.m
//  YanHong
//
//  Created by anbaoxing on 16/2/26.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_DiscoverViewController.h"
#import "YH_DiscoverOperationData.h"
#import "YH_DiscoverOperationCell.h"
#import "YH_FriendViewController.h"
#import "WebViewController.h"
#import "UIWindow+YzdHUD.h"
#import "MyInfoViewController.h"
#import "LoginViewController.h"

@interface YH_DiscoverViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end


@implementation YH_DiscoverViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        //当前时间
        NSDate *date=[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSS";
        NSString *dateString = [formatter stringFromDate:date];
        
        NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1041\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"apptype\":\"2\"}",dateString];
        httpRequest=[HttpRequestCalss sharnInstance];
        httpRequest.delegate=self;
        [httpRequest httpRequest:strJson1];
        
    }

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self buildNavigation];
    [self buildInterface];

    
    
    
}

- (void)buildNavigation {
    
    self.navigationController.navigationBar.translucent = NO; //使导航栏与界面的颜色保持一致
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]]; //去除导航栏的分割线
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:47/255.0 green:53/255.0 blue:61/255.0 alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.title = @"发现";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)buildInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //操作列表
    CGRect tableViewRect = CGRectMake(0, 0, theWidth, theHeight - 113);
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[YH_DiscoverOperationCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    
    [self inputFirstGroupData];
    [self inputTheSecondGroupData];
    [self inputTheThirdGroupData];
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

- (void)inputFirstGroupData {
    NSMutableArray *firstGroup = [[NSMutableArray alloc] init];
    
    YH_DiscoverOperationData *data11 = [[YH_DiscoverOperationData alloc] init];
    data11.iconImage = [UIImage imageNamed:@"discover_friend"];      //图标
    data11.title = @"朋友圈";
    [firstGroup addObject:data11];
    
    YH_DiscoverOperationData *data12 = [[YH_DiscoverOperationData alloc] init];
    data12.iconImage = [UIImage imageNamed:@"discover_share"];      //图标
    data12.title = @"微广场";
    [firstGroup addObject:data12];
    
    [self.dataSource addObject:firstGroup];
}

- (void)inputTheSecondGroupData {
    
    NSMutableArray *theSecondGroup = [[NSMutableArray alloc] init];
    
    YH_DiscoverOperationData *data21 = [[YH_DiscoverOperationData alloc] init];
    data21.iconImage = [UIImage imageNamed:@"discover_scan"];      //图标
    data21.title = @"扫一扫";
    [theSecondGroup addObject:data21];
    
    YH_DiscoverOperationData *data22 = [[YH_DiscoverOperationData alloc] init];
    data22.iconImage = [UIImage imageNamed:@"discover_near"];      //图标
    data22.title = @"附近的人";
    [theSecondGroup addObject:data22];
    
    [self.dataSource addObject:theSecondGroup];
}

- (void)inputTheThirdGroupData {
    
    NSMutableArray *theThirdGroup = [[NSMutableArray alloc] init];
    
    YH_DiscoverOperationData *data31 = [[YH_DiscoverOperationData alloc] init];
    data31.iconImage = [UIImage imageNamed:@"discover_activity"];      //图标
    data31.title = @"活动";
    [theThirdGroup addObject:data31];
    
    YH_DiscoverOperationData *data32 = [[YH_DiscoverOperationData alloc] init];
    data32.iconImage = [UIImage imageNamed:@"my_info"];      //图标
    data32.title = @"消息";
    [theThirdGroup addObject:data32];
    
    [self.dataSource addObject:theThirdGroup];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _dataSource[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //适配
    if (IS_IPHONE_4_OR_LESS) {
        return 38;
    }else if (IS_IPHONE_5) {
        return 40;
    }

    return 50;
}

- (YH_DiscoverOperationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YH_DiscoverOperationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *group = _dataSource[indexPath.section];
    YH_DiscoverOperationData *data = group[indexPath.row];
    cell.data = data;
    return cell;
}
//登陆界面
-(void)logViewAction
{
    LoginViewController *homeLogin=[[LoginViewController alloc] init];
    homeLogin.title=@"登录";
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:homeLogin];
    [self presentViewController:nac animated:YES completion:^{
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *label = cell.subviews[3];
    NSLog(@"cell:%@",label.text);
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        if ([label.text isEqualToString:@"朋友圈"]) {
            
            YH_FriendViewController *fri=[[YH_FriendViewController alloc] init];
            fri.title=@"朋友圈";
            fri.friendUid = nil;
            fri.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:fri animated:YES];
            
        }else if ([label.text isEqualToString:@"活动"])
        {
            WebViewController *hot=[[WebViewController alloc] init];
            hot.title=@"专题活动";
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:hot];
            hot.HouesStr=@"http://www.yanhongw.com/zhuanti/";
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
        else if ([label.text isEqualToString:@"消息"])
        {
            MyInfoViewController *hot=[[MyInfoViewController alloc] init];
            hot.title=@"消息";
            hot.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:hot animated:YES];
        }
        else if ([label.text isEqualToString:@"附近的人"])
        {
            [self.view.window showHUDWithText:@"正在建设..." Type:ShowPhotoYes Enabled:YES];
         
        }
        else if ([label.text isEqualToString:@"扫一扫"])
        {
           [self.view.window showHUDWithText:@"正在建设..." Type:ShowPhotoYes Enabled:YES];
        }
        else if ([label.text isEqualToString:@"微广场"])
        {
            [self.view.window showHUDWithText:@"正在建设..." Type:ShowPhotoYes Enabled:YES];
        }

    }else{
        [self logViewAction];
        
    }
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
    
    
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
}


@end
