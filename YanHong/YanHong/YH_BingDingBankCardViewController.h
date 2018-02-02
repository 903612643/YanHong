//
//  YH_BingDingBankCardViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/4/7.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_BingDingBankCardViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
    NSArray *array;
    UITextField *_nameTextFiled;//姓名
    UITextField *_idCardTextFiled;
    UITextField *_bankIdTextFiled;
    UITextField *_bankCountTextFiled;
    
    NSMutableDictionary *dic;
    HttpRequestCalss *httpRequest;
   
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
