//
//  HouesBinDingViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/16.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface HouesBinDingViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
    
    UITextField *_IdNumber;  //身份证号
    UILabel *typeLable;     //楼盘
    UITextField *_houesNumber; //房号
    UIButton *_houesButton;//楼盘地方
   
    
    UILabel *_projectId;
    
     NSDictionary *dic;
     NSMutableArray *_titleArr;
     NSMutableArray *_titleArr2;
    
    NSArray *array;
    
    UITableViewCell *tabCell;
}
@property (nonatomic,retain)NSDictionary *m_dic;
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;

@property (weak, nonatomic) IBOutlet UITableView *sencondTableView;

@property (nonatomic,retain)NSString *phStr;

@end
