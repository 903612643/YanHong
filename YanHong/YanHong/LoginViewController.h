//
//  IndexViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/2.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"


@interface LoginViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
    //————————————————————————————————firstView——————
    //文本输入textField
    UITextField *_phoneTestField1;
    UITextField *_passWrodTestField;
    //视图View
    UIView *firstView;
    UIView *firstSubView;
    //登录button
    UIButton *LoginButton;
    //注册
    UIView *subView;
    UIButton *regButton1;
    //layer层
    CALayer *layer;
    CALayer *layer1;
    //请求到的数据
    NSArray *_array;
    NSDictionary *dic;
    //————————————————————————————————secondView———————
    UIView *secondView;
     UIButton *returnButton;
    
    HttpRequestCalss *httpRequest;
    NSDictionary *phoneDic;
    
    NSUserDefaults *userDefault;
    
    NSInteger index;
    
    UIView *_theView;
}


@property (nonatomic,assign)NSInteger selectIndex;


@end
