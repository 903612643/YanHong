//
//  SuggestViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/9.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface SuggestViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
    
    NSMutableArray *_titleArr;
    UITextField *_theTextField;  //姓名
    UITextField *_thePhoneText; //手机号
    UITextField *_theNameText; //推荐人
    UITextField *_theTypeText; //类型
    UITextField *_thePassText; //验证码
    UIView *_view;
    UILabel *lable2;
    UIButton *_houesButton;
    
    UILabel *_projectId;
    
    UIButton *getTextButton;//性别
    NSString *getSexStr;
    
    UITableViewCell *tabCell ;

    
    CALayer *layer;
    CALayer *layer1;
   // NSDictionary *m_dic;
    NSArray *houseArr;
    
    UIView *_theView;
    
    NSArray *array;
    
    NSDictionary *dic;
    
   
   
    

}
-(BOOL)name:(NSString *)name;

@property (nonatomic,retain)NSDictionary *m_dic;

@property (weak, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@property (weak, nonatomic) IBOutlet UITableView *theTableView2;


@property (nonatomic,retain)NSString *uid;





@end
