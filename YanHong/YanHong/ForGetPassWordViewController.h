//
//  ForGetPassWordViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/5.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface ForGetPassWordViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
  
    UITextField *_thePhoneText; //手机号
    UITextField *_thePassWordText; //密码
 
    CALayer *layer;
    CALayer *layer1;
    
    UIButton *codeButton;
    
    NSDictionary *dic;
    
    int index;
}

@property (weak, nonatomic) IBOutlet UITableView *thetable;




@end
