//
//  MoblieFriendViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/21.
//  Copyright © 2015年 anbaoxing. All rights reserved.

#import "MoblieFriendViewController.h"
#import "MoblieFriendListViewController.h"
#import "MobileCheckViewController.h"
#import <AddressBook/AddressBook.h>
#import "pinyin.h"
#import "YH_FriendViewController.h"
#import "YH_AddFriendSViewController.h"
#import "YH_FriendInfoViewController.h"
#import "LoginViewController.h"

#import "UIWindow+YzdHUD.h"

#import <ShareSDK/ShareSDK.h>

@interface MoblieFriendViewController ()

@end

@implementation MoblieFriendViewController

//登陆界面
-(void)logViewAction
{
    LoginViewController *homeLogin=[[LoginViewController alloc] init];
    homeLogin.title=@"登录";
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:homeLogin];
    [self presentViewController:nac animated:YES completion:^{
        
    }];
    
}

//线程方法
-(void)threadMethod
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //请求数据
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1051\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
    //post 请求
    
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    ruqeustButton.backgroundColor = [UIColor clearColor];
    
    _allArr=[[NSMutableArray alloc] init];
    
    NSLog(@"uid=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]);
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
    
        _allArr = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"myFriarray"]];
        
        if (_allArr.count!=0) {
            
            [self addAZ:_allArr];
            
        }else{
            
            //加载好友
            NSThread *thread=[[NSThread alloc] initWithTarget:self selector:@selector(threadMethod) object:nil];
            
            [thread start];
        }
   
    }else{
        
        [self addAZ:nil];
        [_theTableView reloadData];
    }
    
}

-(void)alert:(NSString *)title withMess:(NSString *)messge withFid:(NSString *)fid withRecievedId:(NSString *)recievedId{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:messge preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.view.window showHUDWithText:@"正在转发..." Type:ShowLoading Enabled:YES];
        
        theindex=2;
        
        NSLog(@"hid=%@",_hid);
        
        NSLog(@"uid=%@",_uid);
        
        NSLog(@"_codeStr=%@",_codeStr);
        
        NSLog(@"fid=%@",fid);
        
        NSLog(@"reviId=%@",recievedId);
        
        //当前时间
        NSDate *date=[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSS";
        NSString *dateString = [formatter stringFromDate:date];
        
        //房源信息（转发）
        NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1057\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"hid\":\"%@\",\"fid\":\"%@\",\"price\":\"%@\",\"contact\":\"%@\",\"disphone\":\"%@\",\"recievedid\":\"%@\",\"validcode\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],_hid,fid,_forWardArr[0],_forWardArr[1],_forWardArr[2],recievedId,_codeStr];
        
        httpRequest=[HttpRequestCalss sharnInstance];
        httpRequest.delegate=self;
        [httpRequest httpRequest:strJson];
        
    }];
    
    UIAlertAction *noAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:sure];
    [alert addAction:noAction];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
//朋友圈
-(void)forWardAllAction{

    theindex=2;
    if (dic!=nil && dic.count!=0) {
        NSArray *arr=[dic objectForKey:@"result"];
        if (arr!=nil && arr.count!=0) {
            for (NSDictionary *dict in arr) {
                [self alert:@"确定转发到：" withMess:@"朋友圈" withFid:[dict objectForKey:@"uid"]  withRecievedId:@"0"];
            }
        }
    }
}

static int theFont;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _allArr=[[NSMutableArray alloc] init];
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S

        theFont=15;
        
    }else if (IS_IPHONE_5) {  // 5, 5S

        theFont=15;
        
    }else if (IS_IPHONE_6) {  // 6

        theFont=18;
        
    }else if (IS_IPHONE_6P) {  // 6P

        theFont=18;
        
    }
    

    // Do any additional setup after loading the view from its nib
    //——————————————————————————————————————————————————————————————————————— //通过判断self.title isEqualToString:@"选择"，是哪个界面，该界面共用————————————————————————
  //通过判断self.title isEqualToString:@"选择"
     
    if ([self.title isEqualToString:@"选择"]) {
        
        //tableHeaderView
        view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,theWidth, 50)];
        view.backgroundColor=[UIColor clearColor];
        _theTableView.tableHeaderView=view;
        
        UIImageView *theimageView=[[UIImageView alloc] initWithFrame:CGRectMake(20,10, 30, 30)];
        theimageView.image=[UIImage imageNamed:@"request2"];
        [view addSubview:theimageView];
        
        //朋友圈
        UIButton *forwardButton=[[UIButton alloc] initWithFrame:CGRectMake(60, 3, theWidth-50, 44)];
        forwardButton.backgroundColor=[UIColor clearColor];
        forwardButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        forwardButton.alpha=0.95;
        [forwardButton setTitle:@"朋友圈" forState:UIControlStateNormal];
        [forwardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
        forwardButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
        [forwardButton addTarget:self action:@selector(forWardAllAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:forwardButton];
        
        
        
    }else{
        
        
        UIView *ButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
        UIButton *homeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 25)];
        homeButton.backgroundColor = [UIColor clearColor];
        [homeButton setTitle:@"邀请" forState:UIControlStateNormal];
        homeButton.titleLabel.font=[UIFont systemFontOfSize:16];
        
        [homeButton addTarget:self action:@selector(shareContent:) forControlEvents:UIControlEventTouchUpInside];
        //创建分享按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:ButtonView];
  
        [ButtonView addSubview:homeButton];
        

        //tableHeaderView
       // view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,theWidth, 100)];
        view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,theWidth, 50)];
        _theTableView.tableHeaderView=view;
        
        ruqeustButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, theWidth, 50)];
        ruqeustButton.backgroundColor = [UIColor clearColor];
        ruqeustButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        ruqeustButton.titleLabel.font=[UIFont systemFontOfSize:theFont-2];
        ruqeustButton.alpha=0.95;
        [ruqeustButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal ];
        [view addSubview:ruqeustButton];
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
        label.textAlignment=NSTextAlignmentLeft;
        label.text=@"新的朋友";
        label.font=[UIFont systemFontOfSize:theFont-2];
        [ruqeustButton addSubview:label];
        
        UIImageView *theimageView=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth-30, (50-14)/2, 8.2, 12.5)];
        theimageView.image=[UIImage imageNamed:@"4"];
        [ruqeustButton addSubview:theimageView];
        

        ruqeustButton1=[[UIButton alloc] initWithFrame:CGRectMake(0, (100-50*2)/2*2+50, theWidth, 50)];
        ruqeustButton1.alpha=0.95;
        [ruqeustButton1 setTitle:@"2" forState:UIControlStateNormal];
        ruqeustButton1.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        ruqeustButton1.backgroundColor=[UIColor clearColor];
        
        ruqeustButton1.titleLabel.font=[UIFont systemFontOfSize:theFont-2];
        [ruqeustButton1 setTitleColor:[UIColor clearColor] forState:UIControlStateNormal ];
      //  [view addSubview:ruqeustButton1];
        
        UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
        label1.textAlignment=NSTextAlignmentLeft;
        label1.text=@"标签";
        label1.font=[UIFont systemFontOfSize:theFont-2];
        //[ruqeustButton1 addSubview:label1];
        
        UIImageView *theimageView1=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth-30, (50-14)/2, 8.2, 12.5)];
        theimageView1.image=[UIImage imageNamed:@"4"];
        [ruqeustButton1 addSubview:theimageView1];
        
        [ruqeustButton addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [ruqeustButton setTitle:@"1" forState:UIControlStateNormal];
        [ruqeustButton addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
        [ruqeustButton1 addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [ruqeustButton1 addTarget:self action:@selector(button1BackGroundNormal:)forControlEvents:UIControlEventTouchUpInside];

        for (int i=0; i<1; i++) {
            
            if (i==0) {
                UIImageView *theimageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
                theimageView.image=[UIImage imageNamed:[[NSString alloc] initWithFormat:@"friend%i",i+1]];
                [view addSubview:theimageView];
            }else{
                UIImageView *theimageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, (150-30*3)/4*(i+1)+30*i, 30, 30)];
                theimageView.image=[UIImage imageNamed:[[NSString alloc] initWithFormat:@"friend%i",i+1]];
                [view addSubview:theimageView];
            }
            
            if (i!=0) {
                
                UIView *viewLine1=[[UIView alloc] initWithFrame:CGRectMake(15,(145-30*3)/4*i +30*i+((145-30*3)/4)/2,theWidth-30, 1)];
                viewLine1.alpha=0.2;
                viewLine1.backgroundColor=[UIColor grayColor];
                //[view addSubview:viewLine1];
                
            }
        }
        
        
    }
    //tableFooterView
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(20, 0,theWidth-40, 40)];
    footView.backgroundColor=[UIColor clearColor];
    countLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, theWidth-40, 40)];
    countLable.alpha=0.6;
    countLable.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:237/255.0 alpha:1];
    countLable.font=[UIFont systemFontOfSize:theFont-2];
    countLable.textAlignment=NSTextAlignmentCenter;
    [footView addSubview:countLable];
    _theTableView.tableFooterView=footView;
    
}

//  button1普通状态下的背景色
- (void)button1BackGroundNormal:(UIButton *)sender
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        NSLog(@"sender=%@",sender.titleLabel.text);
        
        if ([sender.titleLabel.text isEqualToString:@"1"]) {
            
            YH_AddFriendSViewController *addF=[[YH_AddFriendSViewController alloc] init];
            addF.hidesBottomBarWhenPushed=YES;
            addF.title=@"新的朋友";
            addF.allArr=[dic objectForKey:@"result"];
            [self.navigationController pushViewController:addF animated:YES];
            
            
        }
        
        sender.backgroundColor = [UIColor clearColor];
        
    }else{
        
        sender.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1];
        
        [self logViewAction];
    }
    
   
    
}

//  button1高亮状态下的背景色
- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
       sender.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1];
        
    }else{
    
        [self logViewAction];
    }

    
}

//朋友圈
-(void)friendsClricleAction
{

    MoblieFriendListViewController *moblie=[[MoblieFriendListViewController alloc] init];
    moblie.hidesBottomBarWhenPushed=YES;
    moblie.title=@"邀请手机通讯录";
    [self.navigationController pushViewController:moblie animated:YES];
    
}

//把数组加入到A～Z
-(void)addAZ:(NSMutableArray *)arrAZ{
    
    //    联系人分组
    _theSectionDic = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < 26; i++)
    {
        [_theSectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
        
    }//26个字母
    
    //    把联系人加入26个字母
    for (NSDictionary *dict in arrAZ) {
        
        NSString *nameStr=[dict objectForKey:@"nickname"];
        
        //  NSLog(@"name=%@",nameStr);
        
        if (nameStr.length!=0) {
            
            if ([self IsChinese:nameStr]==YES) {
                
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([nameStr characterAtIndex:0])]uppercaseString];
                arry = [_theSectionDic objectForKey:singlePinyinLetter];
                
                [arry addObject:dict];
                
            }else{
                
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",([nameStr characterAtIndex:0])]uppercaseString];
                arry = [_theSectionDic objectForKey:singlePinyinLetter];
                [arry addObject:dict];
                
            }
            
        }
        
    }
    
    //    把A~Z key中空的值，去掉
    for (NSString *key in [_theSectionDic allKeys]) {
        NSArray *arry1 = [_theSectionDic objectForKey:key];
        if ([arry1 count]==0) {
            [_theSectionDic removeObjectForKey:key];
        }
    }
    //   A~Z 排序
    _SortArry = [[_theSectionDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    _theSortArry  = [[NSMutableArray alloc] initWithArray:_SortArry];
    
    [_theTableView reloadData];
    
    if (arrAZ.count==0) {
        //联系人总数
        if (theindex==2) {
            
            countLable.text=[[NSString alloc] initWithFormat:@""];
            
        }else{
            
            _theSearchBar.placeholder=@"共0位联系人";
        }
        
    }else{
        
        _theSearchBar.placeholder=[[NSString alloc] initWithFormat:@"%lu位联系人",(unsigned long)arrAZ.count];
    }
    
}

//判断是否有中文
-(BOOL)IsChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
           return YES;
        }
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return myArr.count;

    }else
    {
        NSString *key = [_theSortArry objectAtIndex:section];
        NSArray *arry1 = [_theSectionDic objectForKey:key];
        return arry1.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIder = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIder];
        
    }
    
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
        imageView.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:imageView];
        
        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(55, 7, theWidth-65, 30)];
        nameLable.backgroundColor=[UIColor clearColor];
        nameLable.alpha=0.7;
        nameLable.font=[UIFont systemFontOfSize:theFont-2];
        [cell.contentView addSubview:nameLable];
       
        NSDictionary *dict=[myArr objectAtIndex:indexPath.row];
        
        NSString *strName=[dict objectForKey:@"nickname"];
    
        nameLable.text = strName;
        
        NSString *imageStr=[dict objectForKey:@"headpicture"];
        
        if (imageStr.length!=0) {
            
            NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[dict objectForKey:@"headpicture"]];
            
            UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
            
            imageView.image=_decodedImage;
            
        }else{
            
            imageView.image=[UIImage imageNamed:@"theHead"];
            
        }
      
    }else{
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 30, 30)];
        imageView.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:imageView];
        
        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(60, 7, theWidth-65, 30)];
        nameLable.backgroundColor=[UIColor clearColor];
        nameLable.alpha=0.7;
        nameLable.font=[UIFont systemFontOfSize:theFont-2];
        [cell.contentView addSubview:nameLable];
        
        NSString *key = [_theSortArry objectAtIndex:indexPath.section];
        NSArray *arry1 = [_theSectionDic objectForKey:key];
        
        NSDictionary *dic1=[arry1 objectAtIndex:indexPath.row];
     
        NSString *nameStr=[dic1 objectForKey:@"nickname"];
        
        NSString *imageStr=[dic1 objectForKey:@"headpicture"];
        
        if (imageStr.length!=0) {
            
            NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[dic1 objectForKey:@"headpicture"]];
            
            UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
            
            imageView.image=_decodedImage;

        }else{
            
            imageView.image=[UIImage imageNamed:@"theHead"];
            
        }
        
        nameLable.text = nameStr;

    }
  
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        
        return 1;
    }else
    {
        return _theSortArry.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView
    )
    {
        return 1;
    }
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        
        return nil;
    }
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 25)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, theWidth-40, 25)];
    label.font=[UIFont systemFontOfSize:14];
    label.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    label.textColor = [UIColor grayColor];
    NSString *key = [_theSortArry objectAtIndex:section];
    label.text =  [[NSString alloc] initWithFormat:@" %@",key];
    [view1 addSubview:label];
    return view1;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 0;
    }
   // 更改索引的文字颜色:
    
    _theTableView.sectionIndexColor = [UIColor grayColor];

    return _SortArry;
    
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 0;
    }
    return index;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([self.title isEqualToString:@"选择"]){
        
        NSString *key = [_theSortArry objectAtIndex:indexPath.section];
        
        NSArray *arry1 = [_theSectionDic objectForKey:key];
  
        NSDictionary *dict=[arry1 objectAtIndex:indexPath.row];
        
        [self alert:@"确定转发给：" withMess:[dict objectForKey:@"nickname"] withFid:_uid withRecievedId:[dict objectForKey:@"uid"]];
        
        
    }else{
        
        NSLog(@"myArr=%@",myArr);
        
        
        YH_FriendInfoViewController *friendView=[[YH_FriendInfoViewController alloc] init];
        
        if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
           
            friendView.title=@"详细资料";
            
            NSMutableDictionary *dict=[myArr objectAtIndex:indexPath.row];
            
            friendView.dict=dict;
            
        }else{
            
            friendView.title=@"详细资料";
            
            NSString *key = [_theSortArry objectAtIndex:indexPath.section];
            
            NSArray *arry1 = [_theSectionDic objectForKey:key];
            
            NSMutableDictionary *dict=[arry1 objectAtIndex:indexPath.row];
            
            friendView.dict=dict;
            
        }
        
        friendView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:friendView animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
#pragma mark UISearchDisplayDelegate

//如果搜索文字变化 会执行的委托方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString NS_DEPRECATED_IOS(3_0,8_0);
{
    [self filterContentOfSearchString:searchString];
    return YES;
}

//源字符串 搜索包含或等于的字符串
- (void)filterContentOfSearchString:(NSString *)searchText
{
    myArr=[[ NSMutableArray  alloc] init];
    for (NSString *Str in _theSortArry) {
        
        NSArray *arr=[_theSectionDic objectForKey:Str];
        
        for (NSDictionary *dict in arr)  {
            
            NSString *theCityName =[dict objectForKey:@"nickname"];
            NSRange theSearchRange = NSMakeRange(0, theCityName.length);
            NSRange foundRange = [theCityName rangeOfString:searchText options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch range:theSearchRange];
            if (foundRange.length) {
                
                [myArr addObject:dict];
                
            }
            
        }
        
    }
   
}

#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);
    
    ruqeustButton.enabled=YES;
    ruqeustButton1.enabled=YES;
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    if (COMMANDINT==COMMAND1058) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"array"];
            
            [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
            
            
            [self performSelector:@selector(suessAlert) withObject:self afterDelay:0.5];
            
        }else{
            [self performSelector:@selector(errAciton) withObject:self afterDelay:0.5];
            
            [self performSelector:@selector(returnAction) withObject:self afterDelay:1.5];
        }
        
    }else if (COMMANDINT==COMMAND1052){
        
        if (![[dic objectForKey:@"result"] isKindOfClass:[NSNull class]]) {
            
            _allArr=[[NSMutableArray alloc] initWithArray:[dic objectForKey:@"result"]];
            
            //添加到本地数据
            NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:_allArr];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:encodemenulist forKey:@"myFriarray"];
            
            [defaults synchronize];
            
            //分组
            [self addAZ:_allArr];
            
        }
        
        
    }

    [_theTableView reloadData];
    
}

-(void)returnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)errAciton
{
    [self.view.window showHUDWithText:@"验证码不正确" Type:ShowPhotoNo Enabled:YES];
}

-(void)suessAlert{
    
    YH_FriendViewController *fri=[[YH_FriendViewController alloc] init];
    fri.title=@"朋友圈";
    [self.navigationController pushViewController:fri animated:YES];

}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
 
    ruqeustButton.enabled=NO;
    ruqeustButton1.enabled=NO;

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
        id<ISSContent> publishContent = [ShareSDK content:@"下载衍宏网，注册全民经纪人，周推1套，年赚26万。"
                                           defaultContent:nil
                                                    image:localAttachment
                                                    title:@"邀请您一起用衍宏网，让人脉变财富"
                                                      url:@"http://fir.im/b3nc"
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
        
    }else{
        
        [self logViewAction];
    }
    
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
