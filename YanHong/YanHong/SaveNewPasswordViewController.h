//
//  SaveNewPasswordViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/8.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface SaveNewPasswordViewController : UIViewController<HttpRequestClassDelegate,UITextFieldDelegate>
{
    
    UITextField *_thePhoneText; //手机号
    UITextField *_thePassWordText; //密码
    
    NSDictionary *dic;
    CALayer *layer;
    

}
@property (nonatomic,retain)NSString *phoneStr;

@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@property (weak, nonatomic) IBOutlet UIButton *commitAction2;

- (IBAction)commiteAction2:(id)sender;
@end
