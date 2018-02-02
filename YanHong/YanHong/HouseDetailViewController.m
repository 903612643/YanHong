//
//  HouseDetailViewController.m
//  YanHong
//
//  Created by anbaoxing on 16/3/23.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "HouseDetailViewController.h"
#import "UIWindow+YzdHUD.h"
#import "HouseDetailViewCell.h"
#import "LinkViewController.h"
#import "SuggestViewController.h"
#import "VisitViewController.h"
#import "DownloadOperation.h"
#import <ShareSDK/ShareSDK.h>
#import "LoginViewController.h"

#define CellReuseID @"cell"
#define PhoneNum @"4009977971"

@interface HouseDetailViewController () <UITableViewDataSource,UITableViewDelegate,DownloadOperationDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation HouseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_queue_create("YH", nil);
    //创建异步线程
    dispatch_async(queue, ^{
        
        [self httpData];
        
        //回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self setUpView];
            
        });
    });
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

//线程方法
-(void)httpData
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //进入下载我的客户信息
    
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1095\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"apptype\":\"2\",\"projectid\":\"%@\"}",dateString,_projectID];
    
    //post 请求
    
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
    
}

- (void)setUpView {
    
    self.view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    //黑色顶框
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.frame = CGRectMake(0, 0, theWidth, 20);
    topLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:topLabel];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(14, 24, 36, 36);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //分享按钮
//    UIButton *fenxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    fenxBtn.frame = CGRectMake(theWidth-45, 28, 25, 25);
//    [fenxBtn setImage:[UIImage imageNamed:@"share2"] forState:UIControlStateNormal];
//    [fenxBtn addTarget:self action:@selector(shareContent:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:fenxBtn];
    
    
    //底部工具栏
    NSArray *imageNameArr = @[@"tel",@"zxzx",@"tjkh",@"yykf"];
    
    for (int i = 0; i < imageNameArr.count; i++) {
        
        UIButton *btmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
     
            
        btmBtn.frame = CGRectMake((theWidth-49*4)/5*(i+1)+49*i, theHeight - 49, 49, 45);

        
        
        btmBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        [btmBtn setImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
        [btmBtn setImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateHighlighted];
        
        [btmBtn addTarget:self action:@selector(btmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btmBtn.tag = i + 80;
        [self.view addSubview:btmBtn];
    }
}

- (NSMutableArray *)datasource {
    
    if (_datasource == nil) {
        _datasource = [[NSMutableArray alloc] init];
    }
    return _datasource;
}

- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)backBtnClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showLinkContent:(UIButton *)btn {
    
    if ([btn.titleLabel.text isEqualToString:@"项目概况"]) {
        LinkViewController *linkVC = [[LinkViewController alloc] init];
        linkVC.navigationItem.title = @"热门楼盘";
        linkVC.projectID = _projectID;
        linkVC.keyName = @"c102";
        [self.navigationController pushViewController:linkVC animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"项目优势"]) {
        LinkViewController *linkVC = [[LinkViewController alloc] init];
        linkVC.navigationItem.title = @"热门楼盘";
        linkVC.projectID = _projectID;
        linkVC.keyName = @"c103";
        [self.navigationController pushViewController:linkVC animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"电子楼书"]) {
        
        LinkViewController *linkVC = [[LinkViewController alloc] init];
        linkVC.navigationItem.title = @"热门楼盘";
        linkVC.projectID = _projectID;
        linkVC.keyName = @"c104";
        [self.navigationController pushViewController:linkVC animated:YES];
        
    }else if ([btn.titleLabel.text isEqualToString:@"我要选房"]) {
        LinkViewController *linkVC = [[LinkViewController alloc] init];
        linkVC.navigationItem.title = @"热门楼盘";
        linkVC.projectID = _projectID;
        linkVC.keyName = @"c105";
        [self.navigationController pushViewController:linkVC animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"项目动态"]) {
        
        LinkViewController *linkVC = [[LinkViewController alloc] init];
        linkVC.navigationItem.title = @"热门楼盘";
        linkVC.projectID = _projectID;
        linkVC.keyName = @"c106";
        [self.navigationController pushViewController:linkVC animated:YES];
        
    }else if ([btn.titleLabel.text isEqualToString:@"户型图"]) {
        
        LinkViewController *linkVC = [[LinkViewController alloc] init];
        linkVC.navigationItem.title = @"热门楼盘";
        linkVC.projectID = _projectID;
        linkVC.keyName = @"c107";
        [self.navigationController pushViewController:linkVC animated:YES];
    }else if ([btn.titleLabel.text isEqualToString:@"置业顾问"]) {
        
        LinkViewController *linkVC = [[LinkViewController alloc] init];
        linkVC.navigationItem.title = @"热门楼盘";
        linkVC.projectID = _projectID;
        linkVC.keyName = @"c108";
        [self.navigationController pushViewController:linkVC animated:YES];
    }
}

- (void)btmBtnClicked:(UIButton *)btn {
    NSLog(@"%zi",btn.tag);
    switch (btn.tag) {
        case 80:
        {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",PhoneNum];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
            
        case 81:
        {
            LinkViewController *linkVC = [[LinkViewController alloc] init];
            linkVC.navigationItem.title = @"热门楼盘";
            linkVC.projectID = _projectID;
            linkVC.keyName = @"c108";
            UINavigationController *linkNac = [[UINavigationController alloc] initWithRootViewController:linkVC];
            [self presentViewController:linkNac animated:YES completion:nil];
        }
            break;
            
        case 82:
        {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
                
                SuggestViewController *log=[[SuggestViewController alloc] init];
                self.navigationController.navigationBarHidden = NO;
                log.hidesBottomBarWhenPushed=YES;
              //  UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:log];
                //[self presentViewController:navigation animated:YES completion:nil];
                [self.navigationController pushViewController:log animated:YES];
       
            }else{
                [self toLogViewCtr];
            }
            
        }
            break;
            
        case 83:
        {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
                VisitViewController *visitVC = [[VisitViewController alloc] init];
                visitVC.projectName = _projectName;
                visitVC.projectID = _projectID;
                visitVC.projectDatas = _projectDatas;
                UINavigationController *visitNAC = [[UINavigationController alloc] initWithRootViewController:visitVC];
                [self presentViewController:visitNAC animated:YES completion:nil];
            }else{
                [self toLogViewCtr];
            }
            
        }
            break;
            
        default:
            break;
    }
}

-(void)dismissHomeAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)toLogViewCtr
{
    LoginViewController *homeLogin=[[LoginViewController alloc] init];
    
    homeLogin.title=@"登录";
    
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:homeLogin];
    
    
    [self presentViewController:nac animated:YES completion:^{
        
    }];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 7;
            break;
            
        case 1:
            return 2;
            break;
            
        case 2:
            return 5;
            break;
            
        case 3:
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: //第一组
        {
            switch (indexPath.row) {
                case 0:
                    return theWidth / 2;
                    break;
                    
                default:
                    return 44;
                    break;
            }
        }
            break;
            
        case 1: //第二组
            return 100;
            break;
            
        case 2: //第三组
            return 44;
            break;
            
        case 3: //第四组
            switch (indexPath.row) {
                case 0:
                    return 44;
                    break;
                    
                default:
                    return theWidth / 2;
                    break;
            }
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseID forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            [cell setData:_datasource[1] byIndexPath:indexPath];
            
        }else {
            
            [cell setData:_datasource[0] byIndexPath:indexPath];
            
        }
    }else {
        [cell setData:_datasource[0] byIndexPath:indexPath];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"1");
                    HouseDetailViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
                    NSLog(@"%f",cell.scrollView.contentOffset.x);
                }
                    break;
                    
                case 5:
                {
                    LinkViewController *linkVC = [[LinkViewController alloc] init];
                    linkVC.navigationItem.title = @"热门楼盘";
                    linkVC.projectID = _projectID;
                    linkVC.keyName = @"c101";
                    [self.navigationController pushViewController:linkVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    LinkViewController *linkVC = [[LinkViewController alloc] init];
                    linkVC.navigationItem.title = @"热门楼盘";
                    linkVC.projectID = _projectID;
                    linkVC.keyName = @"c109";
                    [self.navigationController pushViewController:linkVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    LinkViewController *linkVC = [[LinkViewController alloc] init];
                    linkVC.navigationItem.title = @"热门楼盘";
                    linkVC.projectID = _projectID;
                    linkVC.keyName = @"c101";
                    [self.navigationController pushViewController:linkVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark HttpRequestClassDelegate

-(void)dissActon
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dict = [[NSDictionary alloc] initWithDictionary:json];
    NSLog(@"%@",dict);
    if ([dict[@"errcode"] isEqualToString:@"000"]) {
        if ([dict[@"result"] isKindOfClass:[NSArray class]]) {
            [self.datasource removeAllObjects];
            [self.datasource addObject:dict[@"result"]];
            [self.datasource addObject:dict[@"result1"]];
            
            //显示内容
            _tableView = [[UITableView alloc] init];
            _tableView.frame = CGRectMake(0, 20, theWidth, theHeight - 69);
            _tableView.delegate = self;
            _tableView.dataSource = self;
            [_tableView registerClass:[HouseDetailViewCell class] forCellReuseIdentifier:CellReuseID];
            if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
                [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
                [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
            [self.view addSubview:_tableView];
            
            //加载图片
            int i = 0;
            for (NSDictionary *imageDict in dict[@"result1"]) {
                NSString *pic = [NSString stringWithFormat:@"http://www.yanhongw.com%@",imageDict[@"pic"]];
                NSLog(@"pic:%@",pic);
                DownloadOperation *operation = [[DownloadOperation alloc] init];
                operation.urlStr = pic;
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                operation.indexPath = indexPath;
                operation.delegate = self;
                [self.queue addOperation:operation];
                i++;
            }
            
        }
        
    }else {
        
        [self alertViewWithMessage:[dict objectForKey:@"errmsg"]];
        
    }
    
}

#pragma mark DownloadOperationDelegate

-(void)downloadOperation:(DownloadOperation *)operation didFinishedDownload:(UIImage *)image {
    NSArray *array = _datasource[1];
    NSDictionary *dict = array[operation.indexPath.row];
    [dict setValue:image forKey:@"pic"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    HouseDetailViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (operation.indexPath.row == 0) {
        UIImageView *imageView1 = [cell.scrollView viewWithTag:61];
        imageView1.image = image;
        
        UIImageView *imageView2 = [cell.scrollView viewWithTag:(array.count + 61)];
        imageView2.image = image;
    }else if (operation.indexPath.row == array.count - 1) {
        UIImageView *imageView1 = [cell.scrollView viewWithTag:60];
        imageView1.image = image;
        
        UIImageView *imageView2 = [cell.scrollView viewWithTag:array.count + 60];
        imageView2.image = image;
    }else {
        UIImageView *imageView = [cell.scrollView viewWithTag:operation.indexPath.row + 61];
        imageView.image = image;
    }
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];

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

- (void)shareContent:(id)sender
{

        NSLog(@"url=%@",[dict objectForKey:@"url"]);
        NSLog(@"self.datasource=%@",[self.datasource[0][0] objectForKey:@"address"]);
        NSLog(@"self.datasourceprojectName=%@",[self.datasource[0][0] objectForKey:@"projectName"]);
        //1、构造分享内容
        //1.1、要分享的图片（以下分别是网络图片和本地图片的生成方式的示例）
        
        //id<ISSCAttachment> remoteAttachment = [ShareSDKCoreService attachmentWithUrl:@"http://f.hiphotos.bdimg.com/album/w%3D2048/sign=df8f1fe50dd79123e0e09374990c5882/cf1b9d16fdfaaf51e6d1ce528d5494eef01f7a28.jpg"];
        
        id<ISSCAttachment> localAttachment = [ShareSDKCoreService attachmentWithPath:[[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"]];
        
        //1.2、以下参数分别对应：内容、默认内容、图片、标题、链接、描述、分享类型
        id<ISSContent> publishContent = [ShareSDK content:[self.datasource[0][0] objectForKey:@"address"]
                                           defaultContent:nil
                                                    image:localAttachment
                                                    title:[self.datasource[0][0] objectForKey:@"projectName"]
                                                      url:[dict objectForKey:@"url"]
                                              description:nil
                                                mediaType:SSPublishContentMediaTypeNews];
        
        //1.3、自定义各个平台的分享内容(非必要)
        [self customizePlatformShareContent:publishContent];
        
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
        [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
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
    
    
}

- (void)customizePlatformShareContent:(id<ISSContent>)publishContent
{
    //定制QQ空间分享内容
    [publishContent addQQSpaceUnitWithTitle:@"热门楼盘"
                                        url:nil
                                       site:nil
                                    fromUrl:nil
                                    comment:@"comment"
                                    summary:@"summary"
                                      image:nil
                                       type:@(4)
                                    playUrl:nil
                                       nswb:0];
    
    
}

@end
