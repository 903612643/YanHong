//
//  YH_FriendViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/2/26.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_FriendViewController.h"
#import "UIWindow+YzdHUD.h"
#import "HouseSaleViewController.h"
#import "TravelViewController.h"
#import "MJRefresh.h"
#import "YH_RentHouseDetailViewController.h"

#define THE_COUNT @"5" //每次请求多少条

@interface YH_FriendViewController ()

@end

@implementation YH_FriendViewController

static int HeadImage_Size;

static int CheckButton_Size;

static int BulidingImage_Size;

static int MyHeadImage_Size;

static int InfoLable_Size;

static int theFont;


//到出租和出售界面是设为NO
-(void)viewWillDisappear:(BOOL)animated
{
    isClick=NO;
    

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //隐藏分栏
    self.tabBarController.tabBar.hidden=YES;
    
    array=[[NSMutableArray alloc] init];
    
    addreeArray=[[NSMutableArray alloc] init];
    
    [array removeAllObjects];
    
    [_tableView reloadData];
    
    //   GCD  第六中创建线程方法
    // 创建一个队列
    dispatch_queue_t queue = dispatch_queue_create("YH", nil);
    //    创建异步线程
    dispatch_async(queue, ^{
        
    
        array = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"array"]];
        
        if (array==nil && ![_ctrType isEqualToString:@"1"]) { //是当前界面但本地数据为空，即第一次进入界面时
            
            //默认为第一页
            _thePageNum=1;
            
            //默认第一页
            [self httpData:@"1"];
            
            
        }else{
            
            if ([_ctrType isEqualToString:@"1"]) { //不是当前界面，重新下载数据
                
                //清空数据
                [array removeAllObjects];
                
                //默认第一页
                [self httpData:@"1"];
                
            }else{ //是当前界面但array个数不为空，使用本地数据，改变页数
                
                if (array.count>20) {//本地数据超过20个截取到20个
                    
                    array=(NSMutableArray *)[array subarrayWithRange:NSMakeRange(0, 20)];
                }
                
                if (array.count%[THE_COUNT integerValue]==0) {
                    
                    
                    _thePageNum=array.count/[THE_COUNT integerValue];
                    
                }else{
                    
                    _thePageNum=array.count/[THE_COUNT integerValue]+1;
                    
                }
                NSLog(@"_thePageNum=%ld",(long)_thePageNum);
                
                
                [_tableView reloadData];
                
            }
            
            
        }

    //      回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            isClick=YES;
            
            //隐藏分栏
            self.tabBarController.tabBar.hidden=YES;
            
            _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
            
            if (IS_IPHONE_4_OR_LESS) {  // 4S
                
                HeadImage_Size=150;
                CheckButton_Size=30;
                BulidingImage_Size=130;
                MyHeadImage_Size=50;
                
                InfoLable_Size=20;
                
                theFont=14;
                
            }else if (IS_IPHONE_5) {  // 5, 5S
                
                HeadImage_Size=180;
                CheckButton_Size=30;
                BulidingImage_Size=140;
                MyHeadImage_Size=50;
                
                InfoLable_Size=25;
                
                theFont=14;
                
            }else if (IS_IPHONE_6) {  // 6
                
                HeadImage_Size=180;
                CheckButton_Size=40;
                BulidingImage_Size=180;
                MyHeadImage_Size=60;
                theFont=16;
                
                InfoLable_Size=30;
                
            }else if (IS_IPHONE_6P){
                
                HeadImage_Size=200;
                CheckButton_Size=40;
                BulidingImage_Size=220;
                MyHeadImage_Size=60;
                theFont=18;
                
                InfoLable_Size=30;
            }
            
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, HeadImage_Size)];
            _tableView.tableHeaderView=view;
            
            UIButton *imageView=[[UIButton alloc] init];
            imageView.frame=CGRectMake(0, 0, theWidth, HeadImage_Size);
            [imageView setImage:[UIImage imageNamed:@"friBgm.jpg"] forState:UIControlStateNormal];
            [view addSubview:imageView];
            
            UIView *Imaview=[[UIView alloc] initWithFrame:CGRectMake(theWidth-MyHeadImage_Size-20,HeadImage_Size-MyHeadImage_Size-20, MyHeadImage_Size+5, MyHeadImage_Size+5)];
            Imaview.backgroundColor=[UIColor whiteColor];
            Imaview.layer.cornerRadius=(MyHeadImage_Size+5)/2;
            Imaview.layer.masksToBounds=YES;
            [view addSubview:Imaview];
            
            MyimageView=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth-MyHeadImage_Size-17.4, HeadImage_Size-MyHeadImage_Size-17.6, MyHeadImage_Size, MyHeadImage_Size)];
            MynameLable=[[UILabel alloc] initWithFrame:CGRectMake(0, HeadImage_Size-40-20, theWidth-MyHeadImage_Size-30, 20)];
            
            MynameLable.textAlignment=NSTextAlignmentRight;
            MynameLable.textColor=[UIColor whiteColor];
            MynameLable.font=[UIFont systemFontOfSize:theFont+2];
            MynameLable.backgroundColor=[UIColor clearColor];
            [view addSubview:MynameLable];
            
            //判断是否是从好友详细push,获取头像和姓名
            if ([_ctrType isEqualToString:@"1"]) {
                
                NSString *imageStr=_headStr;
                MynameLable.text=_nickName;
                
                if (imageStr.length!=0) {
                    
                    NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:imageStr];
                    UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
                    MyimageView.image=_decodedImage;
  
                }else{
                    
                    MyimageView.image=[UIImage imageNamed:@"theHead"];
                    
                }
                
                
            }else{
                
                NSString *imagStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"headpicture"];
                
                if (imagStr!=nil) {
                    
                    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:[[NSUserDefaults standardUserDefaults] objectForKey:@"headpicture"]];
                    
                    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
                    
                    MyimageView.image=_decodedImage;
                    
                }else{
                    
                    MyimageView.image=[UIImage imageNamed:@"theHead"];
                }
                
                NSString *nameStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
                
                if (nameStr!=nil) {
                    
                    MynameLable.text=nameStr;
                }


            }
            
            MyimageView.layer.cornerRadius=MyHeadImage_Size/2;
            MyimageView.layer.masksToBounds=YES;
            MyimageView.backgroundColor=[UIColor clearColor];
            [view addSubview:MyimageView];
        
            //返回Item
            self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
            
            if (![_ctrType isEqualToString:@"1"]) {
                
                UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame=CGRectMake(0,0,20,20);
                [button setImage:[UIImage imageNamed:@"headViewPic7"] forState:UIControlStateNormal ];
                [button addTarget:self action:@selector(rightBarButtonItem) forControlEvents: UIControlEventTouchUpInside ];
                UIBarButtonItem *rigItem=[[UIBarButtonItem alloc] initWithCustomView:button];
                self.navigationItem.rightBarButtonItem=rigItem;
                
            }

            isClick=YES;
        

            [self setTheRefresh];
            
            
        });
        
    });
    
}

-(void)rentAction
{
    isClick=YES;
    TravelViewController *sal=[[TravelViewController alloc] init];
    sal.title=@"旅行短租";
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:sal];
    [self presentViewController:navigation animated:YES completion:nil];
    
   
}
-(void)salaAction
{
    isClick=YES;
    
    HouseSaleViewController *sal=[[HouseSaleViewController alloc] init];
    sal.title=@"发布";
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:sal];
    [self presentViewController:navigation animated:YES completion:nil];

}

-(void)popAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)rightBarButtonItem
{
    if(isClick == NO)
    {
        
        for (UIView *subviews in [self.view subviews]) {
            
            if (subviews.tag==101) {
                [subviews removeFromSuperview];
            }
            if (subviews.tag==102) {
                [subviews removeFromSuperview];
            }
        }

        isClick = YES;
        
    }else {
        
        [self thePopView];
        
        isClick = NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)httpData:(NSString *)pageNum
{
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *strJson;
    
    if (![_ctrType isEqualToString:@"1"]) {
        
        //我的朋友圈
        strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1059\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"type\":\"%@\",\"page\":\"%@\",\"count\":\"%@\",\"apptype\":\"2 \"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],@"3",pageNum,THE_COUNT];
    
        
    }else{
        
        //好友朋友圈
        strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1083\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"type\":\"%@\",\"page\":\"%@\",\"count\":\"%@\",\"apptype\":\"2 \"}",dateString,_friendUid,@"3",pageNum,THE_COUNT];
        
    }
    
    httpRequest=[[HttpRequestCalss alloc] init];
    httpRequest.delegate=self;
    [httpRequest httpRequest:strJson];
    
}

static NSString *strIndex;

#pragma mark UITableViewDataSource

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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    

    if (![array isKindOfClass:[NSNull class]] && array.count!=0)
        
    {
        
        return array.count;

    }else{
        
        return 0;
        
    }
    
}
//点击好友头像显示好友数据
-(void)friAction:(UIButton *)sender
{
    
    NSMutableDictionary *dict=array[sender.tag];
    YH_FriendViewController *fri=[[YH_FriendViewController alloc] init];
    fri.ctrType=@"1";
    fri->_thePageNum=1;
    fri.headStr=[dict objectForKey:@"headpicture"];
    fri.nickName=[dict objectForKey:@"fname"];
    fri.friendUid=[dict objectForKey:@"uid"];
    fri.title=[dict objectForKey:@"fname"];
    [self.navigationController pushViewController:fri animated:YES];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellId=@"myCell";
    
    UITableViewCell *myCell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (!myCell) {
        
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        myCell.backgroundColor=[UIColor whiteColor];
        
        myCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        
        if (array.count!=0) {
            
            NSDictionary *dict=[array objectAtIndex:indexPath.row];
            
            
            NSString *theUid=[[NSString alloc] initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
            NSString *allUid=[[NSString alloc] initWithFormat:@"%@",[dict objectForKey:@"uid"]];
            if ([theUid isEqualToString:allUid]) {
                
                //删除发布的房源
                UIButton *deleteButton=[[UIButton alloc] initWithFrame:CGRectMake(theWidth-60, 10, 40, 20)];
                [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
                deleteButton.titleLabel.font=[UIFont systemFontOfSize:13];
                [deleteButton addTarget:self action:@selector(thealertAction:) forControlEvents:UIControlEventTouchUpInside];
                deleteButton.tag=indexPath.row;
                [deleteButton setTitleColor:[UIColor colorWithRed:31/255.0 green:142/255.0 blue:232/255.0 alpha:1] forState:UIControlStateNormal];
                [myCell addSubview:deleteButton];
                
            }
 
            
            UIButton *guestHeadimage=[[UIButton alloc] initWithFrame:CGRectMake(15,15, 40, 40)];
            
            if (![_ctrType isEqualToString:@"1"]) {//如果是朋友圈头像就有事件
                
                [guestHeadimage addTarget:self action:@selector(friAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            guestHeadimage.tag=indexPath.row;
            
            NSString *imagStr=[dict objectForKey:@"headpicture"];
            
            if (imagStr.length!=0) {
                
                NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[dict objectForKey:@"headpicture"]];
                
                UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
                
                [guestHeadimage setImage:_decodedImage forState:UIControlStateNormal];
                
                //guestHeadimage.image=_decodedImage;
                
            }else{
                
                //guestHeadimage.image=[UIImage imageNamed:@"theHead"];
                
                [guestHeadimage setImage:[UIImage imageNamed:@"theHead"] forState:UIControlStateNormal];
                
            }
            
            [myCell addSubview:guestHeadimage];

            
            //转发的走这边，否则发布
            
            if (![[dict objectForKey:@"istranspond"] intValue]==0) {
                
                guestNameLable=[[UILabel alloc] initWithFrame:CGRectMake(65, 10, theWidth-85, 20)];
                guestNameLable.textColor=[UIColor colorWithRed:70/255.0 green:91/255.0 blue:135/255.0 alpha:1];
                guestNameLable.font=[UIFont systemFontOfSize:15];
                guestNameLable.backgroundColor=[UIColor clearColor];
                [myCell addSubview:guestNameLable];
                
                forWardTimeLable=[[UILabel alloc] initWithFrame:CGRectMake(65, 35, 100, 20)];
                forWardTimeLable.text=@"";
                forWardTimeLable.font=[UIFont systemFontOfSize:11];
                forWardTimeLable.alpha=0.4;
                forWardTimeLable.backgroundColor=[UIColor clearColor];
                [myCell addSubview:forWardTimeLable];
                
                forWardsaleTypeLable=[[UILabel alloc] initWithFrame:CGRectMake(160, 35, 85, 20)];
                forWardsaleTypeLable.textColor=[UIColor colorWithRed:31/255.0 green:142/255.0 blue:232/255.0 alpha:1];
                forWardsaleTypeLable.font=[UIFont systemFontOfSize:11];
                forWardsaleTypeLable.backgroundColor=[UIColor clearColor];
                [myCell addSubview:forWardsaleTypeLable];
                
                
                UIView *bgmView=[[UIView alloc] initWithFrame:CGRectMake(65, 55, theWidth-85, 50)];
                bgmView.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:0.8];
                [myCell addSubview:bgmView];
                
                forWardTitleLable=[[UILabel alloc] init];
                forWardTitleLable.font=[UIFont systemFontOfSize:16];
                forWardTitleLable.text=[[NSString alloc] initWithFormat:@"%@%@",[dict objectForKey:@"buildings"],[dict objectForKey:@"housetype"]];
                CGSize size = CGSizeMake(theWidth-85, MAXFLOAT);
                forWardTitleLable.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize = [forWardTitleLable sizeThatFits:size];
                [bgmView addSubview:forWardTitleLable];
                
                guestHouseimage=[[UIImageView alloc] initWithFrame:CGRectMake(5,5, 40, 40)];
                
                NSString *photostr=[dict objectForKey:@"photo1"];
                
                if (photostr.length!=0) {
                    NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[dict objectForKey:@"photo1"]];
                    
                    UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
                    guestHouseimage.image=_decodedImage;

                }
                guestHouseimage.backgroundColor=[UIColor clearColor];
                [bgmView addSubview:guestHouseimage];
                
                isSaleiLable=[[UILabel alloc] init];
                isSaleiLable.frame= CGRectMake(65,115, 60, 23);
                isSaleiLable.textAlignment=NSTextAlignmentCenter;
                isSaleiLable.font=[UIFont systemFontOfSize:14];
                isSaleiLable.layer.cornerRadius=4;
                isSaleiLable.layer.masksToBounds=YES;
                isSaleiLable.textColor=[UIColor whiteColor];
                isSaleiLable.backgroundColor=[UIColor colorWithRed:35/255.0 green:144/255.0 blue:142/255.0 alpha:1];
                [myCell addSubview:isSaleiLable];
                
                forWardButton=[[UIButton alloc] init];
                forWardButton.frame= CGRectMake(theWidth-20-45*3-20,115, 45, 23);
                [forWardButton setImage:[UIImage imageNamed:@"forWardPic"] forState:UIControlStateNormal];
                forWardButton.backgroundColor=[UIColor clearColor];
               //  [myCell addSubview:forWardButton];
                
                goodButton=[[UIButton alloc] init];
                goodButton.frame= CGRectMake(theWidth-20-45*2-10,115, 45, 23);
                [goodButton setImage:[UIImage imageNamed:@"goodPic"] forState:UIControlStateNormal];
                goodButton.backgroundColor=[UIColor clearColor];
               // [myCell addSubview:goodButton];
                
                messButton=[[UIButton alloc] init];
                messButton.frame= CGRectMake(theWidth-20-45,115, 45, 23);
                [messButton setImage:[UIImage imageNamed:@"messPic"] forState:UIControlStateNormal];
                messButton.backgroundColor=[UIColor clearColor];
                // [myCell addSubview:messButton];
                
                pushFriendViewButton=[[UIButton alloc] init];
                pushFriendViewButton.frame=CGRectMake(65, 55, theWidth-85, 50);
                pushFriendViewButton.backgroundColor=[UIColor clearColor];
                pushFriendViewButton.alpha=0.2;
                pushFriendViewButton.tag=indexPath.row;
                [pushFriendViewButton addTarget:self action:@selector(pushActon:) forControlEvents:UIControlEventTouchUpInside];
                [myCell addSubview:pushFriendViewButton];
                
                if (forWardTitleLable.text.length!=0 && guestHouseimage.image==nil) {
                    
                    forWardTitleLable.frame = CGRectMake(5, (50-lableSize.height)/2,theWidth-85, lableSize.height);
                    
                }else if (forWardTitleLable.text.length==0 && guestHouseimage.image!=nil) {
    
                    
                }else if (forWardTitleLable.text.length!=0 && guestHouseimage.image!=nil){
                    
                    forWardTitleLable.frame = CGRectMake(50, (50-lableSize.height)/2,theWidth-85-50, lableSize.height);
                                       
                }else if (forWardTitleLable.text.length==0 && guestHouseimage.image==nil){
            
                }
                
                if ([[dict objectForKey:@"disstate"] isEqualToString:@"1"]) {
                    
                    
                    if ([[dict objectForKey:@"dealstate"] isEqualToString:@"1"]) {
                        
                        isSaleiLable.text=@"进行中";
                        isSaleiLable.backgroundColor=[UIColor colorWithRed:35/255.0 green:144/255.0 blue:142/255.0 alpha:1];
                        
                        
                    }else if ([[dict objectForKey:@"dealstate"] isEqualToString:@"2"]){
                        
                        isSaleiLable.text=@"已成交";
                        isSaleiLable.backgroundColor=[UIColor colorWithRed:249/255.0 green:61/255.0 blue:8/255.0 alpha:1];
                        
                    }
                    
                    
                    
                }else if ([[dict objectForKey:@"disstate"] isEqualToString:@"2"]){
                    
                    isSaleiLable.text=@"已失效";
                    isSaleiLable.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    
                    
                }
                
                if ([[dict objectForKey:@"tradetype"] isEqualToString:@"2"]) {
                    
                    guestNameLable.text=[dict objectForKey:@"fname"];
                    forWardsaleTypeLable.text=@"周租月租";
                    forWardTimeLable.text=[[NSString alloc] initWithFormat:@"%@ 来自",[dict objectForKey:@"createtime"]];
                    salemoneyLable.text=[[NSString alloc] initWithFormat:@"¥%@元/月",[dict objectForKey:@"price"] ];
                    
                    
                }else{
                    
                    guestNameLable.text=[dict objectForKey:@"fname"];
                    forWardsaleTypeLable.text=@"房屋买卖";
                    forWardTimeLable.text=[[NSString alloc] initWithFormat:@"%@ 来自",[dict objectForKey:@"createtime"]];
                    salemoneyLable.text=[[NSString alloc] initWithFormat:@"¥%@万/套",[dict objectForKey:@"price"] ];
                    
                
                tishilable.text=@"";
                    
               }
                
                
            }else{

                guestNameLable=[[UILabel alloc] initWithFrame:CGRectMake(65, 10, theWidth-85, 20)];
                guestNameLable.textColor=[UIColor colorWithRed:70/255.0 green:91/255.0 blue:135/255.0 alpha:1];
                guestNameLable.font=[UIFont systemFontOfSize:15];
                guestNameLable.backgroundColor=[UIColor clearColor];
                [myCell addSubview:guestNameLable];
                
                forWardTimeLable=[[UILabel alloc] initWithFrame:CGRectMake(65, 35, 100, 20)];
                forWardTimeLable.text=@"";
                forWardTimeLable.font=[UIFont systemFontOfSize:11];
                forWardTimeLable.alpha=0.4;
                forWardTimeLable.backgroundColor=[UIColor clearColor];
                [myCell addSubview:forWardTimeLable];
                
                forWardsaleTypeLable=[[UILabel alloc] initWithFrame:CGRectMake(160, 35, 85, 20)];
                forWardsaleTypeLable.textColor=[UIColor colorWithRed:31/255.0 green:142/255.0 blue:232/255.0 alpha:1];
                forWardsaleTypeLable.font=[UIFont systemFontOfSize:11];
                forWardsaleTypeLable.backgroundColor=[UIColor clearColor];
                [myCell addSubview:forWardsaleTypeLable];
                
                forWardTitleLable=[[UILabel alloc] initWithFrame:CGRectMake(65, 55, 85, 20)];
                forWardTitleLable.font=[UIFont systemFontOfSize:13];
                
                forWardTitleLable.text=[[NSString alloc] initWithFormat:@"%@%@",[dict objectForKey:@"buildings"],[dict objectForKey:@"housetype"]];
                
                
                forWardTitleLable.backgroundColor=[UIColor clearColor];
                CGSize size = CGSizeMake(theWidth-85, MAXFLOAT);
                forWardTitleLable.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize = [forWardTitleLable sizeThatFits:size];
                forWardTitleLable.frame = CGRectMake(65, 55,theWidth-85, lableSize.height);
                
                [myCell addSubview:forWardTitleLable];
                
                salemoneyLable=[[UILabel alloc] initWithFrame:CGRectMake(70, lableSize.height+55, 100, 20)];
                salemoneyLable.text=@"";
                salemoneyLable.textColor=PublieCorlor;
                salemoneyLable.font=[UIFont systemFontOfSize:13];
                salemoneyLable.backgroundColor=[UIColor clearColor];
                [myCell addSubview:salemoneyLable];
                
                guestHouseimage=[[UIImageView alloc] initWithFrame:CGRectMake(65,lableSize.height+55+20+5, theWidth-85, 150)];
                
                NSString *photostr=[dict objectForKey:@"photo1"];
                
                if (photostr.length!=0) {
                    
                    NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[dict objectForKey:@"photo1"]];
                    UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
                    
                    guestHouseimage.image=_decodedImage;

                    

                }
                
                guestHouseimage.backgroundColor=[UIColor clearColor];
                [myCell addSubview:guestHouseimage];
                
                isSaleiLable=[[UILabel alloc] init];
                //isSaleiLable.text=@"进行中";
                isSaleiLable.textAlignment=NSTextAlignmentCenter;
                isSaleiLable.font=[UIFont systemFontOfSize:14];
                isSaleiLable.layer.cornerRadius=4;
                isSaleiLable.layer.masksToBounds=YES;
                isSaleiLable.textColor=[UIColor whiteColor];
                isSaleiLable.backgroundColor=[UIColor colorWithRed:35/255.0 green:144/255.0 blue:142/255.0 alpha:1];
                [myCell addSubview:isSaleiLable];
                
                forWardButton=[[UIButton alloc] init];
                [forWardButton setImage:[UIImage imageNamed:@"forWardPic"] forState:UIControlStateNormal];
                forWardButton.backgroundColor=[UIColor clearColor];
               // [myCell addSubview:forWardButton];
                
                goodButton=[[UIButton alloc] init];
                [goodButton setImage:[UIImage imageNamed:@"goodPic"] forState:UIControlStateNormal];
                goodButton.backgroundColor=[UIColor clearColor];
               // [myCell addSubview:goodButton];
                
                messButton=[[UIButton alloc] init];
                [messButton setImage:[UIImage imageNamed:@"messPic"] forState:UIControlStateNormal];
                messButton.backgroundColor=[UIColor clearColor];
               // [myCell addSubview:messButton];
                
                pushFriendViewButton=[[UIButton alloc] init];
                pushFriendViewButton.backgroundColor=[UIColor clearColor];
                pushFriendViewButton.alpha=0.2;
                pushFriendViewButton.tag=indexPath.row;
                [pushFriendViewButton addTarget:self action:@selector(pushActon:) forControlEvents:UIControlEventTouchUpInside];
                [myCell addSubview:pushFriendViewButton];
                
                if (forWardTitleLable.text.length!=0 && guestHouseimage.image==nil) {
                    
                    isSaleiLable.frame= CGRectMake(65,lableSize.height+55+20+5, 60, 23);
                    forWardButton.frame= CGRectMake((theWidth-20)-45*3-20,lableSize.height+55+20+5, 45, 23);
                    goodButton.frame= CGRectMake(theWidth-20-45*2-10,lableSize.height+55+20+5, 45, 23);
                    messButton.frame= CGRectMake(theWidth-20-45,lableSize.height+55+20+5, 45, 23);
                    
                    pushFriendViewButton.frame=CGRectMake(65, 55 , theWidth-85, (lableSize.height+20));
                    
                }else if (forWardTitleLable.text.length==0 && guestHouseimage.image!=nil) {
                    
                    isSaleiLable.frame= CGRectMake(65,(lableSize.height+55+20)+150+10+5, 60, 23);
                    
                    forWardButton.frame= CGRectMake(theWidth-20-45*3-20,(lableSize.height+55+20)+150+10+5, 45, 23);
                    
                    goodButton.frame= CGRectMake(theWidth-20-45*2-10,(lableSize.height+55+20)+150+10+5, 45, 23);
                    
                    messButton.frame= CGRectMake(theWidth-20-45,(lableSize.height+55+20)+150+10+5, 45, 23);
                    
                    pushFriendViewButton.frame=CGRectMake(65, 55 , theWidth-85, (lableSize.height+20)+150+5);
                    
                }else if (forWardTitleLable.text.length!=0 && guestHouseimage.image!=nil){
                    
                    isSaleiLable.frame= CGRectMake(65,(lableSize.height+55+20)+150+10+5, 60, 23);
                    forWardButton.frame= CGRectMake(theWidth-20-45*3-20,(lableSize.height+55+20)+150+10+5, 45, 23);
                    goodButton.frame= CGRectMake(theWidth-20-45*2-10,(lableSize.height+55+20)+150+10+5, 45, 23);
                    messButton.frame= CGRectMake(theWidth-20-45,(lableSize.height+55+20)+150+10+5, 45, 23);
                    
                    pushFriendViewButton.frame=CGRectMake(65, 55 , theWidth-85, (lableSize.height+20)+150+5);
                    
                }else if (forWardTitleLable.text.length==0 && guestHouseimage.image==nil){
                    
                    isSaleiLable.frame= CGRectMake(65,55+20+5, 60, 23);
                    
                    forWardButton.frame= CGRectMake(theWidth-20-45*3-20,55+20+5, 45, 23);
                    goodButton.frame= CGRectMake(theWidth-20-45*2-10,55+20+5, 45, 23);
                    messButton.frame= CGRectMake(theWidth-20-45,55+20+5, 45, 23);
                    
                    pushFriendViewButton.frame=CGRectMake(65, 55 , theWidth-85, (lableSize.height+20));
                    
                }
                
                bulidingLableType.text=[[NSString alloc] initWithFormat:@"%@%@",[dict objectForKey:@"buildings"],[dict objectForKey:@"housetype"]];
                
                if ([[dict objectForKey:@"disstate"] isEqualToString:@"1"]) {
                    
                    
                    if ([[dict objectForKey:@"dealstate"] isEqualToString:@"1"]) {
                        
                        isSaleiLable.text=@"进行中";
                        isSaleiLable.backgroundColor=[UIColor colorWithRed:35/255.0 green:144/255.0 blue:142/255.0 alpha:1];
                        
                        
                    }else if ([[dict objectForKey:@"dealstate"] isEqualToString:@"2"]){
                        
                        isSaleiLable.text=@"已成交";
                        isSaleiLable.backgroundColor=[UIColor colorWithRed:249/255.0 green:61/255.0 blue:8/255.0 alpha:1];
                        
                    }
                    
                    
                }else if ([[dict objectForKey:@"disstate"] isEqualToString:@"2"]){
                    
                    isSaleiLable.text=@"已失效";
                    isSaleiLable.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    
                    
                }
                
                if ([[dict objectForKey:@"tradetype"] isEqualToString:@"2"]) {
                    
                    guestNameLable.text=[dict objectForKey:@"fname"];
                    forWardsaleTypeLable.text=@"周租月租";
                    forWardTimeLable.text=[[NSString alloc] initWithFormat:@"%@ 来自",[dict objectForKey:@"createtime"]];
                    salemoneyLable.text=[[NSString alloc] initWithFormat:@"¥%@元/月",[dict objectForKey:@"price"] ];
                    
                    
                }else{
                    
                    guestNameLable.text=[dict objectForKey:@"fname"];
                    forWardsaleTypeLable.text=@"房屋买卖";
                    forWardTimeLable.text=[[NSString alloc] initWithFormat:@"%@ 来自",[dict objectForKey:@"createtime"]];
                    salemoneyLable.text=[[NSString alloc] initWithFormat:@"¥%@万/套",[dict objectForKey:@"price"] ];
                    
                }
                
                tishilable.text=@"";

            }
            
        }
            
    }
    
    return myCell;
    
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  
    NSDictionary *dict=[array objectAtIndex:indexPath.row];
    
    if (![[dict objectForKey:@"istranspond"] intValue]==0) {
        
        return 155;
        
    }else{
        
        if (forWardTitleLable.text.length==0 && guestHouseimage.image!=nil) {
            
            return 280;
            
        }else{
            
            if (guestHouseimage.image==nil) {
                
                guestHouseimage.backgroundColor=[UIColor clearColor];
                
                CGSize size = CGSizeMake(theWidth-85, MAXFLOAT);
                forWardTitleLable.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize = [forWardTitleLable sizeThatFits:size];
                
                return 125+lableSize.height;
                
                
            }else{
                
                CGSize size = CGSizeMake(theWidth-85, MAXFLOAT);
                forWardTitleLable.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize = [forWardTitleLable sizeThatFits:size];
                
                return 280+lableSize.height;
                
            }
            
        }

    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.001;
}

#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSMutableDictionary alloc] initWithDictionary:json];
    
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
    
    
    //我的朋友圈
    if (COMMANDINT==COMMAND1060) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            
            NSLog(@"_thePageNum=%ld",(long)_thePageNum);
            
            if (_thePageNum!=1) {
                
                //得到本地数组
                array = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"array"]];
                
                [array addObjectsFromArray:[dic objectForKey:@"result"]];
       
                
            }else{
                //添加到本地数据
                array=[dic objectForKey:@"result"];
                
            }
     
            if (array.count==0||array==nil) {
            
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, theHeight/2-50, theWidth, 30)];
                lable.alpha=0.4;
                lable.tag=104;
                lable.textAlignment=NSTextAlignmentCenter;
                lable.font=[UIFont systemFontOfSize:25];
                lable.text=@"无结果";
                _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
                [_tableView addSubview:lable];


            }else{
                
                //添加到本地数据
                NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:array];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setObject:encodemenulist forKey:@"array"];
                
                [defaults synchronize];
                
                //更新表数据
                array=(NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:encodemenulist];

                
                for (UIView *subView in [_tableView subviews]) {
                    
                    if (subView.tag==104) {
                        
                        [subView removeFromSuperview];
                    }
                }
                
                
            }

        }else{
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
            
        }
        
    }else if (COMMANDINT==COMMAND1084){       //好友的朋友圈
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
          
            if (_thePageNum!=1) {
                
             
                [array addObjectsFromArray:[dic objectForKey:@"result"]];

                
            }else{
                
                array=[dic objectForKey:@"result"];
                
            }

            if (array.count==0||array==nil) {
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, theHeight/2-50, theWidth, 30)];
                lable.alpha=0.4;
                lable.tag=104;
                lable.textAlignment=NSTextAlignmentCenter;
                lable.font=[UIFont systemFontOfSize:25];
                lable.text=@"无结果";
                _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
                [_tableView addSubview:lable];
 
            }else{
                
                for (UIView *subView in [_tableView subviews]) {
                    
                    if (subView.tag==104) {
                        
                        [subView removeFromSuperview];
                    }
                }
            }
            
        }else if (COMMANDINT==COMMAND1110){
            
             if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
                 
             }else{
                 
                [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
             }
        }
        else{
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
        }
        
        
    }

    [_tableView reloadData];
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    [self performSelector:@selector(dismissMJAction) withObject:self afterDelay:3];
    
}

-(void)pushActon:(UIButton *)sender
{

        YH_RentHouseDetailViewController *houseInfo=[[YH_RentHouseDetailViewController alloc] init];
        
        houseInfo.hidesBottomBarWhenPushed=YES;
    
        NSMutableDictionary *dict=array[sender.tag];
    
        if ([[dict objectForKey:@"tradetype"] isEqualToString:@"2"]) {
            
            houseInfo.tradetypeIs2=dict;
            houseInfo.ctrType=@"2";
            
        }else if ([[dict objectForKey:@"tradetype"] isEqualToString:@"1"]){
            
            houseInfo.ctrType=@"1";
            houseInfo.tradetypeIs2=dict;

        }

        [self.navigationController pushViewController:houseInfo animated:YES];
    
}

-(void)thePopView
{
    
    UIButton *_theButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
    [_theButton addTarget:self action:@selector(rightBarButtonItem) forControlEvents:UIControlEventTouchUpInside];
    _theButton.backgroundColor=[UIColor blackColor];
    _theButton.alpha=0.3;
    _theButton.tag=102;
    [_theButton bringSubviewToFront:self.view];
    [self.view addSubview:_theButton];
    
    popview=[[UIView alloc] initWithFrame:CGRectMake(theWidth-120-20, 0, 120, 80)];
    popview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    popview.tag=101;
    [popview bringSubviewToFront:_theButton];
    [self.view addSubview:popview];
    
    UIButton *addsaleButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, (80-1)/2)];
    addsaleButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
    [addsaleButton setTitle:@"发布房屋买卖" forState:UIControlStateNormal];
    addsaleButton.alpha=0.8;
    [addsaleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addsaleButton addTarget:self action:@selector(salaAction) forControlEvents:UIControlEventTouchUpInside];
    [popview addSubview:addsaleButton];
    
    UIView *lineview=[[UIView alloc] initWithFrame:CGRectMake(0, 41, 120, 1)];
    lineview.alpha=0.4;
    lineview.backgroundColor=[UIColor grayColor];
    [popview addSubview:lineview];
    
    UIButton *addrentButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 41, 120, (80-1)/2)];
    addrentButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
    addrentButton.alpha=0.8;
    [addrentButton setTitle:@"发布周租月租" forState:UIControlStateNormal];
    [addrentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addrentButton addTarget:self action:@selector(rentAction) forControlEvents:UIControlEventTouchUpInside];
    [popview addSubview:addrentButton];

}


-(void)setTheRefresh
{
    [_tableView addHeaderWithTarget:self action:@selector(theHeadAction)];
    
    [_tableView addFooterWithTarget:self action:@selector(theFooterAction)];
    
    
}
-(void)theHeadAction
{
    _thePageNum=1;
    NSLog(@"_thePageNum=%ld",(long)_thePageNum);
    [self httpData:[[NSString alloc] initWithFormat:@"%ld",(long)_thePageNum]];
    
}
-(void)theFooterAction
{
    
  _thePageNum=_thePageNum+1;
    NSLog(@"_thePageNum=%ld",(long)_thePageNum);
   [self httpData:[[NSString alloc] initWithFormat:@"%ld",(long)_thePageNum]];
    
}
//停止加载..
-(void)dismissMJAction
{
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
}

-(void)thealertAction:(UIButton *)sender{
    
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSMutableDictionary *dict=array[sender.tag];
        
       
        //当前时间
        NSDate *date=[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSS";
        NSString *dateString = [formatter stringFromDate:date];
        
            //我的朋友圈
        NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1109\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"infoid\":\"%@\",\"publishtype\":\"1\",\"hid\":\"%@\",\"apptype\":\"2 \"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[dict objectForKey:@"infoid"],[dict objectForKey:@"id"]];
    

        httpRequest=[[HttpRequestCalss alloc] init];
        httpRequest.delegate=self;
        [httpRequest httpRequest:strJson];
        
        [array removeObjectAtIndex:sender.tag];
        
        //重新添加到本地数据本地数据
        NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:array];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:encodemenulist forKey:@"array"];
        
        [defaults synchronize];
        
        [_tableView reloadData];
        

    }];
    //    把事件添加到控制器
    [alertViewCtr addAction:cancelAction];
    [alertViewCtr addAction:sureAction];
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^{
        
    }];
    
}


@end
