//
//  MoblieFriendViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/21.
//  Copyright © 2015年 anbaoxing. All rights reserved.

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_MyGuestViewController : UIViewController<UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,HttpRequestClassDelegate>
{
    
    //NSMutableArray *allArr;  //通讯录数组
    NSMutableArray *_resultsDataArry;//搜索到的总数
    NSMutableDictionary *_theSectionDic;  //通讯录字典
    NSMutableArray *_theSortArry; //整个排序
    NSArray *_SortArry; //A~Z排序
    NSMutableDictionary *allDic;
    NSMutableArray *myArr;
    NSMutableArray *arry;
    UIView *view;
    
    
    UITableView *headTableView;
    UILabel *nameLable;     //联系人姓名
    UIImageView *imageView; //头像
    UILabel *countLable;   //联系人总数
    UILabel *addLable;     //联系人姓名
    UILabel *phoneLable;     //联系人姓名
    UILabel *tishilable;
    UIButton *theButton1;
    UIButton *theButton2;
    UIButton *theButton3;
    UIButton *theButton4;
    UIButton *theButton5;
    UIButton *theButton6;
    
    UIButton *theButton9;
    
    HttpRequestCalss *httpRequest;
    
    NSDictionary *jsonDic;

    
    NSDictionary *_m_dic;
    
    NSDictionary *dic;
    
    UIButton *ruqeustButton;
    
    UIButton *ruqeustButton1;
    
    UIButton *ruqeustButton2;
    
    UIButton *ruqeustButton3;
    
    UIView *popview;
    UIButton *popButton;
    
    BOOL isClick;
    BOOL isButtonCheck;
  
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSString *str4;
    NSString *str5;
    NSString *str6;
    NSString *allStr;

    
}
@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@property (strong, nonatomic) IBOutlet UISearchDisplayController *theSearchDisplayCtr; //搜索控制器 表视图
@property (weak, nonatomic) IBOutlet UISearchBar *theSearchBar;

@property (nonatomic,retain)NSString *ctrType;//表示预约看房跳过来的界面过来

@property (nonatomic,retain)NSMutableArray *allArr; //通讯录数组

@property (nonatomic,retain)NSMutableArray *forWardArr;//转发信息

@property (nonatomic,retain)NSString *hid;

@property (nonatomic,retain)NSString *infoId;

@property (nonatomic,retain)NSString *codeStr;

@property (nonatomic,retain)NSString *allPersonUid;




@end
