//
//  RegsiterViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/4.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"


@interface RegsiterViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate,UIWebViewDelegate>
{
    
    NSMutableArray *_titleArr;
    UITextField *_theTextField;  //姓名
    UITextField *_thePhoneText; //手机号
    UITextField *_theNameText; //推荐人
    UITextField *_thePassWordText; //密码
    UITextField *_thePassText; //验证码
    CALayer *layer;
    CALayer *layer1;
    
    HttpRequestCalss *httpReq;
    NSDictionary *dic;
    
    UIView *_theView;
    
    UIButton *imageButton;
    UIButton *proButton;
    UIButton *regButton;
    
    UIButton *getTextButton;
    
    int index;
    
    
    UIWebView *webView;
    NSURLRequest *request;
}


@property (weak, nonatomic) IBOutlet UITableView *theTableVIew;



@end
