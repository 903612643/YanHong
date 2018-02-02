//
//  SetPassWordViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/5.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface SetPassWordViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
    //————————————————————————————————firstView——————
    //文本输入textField
    UITextField *_phoneTestField;
    UITextField *_passWrodTestField;
    UITextField *_sureNewpassWrodTestField;
    
    //登录button
    UIButton *LoginButton;
      //layer层
    CALayer *layer;
    CALayer *layer1;
    //请求到的数据
    NSArray *_array;
    NSDictionary *dic;
    
    NSMutableArray *_titleArr;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)NSString *phoneStr1;
@end
