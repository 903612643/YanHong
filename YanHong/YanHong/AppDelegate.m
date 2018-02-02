//
//  AppDelegate.m
//  YanHong
//
//  Created by Mr.yang on 15/12/1.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "UIWindow+YzdHUD.h"
#import "AFNetworking.h"

//ShareSDK头文件
#import <ShareSDK/ShareSDK.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//以下是腾讯SDK的依赖库：
//libsqlite3.dylib

#import <AlipaySDK/AlipaySDK.h>

//微信SDK头文件
#import "WXApi.h"
//以下是微信SDK的依赖库：
//libsqlite3.dylib

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //启动时长
  //  [NSThread sleepForTimeInterval:2];
    
    
    //1.初始化ShareSDK应用,字符串"5559f92aa230"换成http://www.mob.com/后台申请的ShareSDK应用的Appkey
    [ShareSDK registerApp:@"d7f0d217b461"];
    //2. 初始化社交平台
    [self initializePlat];
    
    //状态栏字体白色，＊ios7之前
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //导航栏背景颜色
   // [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:234/225.0 green:27/255.0 blue:48/255.0 alpha:1]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bgm"] forBarMetrics:UIBarMetricsDefault];
    //导航栏文字颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //自定义返回按钮
   UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    //返回按钮为白色
   [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self saveData];
    
    self.window.rootViewController=[[RootViewController alloc] init];
    
    [self.window makeKeyAndVisible];
   
    

    
    return YES;
}
-(void)saveData
{
    //保存本地数据字段，初始化为空,共发布出售使用
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    [userDef setObject:@"" forKey:@"buildings"];
    [userDef setObject:@"" forKey:@"address"];
    [userDef setObject:@"" forKey:@"housetype"];
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
    
    //保存本地数据字段，初始化为空,共发布出租使用
    [userDef setObject:@"" forKey:@"thebuildings"];
    [userDef setObject:@"" forKey:@"theaddress"];
    [userDef setObject:@"" forKey:@"thehousetype"];
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
    
    //初始化本地数组
    [userDef setObject:nil forKey:@"array"];
    [userDef setObject:nil forKey:@"myFriarray"];
    [userDef setObject:nil forKey:@"myViewarray"];
    [userDef setObject:nil forKey:@"myGuest"];
    
    
    [userDef synchronize];
    

}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
//    self.window.rootViewController=[[RootViewController alloc] init];;
//    [self.window makeKeyAndVisible];
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initializePlat
{
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    //    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi class]];
    [ShareSDK connectWeChatWithAppId:@"wx627c97cec8e9e94d"
                           appSecret:@"8ae322c989e06700be26b9b6e76fd5c6"
                           wechatCls:[WXApi class]];
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
}

#pragma mark - 如果使用SSO（可以简单理解成跳客户端授权），以下方法是必要的

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            NSString *urlStr = [NSString stringWithFormat:@"mailto://yanhongjituan@163.com?subject=支付宝&body=感谢您的配合!\n支付宝支付信息:%@",resultDic];
            NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
            [[UIApplication sharedApplication] openURL:url];
        }];
        return YES;
    }
    
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            NSString *urlStr = [NSString stringWithFormat:@"mailto://yanhongjituan@163.com?subject=支付宝&body=感谢您的配合!\n支付宝支付信息:%@",resultDic];
            NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
            [[UIApplication sharedApplication] openURL:url];
        }];
        return YES;
    }
    
    return [ShareSDK handleOpenURL:url wxDelegate:self];;
}


@end
