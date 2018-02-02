//
//  RootViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/1.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MoblieFriendViewController.h"
#import "YH_DiscoverViewController.h"
#import "YH_MyViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //暂时先弄一个国际化
    HomeViewController *homeView=[[HomeViewController alloc] initwithTitle:@"首页" color:[UIColor whiteColor]];
    homeView.title=@"首页";
    UIImage* selectedImage5 = [UIImage imageNamed:@"fanlan5"];
    //声明这张图片用原图(别渲染)
    selectedImage5 = [selectedImage5 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *homeItem=[[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"首页", nil)  image:[UIImage imageNamed:@"fanlan1"] selectedImage:selectedImage5];
    homeView.tabBarItem=homeItem;
    
    MoblieFriendViewController *buildView=[[MoblieFriendViewController alloc] init];
    buildView.title=@"好友";
    UIImage* selectedImage6 = [UIImage imageNamed:@"fanlan6"];
    //声明这张图片用原图(别渲染)
    selectedImage6 = [selectedImage6 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *buildItem=[[UITabBarItem alloc] initWithTitle:@"好友" image:[UIImage imageNamed:@"fanlan2"] selectedImage:selectedImage6];
    buildView.tabBarItem=buildItem;
    //[buildItem setBadgeValue:@"99+"];
    // [buildItem setBadgeValue:nil];
    UINavigationController *NaviBuild=[[UINavigationController alloc] initWithRootViewController:buildView];
    
    YH_DiscoverViewController *LoginView=[[YH_DiscoverViewController alloc] init];
    LoginView.title=@"发现";
    UIImage* selectedImage7 = [UIImage imageNamed:@"fanlan7"];
    //声明这张图片用原图(别渲染)
    selectedImage7 = [selectedImage7 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *midmanItem=[[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"fanlan3"] selectedImage:selectedImage7];
    LoginView.tabBarItem=midmanItem;
    UINavigationController *NaviMidman=[[UINavigationController alloc] initWithRootViewController:LoginView];
    
    YH_MyViewController *myLoginView=[[YH_MyViewController alloc] init];
    myLoginView.title=@"我的";
    UIImage* selectedImage8 = [UIImage imageNamed:@"fanlan8"];
    //声明这张图片用原图(别渲染)
    selectedImage8 = [selectedImage8 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *myItem=[[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"fanlan4"] selectedImage:selectedImage8];
    myLoginView.tabBarItem=myItem;
    UINavigationController *NaviMy=[[UINavigationController alloc] initWithRootViewController:myLoginView];

    
    _allitem= @[homeView,NaviBuild,NaviMidman,NaviMy];
    

    
    [self setViewControllers:_allitem];
    
    //设置分栏风格
     self.tabBar.barStyle=UIBarStyleDefault ;
    
    //设置选中颜色
    self.tabBar.tintColor = PublieCorlor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
  
}

@end
