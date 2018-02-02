//
//  MiddlemanViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/1.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface MiddlemanViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate,UITextViewDelegate>
{
   
   

    UITextField *_nickNameField;  //昵称
    UIButton    *theSexButton; //性别
    UITextField *_theQQNumberText; //qq号
    UITextField *_theMailText; //邮箱

    NSMutableArray *_titleArr;
    CALayer *layer;
    CALayer *layer1;
    NSString *getSexStr;
    
    NSDictionary  *dic;
    
    UIButton *getTextButton;
    int index;
    
    UITextView *_textView;
    UILabel *lable;
  
}

@property (weak, nonatomic) IBOutlet UITableView *theTableVIew;

@property (nonatomic,retain)NSString *uid;

@end
