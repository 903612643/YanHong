//
//  HomeViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/1.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//
#import "HomeViewController.h"
#import "WebViewController.h"
#import "HotHouseViewController.h"
#import "LoginViewController.h"
#import "SuggestViewController.h"
#import "ShengHuoJiaoFei.h"
#import "HouseSaleViewController.h"
#import "TravelViewController.h"
#import "UIWindow+YzdHUD.h"
#import "YH_MyGuestViewController.h"
#import "MyInfoViewController.h"
#import "YH_WalletViewController.h"
#import "YH_allPersonViewController.h"
#import "YH_MakeViewController.h"
#import "YH_SaleHouseViewController.h"
#import "YH_RentHouseViewController.h"

static int   Scroll_Size  = 180;     //srcollView大小

static int TheButton_Size_WH;
static int ImageView_Size_HW;

@interface HomeViewController ()

@end

@implementation HomeViewController

//网络监控
-(void)netWorkState
{
    //    AFNetworkReachabilityStatusUnknown          = -1, 未知
    //    AFNetworkReachabilityStatusNotReachable     = 0,  无连接
    //    AFNetworkReachabilityStatusReachableViaWWAN = 1,  3G 4G
    //    AFNetworkReachabilityStatusReachableViaWiFi = 2,  WIFI
    //    检测网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //    网络变化
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"status = %ld",(long)status);
        
        theindex=status;
        
        if (status==0 || status==-1) {
            
            [self.view.window showHUDWithText:@"网络异常" Type:ShowPhotoNo Enabled:YES];
    
            [self performSelector:@selector(afterAction) withObject:self afterDelay:2.0];
        }else{
            

        }
        
        
        
    }];
}
-(void)walletAction
{
    //判断是否登陆，由登陆状态判断启动页面
 
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        YH_WalletViewController *log=[[YH_WalletViewController alloc] init];

        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:log];
        log.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStylePlain target:self action:@selector(dismissHomeAction)];
        
        [self presentViewController:navigation animated:YES completion:nil];
        
    }else if([userDefault objectForKey:@"uid"]==nil){
        
        [self toLogViewCtr];
    }

}

-(void)MakeAction
{
    //判断是否登陆，由登陆状态判断启动页面
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        YH_MakeViewController *makeView=[[YH_MakeViewController alloc] init];
        
        UINavigationController *nac=[[UINavigationController alloc] initWithRootViewController:makeView];
        [self presentViewController:nac animated:YES completion:^{
            
        }];
    }else if([userDefault objectForKey:@"uid"]==nil){
        
        [self toLogViewCtr];
    }

    
    
    
}
//改变状态栏的字体颜色为白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//软件国际化
-(id)initwithTitle:(NSString *)title color:(UIColor *)color
{
    if ([super init]) {
        UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        navTitleLabel.font = [UIFont systemFontOfSize:18];
        navTitleLabel.textColor = color;
        navTitleLabel.textAlignment = NSTextAlignmentCenter;
        navTitleLabel.adjustsFontSizeToFitWidth = true;
        navTitleLabel.text = title;
        self.navigationItem.titleView = navTitleLabel;
    }
    return self;
}

static int theFont;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tabBarController.tabBar.hidden=NO;
    
    
    
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        Scroll_Size =150;
        theFont=14;
        TheButton_Size_WH=80;
        ImageView_Size_HW=25;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        Scroll_Size =190;
        theFont=14;
        TheButton_Size_WH=90;
        ImageView_Size_HW=25;
        
    }else if (IS_IPHONE_6) {  // 6
        
         Scroll_Size =240;
        theFont=16;
        
        TheButton_Size_WH=100;
        ImageView_Size_HW=30;
        
    }else if (IS_IPHONE_6P){
        
        Scroll_Size =280;
        theFont=16;
        TheButton_Size_WH=100;
        ImageView_Size_HW=30;
    }
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1041\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"apptype\":\"2\"}",dateString];
    httpRequest=[[HttpRequestCalss alloc] init];
    httpRequest.delegate=self;
    [httpRequest httpRequest:strJson1];

   
    
    [self createHeadView];
    
    [self createFootView];


     [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}

-(void)createHeadView
{
    
    _view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, Scroll_Size+20)];
    _view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_view];
    
    
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth, Scroll_Size+20)];
    //设置内容大小
    _scrollView.contentSize=CGSizeMake(theWidth*3, 0);
    //设置是否分页
    _scrollView.pagingEnabled=YES;
    [_view addSubview:_scrollView];
    _scrollView.delegate=self;
    
    
    for (int i=0; i<3; i++) {
        //加入imange
        UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth*i, 0, theWidth, Scroll_Size+20)];
        NSString *imageStr=[NSString stringWithFormat:@"banner%d.jpg",i+1];
        imageView1.image=[UIImage imageNamed:imageStr];
        [_scrollView addSubview:imageView1];
    }
    
   // UIButton *theImageView1=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-45*4)/5, (Scroll_Size+20)-72, 45, 45)];
    UIButton *theImageView1=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-45*3)/4, (Scroll_Size+20)-72, 45, 45)];
    [theImageView1 setImage:[UIImage imageNamed:@"headViewPic1"] forState:UIControlStateNormal];
    theImageView1.layer.cornerRadius=6;
    theImageView1.layer.masksToBounds=YES;
    theImageView1.backgroundColor=[UIColor clearColor];
    [theImageView1 addTarget:self action:@selector(Aciton1) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:theImageView1];
    
    //UIButton *theImageView2=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-45*4)/5*2+45, (Scroll_Size+20)-72, 45, 45)];
    UIButton *theImageView2=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-45*3)/4*2+45, (Scroll_Size+20)-72, 45, 45)];
    [theImageView2 setImage:[UIImage imageNamed:@"headViewPic2"] forState:UIControlStateNormal];
    [theImageView2 addTarget:self action:@selector(MakeAction) forControlEvents:UIControlEventTouchUpInside];
    theImageView2.layer.cornerRadius=6;
    theImageView2.layer.masksToBounds=YES;
    theImageView2.backgroundColor=[UIColor clearColor];
    [_view addSubview:theImageView2];
    
    
    UIButton *theImageView3=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-45*4)/5*3+45*2, (Scroll_Size+20)-72, 45, 45)];
    [theImageView3 setImage:[UIImage imageNamed:@"headViewPic3"] forState:UIControlStateNormal];
    theImageView3.layer.cornerRadius=6;
    theImageView3.layer.masksToBounds=YES;
    theImageView3.backgroundColor=[UIColor clearColor];
   // [_view addSubview:theImageView3];
    
    
    
    //UIButton *theImageView4=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-45*4)/5*4+45*3, (Scroll_Size+20)-72, 45, 45)];
    UIButton *theImageView4=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-45*3)/4*3+45*2, (Scroll_Size+20)-72, 45, 45)];
    [theImageView4 setImage:[UIImage imageNamed:@"headViewPic4"] forState:UIControlStateNormal];
    theImageView4.layer.cornerRadius=6;
    theImageView4.layer.masksToBounds=YES;
    [theImageView4 addTarget:self action:@selector(walletAction) forControlEvents:UIControlEventTouchUpInside];
    theImageView4.backgroundColor=[UIColor clearColor];
    [_view addSubview:theImageView4];
    
    UIButton *theImageView6=[[UIButton alloc] initWithFrame:CGRectMake(theWidth-15-30, 28, 28, 25)];
    [theImageView6 setImage:[UIImage imageNamed:@"headViewPic6"] forState:UIControlStateNormal];
    [theImageView6 addTarget:self action:@selector(MyGuestAction) forControlEvents:UIControlEventTouchUpInside];
    theImageView6.backgroundColor=[UIColor clearColor];
    [_view addSubview:theImageView6];
    
    UIButton *theImageView7=[[UIButton alloc] initWithFrame:CGRectMake(theWidth-15*2-30*2, 30, 25, 25)];
    [theImageView7 setImage:[UIImage imageNamed:@"headViewPic5"] forState:UIControlStateNormal];
    [theImageView7 addTarget:self action:@selector(myInfoAction) forControlEvents:UIControlEventTouchUpInside];
    theImageView7.backgroundColor=[UIColor clearColor];
    [_view addSubview:theImageView7];
    
    
    NSArray *thearr=@[@"地产直销",@"赚房差",@"钱包"];
    
    for (int i=0; i<3; i++) {
        
        UILabel *lable=[[UILabel alloc] init];
        
        if (i==0) {
            
            lable.frame=CGRectMake((theWidth-58*3)/4*(i+1)+58*i+3, (Scroll_Size+20)-28, 58, 20);
            
        }else if (i==2){
            
            lable.frame=CGRectMake((theWidth-58*3)/4*(i+1)+58*i-4, (Scroll_Size+20)-28, 58, 20);
        }else{
            
            lable.frame=CGRectMake((theWidth-58*3)/4*(i+1)+58*i, (Scroll_Size+20)-28, 58, 20);
            
            
        }
        lable.backgroundColor=[UIColor clearColor];
        lable.font=[UIFont systemFontOfSize:theFont-2];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.textColor=[UIColor whiteColor];
        lable.text=thearr[i];
        
        [_view addSubview:lable];
        
    }
}
-(void)createFootView
{
    UIView *bigView=[[UIView alloc] initWithFrame:CGRectMake(0, Scroll_Size+20, theWidth, theHeight-(Scroll_Size+70))];
    bigView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bigView];
    
    
    UIButton *theButton1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //创建按钮
    theButton1.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4, TheButton_Size_WH, TheButton_Size_WH);
    theButton1.backgroundColor=[UIColor clearColor];
    [theButton1 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal] ;
    [theButton1 setTitle:@"" forState:UIControlStateNormal];
    theButton1.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [theButton1 addTarget:self action:@selector(Aciton0) forControlEvents:UIControlEventTouchUpInside ];
    //文字位置
    theButton1.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [bigView addSubview:theButton1];
    
    UIButton *theButton2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //创建按钮
    theButton2.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4, TheButton_Size_WH, TheButton_Size_WH);
    theButton2.backgroundColor=[UIColor clearColor];
    [theButton2 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal] ;
    [theButton2 setTitle:@"" forState:UIControlStateNormal];
    theButton2.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [theButton2 addTarget:self action:@selector(Aciton2) forControlEvents:UIControlEventTouchUpInside ];
    //文字位置
    theButton2.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [bigView addSubview:theButton2];
    
    UIButton *theButton3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //创建按钮
    theButton3.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4*3+TheButton_Size_WH*2, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4, TheButton_Size_WH, TheButton_Size_WH);
    theButton3.backgroundColor=[UIColor clearColor];
    [theButton3 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal] ;
    [theButton3 setTitle:@"" forState:UIControlStateNormal];
    theButton3.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [theButton3 addTarget:self action:@selector(Aciton3) forControlEvents:UIControlEventTouchUpInside ];
    //文字位置
    theButton3.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [bigView addSubview:theButton3];
    
    UIButton *theButton4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //创建按钮
    theButton4.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, TheButton_Size_WH, TheButton_Size_WH);
    theButton4.backgroundColor=[UIColor clearColor];
    [theButton4 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal] ;
    [theButton4 setTitle:@"" forState:UIControlStateNormal];
    theButton4.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [theButton4 addTarget:self action:@selector(Aciton4) forControlEvents:UIControlEventTouchUpInside ];
    //文字位置
    theButton4.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
   // [bigView addSubview:theButton4];
    
    UIButton *theButton5=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //创建按钮
    //theButton5.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, TheButton_Size_WH, TheButton_Size_WH);
    theButton5.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, TheButton_Size_WH, TheButton_Size_WH);
    theButton5.backgroundColor=[UIColor clearColor];
    [theButton5 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal] ;
    [theButton5 setTitle:@"" forState:UIControlStateNormal];
    theButton5.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [theButton5 addTarget:self action:@selector(Aciton5) forControlEvents:UIControlEventTouchUpInside ];
    //文字位置
    theButton5.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [bigView addSubview:theButton5];
    
    UIButton *theButton6=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //创建按钮
    theButton6.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4*3+TheButton_Size_WH*2, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, TheButton_Size_WH, TheButton_Size_WH);
    theButton6.backgroundColor=[UIColor clearColor];
    [theButton6 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal] ;
    [theButton6 setTitle:@"" forState:UIControlStateNormal];
    theButton6.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [theButton6 addTarget:self action:@selector(Aciton6) forControlEvents:UIControlEventTouchUpInside ];
    //文字位置
    theButton6.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    //[bigView addSubview:theButton6];
    
    UIButton *theButton7=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //创建按钮
   // theButton7.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*3+TheButton_Size_WH*2, TheButton_Size_WH, TheButton_Size_WH);
    theButton7.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, TheButton_Size_WH, TheButton_Size_WH);
    theButton7.backgroundColor=[UIColor clearColor];
    [theButton7 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal] ;
    [theButton7 setTitle:@"" forState:UIControlStateNormal];
    theButton7.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [theButton7 addTarget:self action:@selector(Aciton7) forControlEvents:UIControlEventTouchUpInside ];
    //文字位置
    theButton7.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [bigView addSubview:theButton7];
    
    UIButton *theButton8=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //创建按钮
    //theButton8.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*3+TheButton_Size_WH*2, TheButton_Size_WH, TheButton_Size_WH);
    theButton8.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4*3+TheButton_Size_WH*2, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*2+TheButton_Size_WH, TheButton_Size_WH, TheButton_Size_WH);
    theButton8.backgroundColor=[UIColor clearColor];
    [theButton8 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal] ;
    [theButton8 setTitle:@"" forState:UIControlStateNormal];
    theButton8.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [theButton8 addTarget:self action:@selector(Aciton8) forControlEvents:UIControlEventTouchUpInside ];
    //文字位置
    theButton8.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [bigView addSubview:theButton8];
    
    UIButton *theButton9=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //创建按钮
    //theButton9.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4*3+TheButton_Size_WH*2, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*3+TheButton_Size_WH*2, TheButton_Size_WH, TheButton_Size_WH);
    theButton9.frame= CGRectMake((theWidth-TheButton_Size_WH*3)/4, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*3+TheButton_Size_WH*2, TheButton_Size_WH, TheButton_Size_WH);
    theButton9.backgroundColor=[UIColor clearColor];
    [theButton9 setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal] ;
    [theButton9 setTitle:@"" forState:UIControlStateNormal];
    theButton9.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [theButton9 addTarget:self action:@selector(Aciton9) forControlEvents:UIControlEventTouchUpInside ];
    //文字位置
    theButton9.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [bigView addSubview:theButton9];
    
    //加载数据
    _array=@[@"全民经纪人",@"我要推荐",@"房屋出售",@"生活缴费",@"旅行短租",@"业主圈",@"专题活动"];
    
    for (int i=0; i<_array.count; i++) {
        
        UIImageView *theImageView=[[UIImageView alloc] init];
        UILabel *theLable=[[UILabel alloc] init];
        theLable.textAlignment=NSTextAlignmentCenter;
        theLable.font=[UIFont systemFontOfSize:theFont-2];
        theLable.alpha=0.6;
        
        
        if (i<3) {
            
            theImageView.frame=CGRectMake((theWidth-TheButton_Size_WH*3)/4*(i+1)+TheButton_Size_WH*i+(TheButton_Size_WH-30)/2, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4+(TheButton_Size_WH-ImageView_Size_HW)/2-10, ImageView_Size_HW, ImageView_Size_HW);
            [theImageView bringSubviewToFront:bigView];
            theImageView.backgroundColor=[UIColor whiteColor];
            [bigView addSubview:theImageView];
            
            theLable.frame=CGRectMake((theWidth-TheButton_Size_WH*3)/4*(i+1)+TheButton_Size_WH*i+(TheButton_Size_WH-80)/2, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4+(TheButton_Size_WH-30)/2-10+30, 80, 30);
            theLable.backgroundColor=[UIColor whiteColor];
            [bigView addSubview:theLable];
            
            if (i!=2) {
                
                if (i==0) {
                    
                    UIView *theView=[[UIView alloc] initWithFrame:CGRectMake(0, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*(i+1)+TheButton_Size_WH*(i+1)+((theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4)/2, theWidth, 0.8)];
                    theView.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    
                    [bigView addSubview:theView];
                    
                    UIView *theView1=[[UIView alloc] initWithFrame:CGRectMake((theWidth-TheButton_Size_WH*3)/4*(i+1)+TheButton_Size_WH*(i+1)+((theWidth-TheButton_Size_WH*3)/4)/2, 0, 0.77, theHeight-(Scroll_Size+70))];
                    theView1.alpha=0.6;
                    theView1.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    
                    [bigView addSubview:theView1];


                }else{
                    
                    UIView *theView=[[UIView alloc] initWithFrame:CGRectMake(0, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*(i+1)+TheButton_Size_WH*(i+1)+((theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4)/2, theWidth, 0.8)];
                    theView.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    
                    [bigView addSubview:theView];
                    
                    UIView *theView1=[[UIView alloc] initWithFrame:CGRectMake((theWidth-TheButton_Size_WH*3)/4*(i+1)+TheButton_Size_WH*(i+1)+((theWidth-TheButton_Size_WH*3)/4)/2, 0, 1, theHeight-(Scroll_Size+70))];
                    theView1.backgroundColor=[UIColor groupTableViewBackgroundColor];
                    theView1.alpha=0.5;
                    [bigView addSubview:theView1];
                }
                
            }
            
            
            
            
        }else if(i>2 && i<6){
            
            theImageView.frame=CGRectMake((theWidth-TheButton_Size_WH*3)/4*(i-2)+TheButton_Size_WH*(i-3)+(TheButton_Size_WH-ImageView_Size_HW)/2, ((theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4)*2+TheButton_Size_WH+(TheButton_Size_WH-ImageView_Size_HW)/2-10, ImageView_Size_HW, ImageView_Size_HW);
            [theImageView bringSubviewToFront:bigView];
            theImageView.backgroundColor=[UIColor whiteColor];
            [bigView addSubview:theImageView];
            
            theLable.frame=CGRectMake((theWidth-TheButton_Size_WH*3)/4*(i-2)+TheButton_Size_WH*(i-3)+(TheButton_Size_WH-80)/2, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*2+TheButton_Size_WH+(TheButton_Size_WH-30)/2-10+30, 80, 30);
            theLable.backgroundColor=[UIColor whiteColor];
            [bigView addSubview:theLable];
            
        }else if(i>5 && i<_array.count){
            
            theImageView.frame=CGRectMake((theWidth-TheButton_Size_WH*3)/4*(i-5)+TheButton_Size_WH*(i-6)+(TheButton_Size_WH-ImageView_Size_HW)/2, ((theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4)*3+TheButton_Size_WH*2+(TheButton_Size_WH-ImageView_Size_HW)/2-10, ImageView_Size_HW, ImageView_Size_HW);
            [theImageView bringSubviewToFront:bigView];
            theImageView.backgroundColor=[UIColor whiteColor];
            [bigView addSubview:theImageView];
            
            theLable.frame=CGRectMake((theWidth-TheButton_Size_WH*3)/4*(i-5)+TheButton_Size_WH*(i-6)+(TheButton_Size_WH-80)/2, (theHeight-(Scroll_Size+70)-TheButton_Size_WH*3)/4*3+TheButton_Size_WH*2+(TheButton_Size_WH-30)/2-10+30, 80, 30);
            theLable.backgroundColor=[UIColor whiteColor];
            [bigView addSubview:theLable];
            
        }
        
        theImageView.image=[UIImage imageNamed:[[NSString alloc] initWithFormat:@"pic%d",i+1]];
        theLable.text=_array[i];
        
    }

}
-(void)myInfoAction
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        MyInfoViewController *info=[[MyInfoViewController alloc ] init];
        info.title=@"消息";
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:info];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        
    }else {
        
        [self toLogViewCtr];
    }

    
}
-(void)timerAction
{
    _index++;
    int num = _scrollView.contentOffset.x/theWidth;
    num=_index;
    pageCtr.currentPage =num;
    [_scrollView setContentOffset:CGPointMake(num*theWidth, 0)];
    if (_index==2) {
        _index=-1;
    }
    
}

-(void)toLogViewCtr
{
    LoginViewController *homeLogin=[[LoginViewController alloc] init];
    
    homeLogin.title=@"登录";
    
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:homeLogin];
    
    [self presentViewController:nac animated:YES completion:^{
        
    }];

}
-(void)Aciton0
{

    //判断是否登陆，由登陆状态判断启动页面
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        YH_allPersonViewController *allPerView=[[YH_allPersonViewController alloc] init];
        
        UINavigationController *nac=[[UINavigationController alloc] initWithRootViewController:allPerView];
        
        [self presentViewController:nac animated:YES completion:^{
            
        }];

        
    }else if([userDefault objectForKey:@"uid"]==nil){
        
        [self toLogViewCtr];
    }
    

    
}
//按钮事件
-(void)Aciton1
{
    HotHouseViewController *hot=[[HotHouseViewController alloc] init];
    hot.title=@"热门楼盘";
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:hot];
    hot.url=[dic objectForKey:@"housesurl"];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
    
    
}
// _array=@[@"热门楼盘",@"我要推荐",@"房屋出售",@"生活缴费",@"业主圈",@"专题活动"];
-(void)Aciton2
{
    //判断是否登陆，由登陆状态判断启动页面
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        SuggestViewController *log=[[SuggestViewController alloc] init];
         
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:log];
        log.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStylePlain target:self action:@selector(dismissHomeAction)];
        
        [self presentViewController:navigation animated:YES completion:nil];
        
    }else if([userDefault objectForKey:@"uid"]==nil){
        
        [self toLogViewCtr];
    }
    
}

-(void)MyGuestAction
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        YH_MyGuestViewController *guest=[[YH_MyGuestViewController alloc] init];
        
        UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:guest];
        guest.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStylePlain target:self action:@selector(dismissHomeAction)];
        
        guest.title=@"客户管理";
        
        [self presentViewController:nac animated:YES completion:^{
            
        }];

        
    }else {
        
        [self toLogViewCtr];
    }


}

-(void)dismissHomeAction
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];

}

-(void)Aciton3
{
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        YH_SaleHouseViewController *houseSale=[[YH_SaleHouseViewController alloc] init];
        UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:houseSale];
        
        [self presentViewController:nac animated:YES completion:^{
            
        }];

       
    }else if([userDefault objectForKey:@"uid"]==nil){
        
        [self toLogViewCtr];
    }
    

}

-(void)Aciton4
{
    WebViewController *hot=[[WebViewController alloc] init];
    hot.title=@"众贷金融";
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:hot];
    hot.HouesStr=[dic objectForKey:@"financialurl"];
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}
-(void)Aciton5
{
    //判断是否登陆，由登陆状态判断启动页面
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        ShengHuoJiaoFei *shengHuoVC = [[ShengHuoJiaoFei alloc] init];
        
        UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:shengHuoVC];
        
        shengHuoVC.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStylePlain target:self action:@selector(dismissHomeAction)];
        
        shengHuoVC.hotHouesStr=_array[3];
        
        shengHuoVC.title=@"生活缴费";
        
        [self presentViewController:nac animated:YES completion:^{
            
        }];
        
    }else if([userDefault objectForKey:@"uid"]==nil){
        
        [self toLogViewCtr];
    }


}
-(void)Aciton6
{
    
    WebViewController *hot=[[WebViewController alloc] init];
    hot.title=@"机票预订";
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:hot];
    hot.HouesStr=[dic objectForKey:@"travelurl"];
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}
-(void)Aciton7
{

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        YH_RentHouseViewController *traViewCtr=[[YH_RentHouseViewController alloc] init];
        
        UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:traViewCtr];
        
        [self presentViewController:nac animated:YES completion:^{
            
        }];
        
        
    }else if([userDefault objectForKey:@"uid"]==nil){
        
        [self toLogViewCtr];        
    }

}
-(void)Aciton8
{
    WebViewController *spe=[[WebViewController alloc] init];
    spe.title=@"业主圈";
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:spe];
    spe.HouesStr=[dic objectForKey:@"proprietorurl"];
    [self presentViewController:navigation animated:YES completion:nil];

}

-(void)Aciton9
{
    WebViewController *spe=[[WebViewController alloc] init];
    spe.title=@"专题活动";
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:spe];
    spe.HouesStr=[dic objectForKey:@"activityurl"];
    [self presentViewController:navigation animated:YES completion:nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        
        NSLog(@"scrollView = %@",scrollView);
        
    }else
    {
        //NSLog(@"scrollView.contentOffset.x = %f",scrollView.contentOffset.x);
        
        int index = scrollView.contentOffset.x/theWidth;
        
        pageCtr.currentPage = index;
        
        if (scrollView.contentOffset.x==theWidth*3) {
            
            [_scrollView setContentOffset:CGPointMake(theWidth, 0)];
            //pageCtr.currentPage = 0;
            
        }else if (scrollView.contentOffset.x==0)
        {
            [_scrollView setContentOffset:CGPointMake(0, 0)];
            
           // pageCtr.currentPage=2;
        }
        
        
    }
    
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
    
    [self.view.window showHUDWithText:@"网络连接已经断开" Type:ShowPhotoNo Enabled:YES];
    
}

@end
