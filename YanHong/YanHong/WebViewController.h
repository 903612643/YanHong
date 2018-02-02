//
//  WebViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/5.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController<UIWebViewDelegate>

{
    UIView *view;
    UIWebView *webView;
    NSURLRequest *request;
    
}

@property (nonatomic,retain)NSString *HouesStr;

@end
