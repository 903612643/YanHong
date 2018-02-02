//
//  YH_FriendViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/2/26.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_FriendViewController : UIViewController<HttpRequestClassDelegate>
{
    NSMutableDictionary *dic;
    HttpRequestCalss *httpRequest;
    
    UILabel *nameLable;
    UILabel *saleType;
    UILabel *timeLable;
    UILabel *moenyLable;
    UILabel *MynameLable;
    
    NSMutableArray *arr;
    UILabel *bulidingLableType;
    UIView *popview;
    
    UIButton *allButton;
    UIButton *saleButton1;
    UIButton *saleButton2;
    UIButton *lineButton;
    
    UILabel *tishilable;
    
    NSMutableArray *array;
    NSMutableArray *addreeArray;
    
    UILabel  *forWardTitleLable;
    UIImageView *guestHouseimage;
    UILabel  *guestNameLable;
    UILabel  *forWardsaleTypeLable;
    UILabel  *forWardTimeLable;
    UILabel  *salemoneyLable;
    UILabel *isSaleiLable;
    UIButton *forWardButton;
    UIButton *goodButton;
    UIButton *messButton;
    UIButton *pushFriendViewButton;
    
    UIImageView *MyimageView;
    
    BOOL isClick;
    
    NSInteger _thePageNum;
  
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString *friendUid;

@property (nonatomic, strong) NSString *ctrType;//判断是否是从好友详细传过来1是好友

@property (nonatomic, strong) NSString *headStr;

@property (nonatomic, strong) NSString *nickName;

@end
