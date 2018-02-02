//
//  YH_SetMyPhoneViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/3/15.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_SetMyPhoneViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
    UILabel *phone;
    UITextField *phoneTextField;
    UITextField *phoneTextField1;
    UITextField *codeTextField;
    
    UIButton *getTextButton;
    
    NSDictionary *dic;
    HttpRequestCalss *httpReq;
    
    int index;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
