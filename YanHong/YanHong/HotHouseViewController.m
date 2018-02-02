//
//  HotHouseViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/10.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "HotHouseViewController.h"
#import "LoginViewController.h"
#import "HouseDetailViewController.h"
//ShareSDK头文件
#import <ShareSDK/ShareSDK.h>
#import "UIWindow+YzdHUD.h"
#import "DownloadOperation.h"
#import "VisitViewController.h"

@interface HotHouseViewController () <DownloadOperationDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableDictionary *operations;
@property (nonatomic, strong) NSMutableDictionary *images;

@end

@implementation HotHouseViewController

//线程方法
-(void)httpData
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //进入下载我的客户信息
    
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1093\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"apptype\":\"2\"}",dateString];
    
    //post 请求
    
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dispatch_queue_t queue = dispatch_queue_create("YH", nil);
    //    创建异步线程
    dispatch_async(queue, ^{
        
        [self httpData];
        
        //      回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame=CGRectMake(0,0,30,25);
            [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal ];
            [button addTarget:self action:@selector(dismissHomeAction) forControlEvents: UIControlEventTouchUpInside ];
            UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:button];
            

            NSArray *array = @[leftItem];
            [self setToolbarItems:array animated:YES];
            self.navigationItem.leftBarButtonItems=array;
            
            

            
        });
    });

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}



-(void)Action
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
   
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

- (NSMutableDictionary *)operations {
    if (_operations == nil) {
        _operations = [[NSMutableDictionary alloc] init];
    }
    return _operations;
}

- (NSMutableDictionary *)images {
    if (_images == nil) {
        _images = [[NSMutableDictionary alloc] init];
    }
    return _images;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareContent:(id)sender
{
    //判断是否登陆，由登陆状态判断启动页面

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        //1、构造分享内容
        //1.1、要分享的图片（以下分别是网络图片和本地图片的生成方式的示例）
        
        //id<ISSCAttachment> remoteAttachment = [ShareSDKCoreService attachmentWithUrl:@"http://f.hiphotos.bdimg.com/album/w%3D2048/sign=df8f1fe50dd79123e0e09374990c5882/cf1b9d16fdfaaf51e6d1ce528d5494eef01f7a28.jpg"];
        
        id<ISSCAttachment> localAttachment = [ShareSDKCoreService attachmentWithPath:[[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"]];
        
        //1.2、以下参数分别对应：内容、默认内容、图片、标题、链接、描述、分享类型
        id<ISSContent> publishContent = [ShareSDK content:@"热门楼盘"
                                           defaultContent:nil
                                                    image:localAttachment
                                                    title:@"热门楼盘"
                                                      url:_url
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
                              SHARE_TYPE_NUMBER(ShareTypeQQ),
                              SHARE_TYPE_NUMBER(ShareTypeQQSpace),
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
                                        UIAlertView *alert = [[UIAlertView alloc]
                                                              initWithTitle:@"分享成功"
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
        
       LoginViewController *homeLogin=[[LoginViewController alloc] init];
        
        homeLogin.title=@"登录";
        
        UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:homeLogin];

        [self presentViewController:nac animated:YES completion:^{
            
        }];
   
    }
    
}

-(void)dismissHomeAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)customizePlatformShareContent:(id<ISSContent>)publishContent
{
    //定制QQ空间分享内容
    [publishContent addQQSpaceUnitWithTitle:@"热门楼盘"
                                        url:_uid
                                       site:nil
                                    fromUrl:nil
                                    comment:@"comment"
                                    summary:@"summary"
                                      image:nil
                                       type:@(4)
                                    playUrl:nil
                                       nswb:0];

    
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIder = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIder];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIder];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for (UIView *subView in cell.subviews) {
        [subView removeFromSuperview];
    }
    
    if (IS_IPHONE_6P) {
        [self setUpIPHONE6PViewWithCell:cell andIndex:indexPath];
    }else if (IS_IPHONE_6) {
        [self setUpIPHONE6ViewWithCell:cell andIndex:indexPath];
    }else if (IS_IPHONE_5) {
        [self setUpIPHONE5ViewWithCell:cell andIndex:indexPath];
    }else if (IS_IPHONE_4_OR_LESS) {
        [self setUpIPHONE4ORLESSViewWithCell:cell andIndex:indexPath];
    }
    
    return cell;
}

- (void)setUpIPHONE6PViewWithCell:(UITableViewCell *)cell andIndex:(NSIndexPath *)indexPath{
    NSDictionary *dict = _datasource[indexPath.row];
    
    CGFloat originY;
    
    originY = 10;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, originY, theWidth - 20, (theWidth - 20) / 2);
    imageView.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:imageView];
    originY += imageView.frame.size.height;
    
    //加载图片
    UIImage *image = _images[dict[@"picture"]];
    if (image) {
        imageView.image = image;
    }else{
        imageView.image = [UIImage imageNamed:@"NoPic.jpg"];
        DownloadOperation *operation = _operations[dict[@"picture"]];
        if (operation == nil) {
            operation = [[DownloadOperation alloc] init];
            operation.urlStr = dict[@"picture"];
            operation.indexPath = indexPath;
            operation.delegate = self;
            [self.queue addOperation:operation];
            _operations[dict[@"picture"]] = operation;
        }
    }
    
    
    
    originY += 10;
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    nameLabel.text = dict[@"projectName"];
    [nameLabel sizeToFit];
    nameLabel.center = CGPointMake(10 + nameLabel.frame.size.width / 2, originY + nameLabel.frame.size.height / 2);
    [cell addSubview:nameLabel];
    originY += 20;
    
    originY += 10;
    UILabel *areaLabel = [[UILabel alloc] init];
    areaLabel.textColor = [UIColor redColor];
    areaLabel.text = dict[@"buildArea"];
    [areaLabel sizeToFit];
    areaLabel.center = CGPointMake(10 + areaLabel.frame.size.width / 2, originY + areaLabel.frame.size.height / 2);
    [cell addSubview:areaLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = [NSString stringWithFormat:@"%@元/㎡",dict[@"price"]];
    [priceLabel sizeToFit];
    priceLabel.center = CGPointMake(theWidth - priceLabel.frame.size.width / 2 - 10, areaLabel.center.y);
    [cell addSubview:priceLabel];
    originY += 20;
    
    originY += 10;
    CGFloat labelWidth;
    UILabel *clientLabel = [[UILabel alloc] init];
    clientLabel.textColor = [UIColor lightGrayColor];
    clientLabel.font = [UIFont systemFontOfSize:15];
    clientLabel.text = @"意向客户:  ";
    [clientLabel sizeToFit];
    clientLabel.center = CGPointMake(clientLabel.frame.size.width / 2 + 10, clientLabel.frame.size.height / 2 + originY);
    [cell addSubview:clientLabel];
    labelWidth = clientLabel.frame.size.width + 10;
    
    UILabel *clientNumLabel = [[UILabel alloc] init];
    clientNumLabel.font = [UIFont systemFontOfSize:15];
    clientNumLabel.text = dict[@"clientNum"];
    [clientNumLabel sizeToFit];
    clientNumLabel.center = CGPointMake(clientNumLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:clientNumLabel];
    labelWidth += clientNumLabel.frame.size.width;
    
    labelWidth += 10;
    UILabel *attentionLabel = [[UILabel alloc] init];
    attentionLabel.textColor = [UIColor lightGrayColor];
    attentionLabel.font = [UIFont systemFontOfSize:15];
    attentionLabel.text = @"关注:  ";
    [attentionLabel sizeToFit];
    attentionLabel.center = CGPointMake(attentionLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:attentionLabel];
    labelWidth += attentionLabel.frame.size.width;
    
    UILabel *attentionNumLabel = [[UILabel alloc] init];
    attentionNumLabel.font = [UIFont systemFontOfSize:15];
    attentionNumLabel.text = dict[@"attentionNum"];
    [attentionNumLabel sizeToFit];
    attentionNumLabel.center = CGPointMake(attentionNumLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:attentionNumLabel];
    
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    orderBtn.layer.cornerRadius = 3;
    orderBtn.layer.borderWidth = 1;
    orderBtn.layer.borderColor = [UIColor redColor].CGColor;
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [orderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [orderBtn setTitle:@"预约看房" forState:UIControlStateNormal];
    [orderBtn sizeToFit];
    orderBtn.frame = CGRectMake(0, 0, orderBtn.frame.size.width + 5, orderBtn.frame.size.height - 8);
    orderBtn.center = CGPointMake(theWidth - orderBtn.frame.size.width / 2 - 10, clientLabel.center.y);
    [orderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:orderBtn];
    originY += clientLabel.frame.size.height;
    
    originY += 10;
    {
        CGFloat originX = 10;
        
        for (int i = 0; i < 5; i++) {
            NSString *keyStr = [NSString stringWithFormat:@"test%d",i];
            NSString *text = dict[keyStr];
            if (text.length != 0) {
                UILabel *testLabel = [[UILabel alloc] init];
                testLabel.layer.cornerRadius = 4;
                testLabel.layer.borderWidth = 1;
                testLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
                testLabel.font = [UIFont systemFontOfSize:15];
                testLabel.textAlignment = NSTextAlignmentCenter;
                testLabel.textColor = [UIColor lightGrayColor];
                testLabel.text = text;
                [testLabel sizeToFit];
                testLabel.frame = CGRectMake(originX, originY, testLabel.frame.size.width + 5, 20);
                [cell addSubview:testLabel];
                originX += (testLabel.frame.size.width + 10);
            }
        }
    }
    originY += 20;
    
    originY += 10;
    UILabel *featureLabel = [[UILabel alloc] init];
    featureLabel.font = [UIFont systemFontOfSize:15];
    featureLabel.text = dict[@"feature"];
    featureLabel.numberOfLines = 0;
    CGSize featureSize = [featureLabel.text boundingRectWithSize:CGSizeMake(theWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:featureLabel.font} context:nil].size;
    featureLabel.frame = CGRectMake(10, originY, featureSize.width, featureSize.height);
    [cell addSubview:featureLabel];
    originY += featureSize.height;
    
    originY += 10;
    cell.frame = CGRectMake(0, 0, theWidth, originY);
}

- (void)setUpIPHONE6ViewWithCell:(UITableViewCell *)cell andIndex:(NSIndexPath *)indexPath{
    NSDictionary *dict = _datasource[indexPath.row];
    
    CGFloat originY;
    
    originY = 10;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, originY, theWidth - 20, (theWidth - 20) / 2);
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.image = [UIImage imageNamed:@"NoPic.jpg"];
    [cell addSubview:imageView];
    originY += imageView.frame.size.height;
    
    //加载图片
    UIImage *image = _images[dict[@"picture"]];
    if (image) {
        imageView.image = image;
    }else{
        imageView.image = [UIImage imageNamed:@"NoPic.jpg"];
        DownloadOperation *operation = _operations[dict[@"picture"]];
        if (operation == nil) {
            operation = [[DownloadOperation alloc] init];
            operation.urlStr = dict[@"picture"];
            operation.indexPath = indexPath;
            operation.delegate = self;
            [self.queue addOperation:operation];
            _operations[dict[@"picture"]] = operation;
        }
    }
    
    
    
    originY += 10;
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont boldSystemFontOfSize:19];
    nameLabel.text = dict[@"projectName"];
    [nameLabel sizeToFit];
    nameLabel.center = CGPointMake(10 + nameLabel.frame.size.width / 2, originY + nameLabel.frame.size.height / 2);
    [cell addSubview:nameLabel];
    originY += 20;
    
    originY += 10;
    UILabel *areaLabel = [[UILabel alloc] init];
    areaLabel.textColor = [UIColor redColor];
    areaLabel.text = dict[@"buildArea"];
    [areaLabel sizeToFit];
    areaLabel.center = CGPointMake(10 + areaLabel.frame.size.width / 2, originY + areaLabel.frame.size.height / 2);
    [cell addSubview:areaLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = [NSString stringWithFormat:@"%@元/㎡",dict[@"price"]];
    [priceLabel sizeToFit];
    priceLabel.center = CGPointMake(theWidth - priceLabel.frame.size.width / 2 - 10, areaLabel.center.y);
    [cell addSubview:priceLabel];
    originY += 20;
    
    originY += 10;
    CGFloat labelWidth;
    UILabel *clientLabel = [[UILabel alloc] init];
    clientLabel.textColor = [UIColor lightGrayColor];
    clientLabel.font = [UIFont systemFontOfSize:15];
    clientLabel.text = @"意向客户:  ";
    [clientLabel sizeToFit];
    clientLabel.center = CGPointMake(clientLabel.frame.size.width / 2 + 10, clientLabel.frame.size.height / 2 + originY);
    [cell addSubview:clientLabel];
    labelWidth = clientLabel.frame.size.width + 10;
    
    UILabel *clientNumLabel = [[UILabel alloc] init];
    clientNumLabel.font = [UIFont systemFontOfSize:15];
    clientNumLabel.text = dict[@"clientNum"];
    [clientNumLabel sizeToFit];
    clientNumLabel.center = CGPointMake(clientNumLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:clientNumLabel];
    labelWidth += clientNumLabel.frame.size.width;
    
    labelWidth += 10;
    UILabel *attentionLabel = [[UILabel alloc] init];
    attentionLabel.textColor = [UIColor lightGrayColor];
    attentionLabel.font = [UIFont systemFontOfSize:15];
    attentionLabel.text = @"关注:  ";
    [attentionLabel sizeToFit];
    attentionLabel.center = CGPointMake(attentionLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:attentionLabel];
    labelWidth += attentionLabel.frame.size.width;
    
    UILabel *attentionNumLabel = [[UILabel alloc] init];
    attentionNumLabel.font = [UIFont systemFontOfSize:15];
    attentionNumLabel.text = dict[@"attentionNum"];
    [attentionNumLabel sizeToFit];
    attentionNumLabel.center = CGPointMake(attentionNumLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:attentionNumLabel];

    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    orderBtn.layer.cornerRadius = 3;
    orderBtn.layer.borderWidth = 1;
    orderBtn.layer.borderColor = [UIColor redColor].CGColor;
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [orderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [orderBtn setTitle:@"预约看房" forState:UIControlStateNormal];
    [orderBtn sizeToFit];
    orderBtn.frame = CGRectMake(0, 0, orderBtn.frame.size.width + 5, orderBtn.frame.size.height - 8);
    orderBtn.center = CGPointMake(theWidth - orderBtn.frame.size.width / 2 - 10, clientLabel.center.y);
    [orderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:orderBtn];
    originY += clientLabel.frame.size.height;
    
//    UILabel *orderLabel = [[UILabel alloc] init];
//    orderLabel.textColor = [UIColor lightGrayColor];
//    orderLabel.font = [UIFont systemFontOfSize:15];
//    orderLabel.text = @"预约看房";
//    [orderLabel sizeToFit];
//    orderLabel.center = CGPointMake(theWidth - orderLabel.frame.size.width / 2 - 10, clientLabel.center.y);
//    [cell addSubview:orderLabel];
//    originY += clientLabel.frame.size.height;
    
    originY += 10;
    {
        CGFloat originX = 10;
        
        for (int i = 0; i < 5; i++) {
            NSString *keyStr = [NSString stringWithFormat:@"test%d",i];
            NSString *text = dict[keyStr];
            if (text.length != 0) {
                UILabel *testLabel = [[UILabel alloc] init];
                testLabel.layer.cornerRadius = 4;
                testLabel.layer.borderWidth = 1;
                testLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
                testLabel.font = [UIFont systemFontOfSize:15];
                testLabel.textAlignment = NSTextAlignmentCenter;
                testLabel.textColor = [UIColor lightGrayColor];
                testLabel.text = text;
                [testLabel sizeToFit];
                testLabel.frame = CGRectMake(originX, originY, testLabel.frame.size.width + 5, 20);
                [cell addSubview:testLabel];
                originX += (testLabel.frame.size.width + 10);
            }
        }
    }
    originY += 20;
    
    originY += 10;
    UILabel *featureLabel = [[UILabel alloc] init];
    featureLabel.font = [UIFont systemFontOfSize:15];
    featureLabel.text = dict[@"feature"];
    featureLabel.numberOfLines = 0;
    CGSize featureSize = [featureLabel.text boundingRectWithSize:CGSizeMake(theWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:featureLabel.font} context:nil].size;
    featureLabel.frame = CGRectMake(10, originY, featureSize.width, featureSize.height);
    [cell addSubview:featureLabel];
    originY += featureSize.height;
    
    originY += 10;
    cell.frame = CGRectMake(0, 0, theWidth, originY);
}

- (void)setUpIPHONE5ViewWithCell:(UITableViewCell *)cell andIndex:(NSIndexPath *)indexPath{
    NSDictionary *dict = _datasource[indexPath.row];
    
    CGFloat originY;
    
    originY = 10;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, originY, theWidth - 20, (theWidth - 20) / 2);
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.image = [UIImage imageNamed:@"NoPic.jpg"];
    [cell addSubview:imageView];
    originY += imageView.frame.size.height;
    
    //加载图片
    UIImage *image = _images[dict[@"picture"]];
    if (image) {
        imageView.image = image;
    }else{
        imageView.image = [UIImage imageNamed:@"NoPic.jpg"];
        DownloadOperation *operation = _operations[dict[@"picture"]];
        if (operation == nil) {
            operation = [[DownloadOperation alloc] init];
            operation.urlStr = dict[@"picture"];
            operation.indexPath = indexPath;
            operation.delegate = self;
            [self.queue addOperation:operation];
            _operations[dict[@"picture"]] = operation;
        }
    }
    
    
    originY += 10;
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    nameLabel.text = dict[@"projectName"];
    [nameLabel sizeToFit];
    nameLabel.center = CGPointMake(10 + nameLabel.frame.size.width / 2, originY + nameLabel.frame.size.height / 2);
    [cell addSubview:nameLabel];
    originY += 20;
    
    originY += 10;
    UILabel *areaLabel = [[UILabel alloc] init];
    areaLabel.textColor = [UIColor redColor];
    areaLabel.font = [UIFont systemFontOfSize:16];
    areaLabel.text = dict[@"buildArea"];
    [areaLabel sizeToFit];
    areaLabel.center = CGPointMake(10 + areaLabel.frame.size.width / 2, originY + areaLabel.frame.size.height / 2);
    [cell addSubview:areaLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:16];
    priceLabel.text = [NSString stringWithFormat:@"%@元/㎡",dict[@"price"]];
    [priceLabel sizeToFit];
    priceLabel.center = CGPointMake(theWidth - priceLabel.frame.size.width / 2 - 10, areaLabel.center.y);
    [cell addSubview:priceLabel];
    originY += 20;
    
    originY += 10;
    CGFloat labelWidth;
    UILabel *clientLabel = [[UILabel alloc] init];
    clientLabel.textColor = [UIColor lightGrayColor];
    clientLabel.font = [UIFont systemFontOfSize:14];
    clientLabel.text = @"意向客户:  ";
    [clientLabel sizeToFit];
    clientLabel.center = CGPointMake(clientLabel.frame.size.width / 2 + 10, clientLabel.frame.size.height / 2 + originY);
    [cell addSubview:clientLabel];
    labelWidth = clientLabel.frame.size.width + 10;
    
    UILabel *clientNumLabel = [[UILabel alloc] init];
    clientNumLabel.font = [UIFont systemFontOfSize:14];
    clientNumLabel.text = dict[@"clientNum"];
    [clientNumLabel sizeToFit];
    clientNumLabel.center = CGPointMake(clientNumLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:clientNumLabel];
    labelWidth += clientNumLabel.frame.size.width;
    
    labelWidth += 10;
    UILabel *attentionLabel = [[UILabel alloc] init];
    attentionLabel.textColor = [UIColor lightGrayColor];
    attentionLabel.font = [UIFont systemFontOfSize:14];
    attentionLabel.text = @"关注:  ";
    [attentionLabel sizeToFit];
    attentionLabel.center = CGPointMake(attentionLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:attentionLabel];
    labelWidth += attentionLabel.frame.size.width;
    
    UILabel *attentionNumLabel = [[UILabel alloc] init];
    attentionNumLabel.font = [UIFont systemFontOfSize:14];
    attentionNumLabel.text = dict[@"attentionNum"];
    [attentionNumLabel sizeToFit];
    attentionNumLabel.center = CGPointMake(attentionNumLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:attentionNumLabel];

    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    orderBtn.layer.cornerRadius = 3;
    orderBtn.layer.borderWidth = 1;
    orderBtn.layer.borderColor = [UIColor redColor].CGColor;
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [orderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [orderBtn setTitle:@"预约看房" forState:UIControlStateNormal];
    [orderBtn sizeToFit];
    orderBtn.frame = CGRectMake(0, 0, orderBtn.frame.size.width + 5, orderBtn.frame.size.height - 8);
    orderBtn.center = CGPointMake(theWidth - orderBtn.frame.size.width / 2 - 10, clientLabel.center.y);
    [orderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:orderBtn];
    originY += clientLabel.frame.size.height;
    
//    UILabel *orderLabel = [[UILabel alloc] init];
//    orderLabel.textColor = [UIColor lightGrayColor];
//    orderLabel.font = [UIFont systemFontOfSize:14];
//    orderLabel.text = @"预约看房";
//    [orderLabel sizeToFit];
//    orderLabel.center = CGPointMake(theWidth - orderLabel.frame.size.width / 2 - 10, clientLabel.center.y);
//    [cell addSubview:orderLabel];
//    originY += clientLabel.frame.size.height;
    
    originY += 10;
    {
        CGFloat originX = 10;
        
        for (int i = 0; i < 5; i++) {
            NSString *keyStr = [NSString stringWithFormat:@"test%d",i];
            NSString *text = dict[keyStr];
            if (text.length != 0) {
                UILabel *testLabel = [[UILabel alloc] init];
                testLabel.layer.cornerRadius = 4;
                testLabel.layer.borderWidth = 1;
                testLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
                testLabel.font = [UIFont systemFontOfSize:14];
                testLabel.textAlignment = NSTextAlignmentCenter;
                testLabel.textColor = [UIColor lightGrayColor];
                testLabel.text = text;
                [testLabel sizeToFit];
                testLabel.frame = CGRectMake(originX, originY, testLabel.frame.size.width + 5, 20);
                [cell addSubview:testLabel];
                originX += (testLabel.frame.size.width + 10);
            }
        }
    }
    originY += 20;
    
    originY += 10;
    UILabel *featureLabel = [[UILabel alloc] init];
    featureLabel.font = [UIFont systemFontOfSize:14];
    featureLabel.text = dict[@"feature"];
    featureLabel.numberOfLines = 0;
    CGSize featureSize = [featureLabel.text boundingRectWithSize:CGSizeMake(theWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:featureLabel.font} context:nil].size;
    featureLabel.frame = CGRectMake(10, originY, featureSize.width, featureSize.height);
    [cell addSubview:featureLabel];
    originY += featureSize.height;
    
    originY += 10;
    cell.frame = CGRectMake(0, 0, theWidth, originY);
}

- (void)setUpIPHONE4ORLESSViewWithCell:(UITableViewCell *)cell andIndex:(NSIndexPath *)indexPath{
    NSDictionary *dict = _datasource[indexPath.row];
    
    CGFloat originY;
    
    originY = 10;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, originY, theWidth - 20, (theWidth - 20) / 2);
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.image = [UIImage imageNamed:@"NoPic.jpg"];
    [cell addSubview:imageView];
    originY += imageView.frame.size.height;
    
    //加载图片
    UIImage *image = _images[dict[@"picture"]];
    if (image) {
        imageView.image = image;
    }else{
        imageView.image = [UIImage imageNamed:@"NoPic.jpg"];
        DownloadOperation *operation = _operations[dict[@"picture"]];
        if (operation == nil) {
            operation = [[DownloadOperation alloc] init];
            operation.urlStr = dict[@"picture"];
            operation.indexPath = indexPath;
            operation.delegate = self;
            [self.queue addOperation:operation];
            _operations[dict[@"picture"]] = operation;
        }
    }
    
    
    originY += 10;
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    nameLabel.text = dict[@"projectName"];
    [nameLabel sizeToFit];
    nameLabel.center = CGPointMake(10 + nameLabel.frame.size.width / 2, originY + nameLabel.frame.size.height / 2);
    [cell addSubview:nameLabel];
    originY += 20;
    
    originY += 10;
    UILabel *areaLabel = [[UILabel alloc] init];
    areaLabel.textColor = [UIColor redColor];
    areaLabel.font = [UIFont systemFontOfSize:15];
    areaLabel.text = dict[@"buildArea"];
    [areaLabel sizeToFit];
    areaLabel.center = CGPointMake(10 + areaLabel.frame.size.width / 2, originY + areaLabel.frame.size.height / 2);
    [cell addSubview:areaLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.text = [NSString stringWithFormat:@"%@元/㎡",dict[@"price"]];
    [priceLabel sizeToFit];
    priceLabel.center = CGPointMake(theWidth - priceLabel.frame.size.width / 2 - 10, areaLabel.center.y);
    [cell addSubview:priceLabel];
    originY += 20;
    
    originY += 10;
    CGFloat labelWidth;
    UILabel *clientLabel = [[UILabel alloc] init];
    clientLabel.textColor = [UIColor lightGrayColor];
    clientLabel.font = [UIFont systemFontOfSize:13];
    clientLabel.text = @"意向客户:  ";
    [clientLabel sizeToFit];
    clientLabel.center = CGPointMake(clientLabel.frame.size.width / 2 + 10, clientLabel.frame.size.height / 2 + originY);
    [cell addSubview:clientLabel];
    labelWidth = clientLabel.frame.size.width + 10;
    
    UILabel *clientNumLabel = [[UILabel alloc] init];
    clientNumLabel.font = [UIFont systemFontOfSize:13];
    clientNumLabel.text = dict[@"clientNum"];
    [clientNumLabel sizeToFit];
    clientNumLabel.center = CGPointMake(clientNumLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:clientNumLabel];
    labelWidth += clientNumLabel.frame.size.width;
    
    labelWidth += 10;
    UILabel *attentionLabel = [[UILabel alloc] init];
    attentionLabel.textColor = [UIColor lightGrayColor];
    attentionLabel.font = [UIFont systemFontOfSize:13];
    attentionLabel.text = @"关注:  ";
    [attentionLabel sizeToFit];
    attentionLabel.center = CGPointMake(attentionLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:attentionLabel];
    labelWidth += attentionLabel.frame.size.width;
    
    UILabel *attentionNumLabel = [[UILabel alloc] init];
    attentionNumLabel.font = [UIFont systemFontOfSize:13];
    attentionNumLabel.text = dict[@"attentionNum"];
    [attentionNumLabel sizeToFit];
    attentionNumLabel.center = CGPointMake(attentionNumLabel.frame.size.width / 2 + labelWidth, clientLabel.center.y);
    [cell addSubview:attentionNumLabel];

    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    orderBtn.layer.cornerRadius = 3;
    orderBtn.layer.borderWidth = 1;
    orderBtn.layer.borderColor = [UIColor redColor].CGColor;
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [orderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [orderBtn setTitle:@"预约看房" forState:UIControlStateNormal];
    [orderBtn sizeToFit];
    orderBtn.frame = CGRectMake(0, 0, orderBtn.frame.size.width + 5, orderBtn.frame.size.height - 8);
    orderBtn.center = CGPointMake(theWidth - orderBtn.frame.size.width / 2 - 10, clientLabel.center.y);
    [orderBtn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:orderBtn];
    originY += clientLabel.frame.size.height;
    
//    UILabel *orderLabel = [[UILabel alloc] init];
//    orderLabel.textColor = [UIColor lightGrayColor];
//    orderLabel.font = [UIFont systemFontOfSize:13];
//    orderLabel.text = @"预约看房";
//    [orderLabel sizeToFit];
//    orderLabel.center = CGPointMake(theWidth - orderLabel.frame.size.width / 2 - 10, clientLabel.center.y);
//    [cell addSubview:orderLabel];
//    originY += clientLabel.frame.size.height;
    
    originY += 10;
    {
        CGFloat originX = 10;
        
        for (int i = 0; i < 5; i++) {
            NSString *keyStr = [NSString stringWithFormat:@"test%d",i];
            NSString *text = dict[keyStr];
            if (text.length != 0) {
                UILabel *testLabel = [[UILabel alloc] init];
                testLabel.layer.cornerRadius = 4;
                testLabel.layer.borderWidth = 1;
                testLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
                testLabel.font = [UIFont systemFontOfSize:13];
                testLabel.textAlignment = NSTextAlignmentCenter;
                testLabel.textColor = [UIColor lightGrayColor];
                testLabel.text = text;
                [testLabel sizeToFit];
                testLabel.frame = CGRectMake(originX, originY, testLabel.frame.size.width + 5, 20);
                [cell addSubview:testLabel];
                originX += (testLabel.frame.size.width + 10);
            }
        }
    }
    originY += 20;
    
    originY += 10;
    UILabel *featureLabel = [[UILabel alloc] init];
    featureLabel.font = [UIFont systemFontOfSize:13];
    featureLabel.text = dict[@"feature"];
    featureLabel.numberOfLines = 0;
    CGSize featureSize = [featureLabel.text boundingRectWithSize:CGSizeMake(theWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:featureLabel.font} context:nil].size;
    featureLabel.frame = CGRectMake(10, originY, featureSize.width, featureSize.height);
    [cell addSubview:featureLabel];
    originY += featureSize.height;
    
    originY += 10;
    cell.frame = CGRectMake(0, 0, theWidth, originY);
}

- (void)orderBtnClicked:(UIButton *)btn {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        UITableViewCell *cell = (UITableViewCell *)btn.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary *dict = _datasource[indexPath.row];
        VisitViewController *visitVC = [[VisitViewController alloc] init];
        visitVC.projectName = dict[@"projectName"];
        visitVC.projectID = dict[@"projectId"];
        visitVC.projectDatas = self.datasource;
        UINavigationController *visitNAC = [[UINavigationController alloc] initWithRootViewController:visitVC];
        [self presentViewController:visitNAC animated:YES completion:nil];

    }else{
        
        LoginViewController *homeLogin=[[LoginViewController alloc] init];
        
        homeLogin.title=@"登录";
        
        UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:homeLogin];
        
        [self presentViewController:nac animated:YES completion:^{
            
        }];
        
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = _datasource[indexPath.row];
    HouseDetailViewController *houseDetailVC = [[HouseDetailViewController alloc] init];
    houseDetailVC.projectName = dict[@"projectName"];
    houseDetailVC.projectID = dict[@"projectId"];
    houseDetailVC.projectDatas = self.datasource;
    [self.navigationController pushViewController:houseDetailVC animated:YES];
}

#pragma mark DownloadOperationDelegate

-(void)downloadOperation:(DownloadOperation *)operation didFinishedDownload:(UIImage *)image {
    NSLog(@"%@",image);
    [self.operations removeObjectForKey:operation.urlStr];
    self.images[operation.urlStr] = image;
    [self.tableView reloadRowsAtIndexPaths:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark HttpRequestClassDelegate

-(void)dissActon
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    [self performSelector:@selector(dissActon) withObject:self afterDelay:0.5];
    
    NSLog(@"委托后的数据：%@",dic);
 
    if ([dic[@"errcode"] isEqualToString:@"000"]) {
        
        if ([dic[@"result"] isKindOfClass:[NSArray class]]) {
            [self.datasource removeAllObjects];
            self.datasource = dic[@"result"];
            NSLog(@"%@",self.datasource);
            
            _tableView = [[UITableView alloc] init];
            _tableView.frame = CGRectMake(0, 0, theWidth, theHeight-60);
            _tableView.delegate = self;
            _tableView.dataSource = self;
            if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
                [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
            if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
                [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
            [self.view addSubview:_tableView];
        }
        
    }else {
        
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
    
    }
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    
    
}

@end
