//
//  HotHouseViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/10.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface HotHouseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HttpRequestClassDelegate>
{
    UIView *view;
    UIWebView *webView;
    NSURLRequest *request;
    HttpRequestCalss *httpRequest;
    NSDictionary *dic;
    
}
@property (nonatomic,retain)NSString *hotHouesStr;

@property (nonatomic,retain)NSString *uid;

@property (nonatomic,retain)NSString *url;



@end
