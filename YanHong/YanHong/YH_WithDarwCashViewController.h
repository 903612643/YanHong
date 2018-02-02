//
//  YH_WithDarwCashViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/4/13.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_WithDarwCashViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
    NSArray *array;
    
    UITextField *_bankCountTextFiled;
    UITextField *_nameTextFiled;//姓名
    UITextField *_moneyTextFiled;
 
    NSMutableDictionary *dic;
    HttpRequestCalss *httpRequest;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
