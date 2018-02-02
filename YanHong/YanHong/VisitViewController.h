//
//  VisitViewController.h
//  YanHong
//
//  Created by anbaoxing on 16/3/25.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface VisitViewController : UIViewController <HttpRequestClassDelegate,UIWebViewDelegate>
{
    HttpRequestCalss *httpRequest;
    UIImageView *townImageView;
    
    UIWebView *webView;
    NSURLRequest *request;
    
    NSDictionary *dic;
}

@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *projectID;
@property (nonatomic, strong) NSArray *projectDatas;

@end
