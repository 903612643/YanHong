//
//  MoblieFriendListViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/21.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface MoblieFriendListViewController : UIViewController<UISearchDisplayDelegate,HttpRequestClassDelegate>
{
 //－－－－－－－－－－－－－－－calss－－－－－－－－－－－－－－
    NSMutableDictionary *allDic; //通讯录加入字典集合
    
    NSMutableArray *allArr;  //通讯录加入数组
    
    NSMutableDictionary *_theSectionDic;  //通讯录加入A~z字典
    
    NSMutableArray *_theSortArry; //整个排序
    
    NSArray *_SortArry; //A~Z排序
    
    NSMutableArray *myArr; //搜索得到的数组
    
    NSMutableArray *arry;
    
    HttpRequestCalss *httpRequest;
    
    NSDictionary *dic;
    
    NSString *strTemp; //json
    NSString *name;
    
    
    //－－－－－－－－－－－－－－UI－－－－－－－－－－－－－－－－－
  
    UITableView *headTableView;   
    UILabel *nameLable;  //联系人姓名
    UIImageView *imageView;  //头像
    UILabel *countLable;   //联系人总数
    
    int theIndex;
    
    int idex;
    
    UIView *_theView;
    
    
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *theSearchDisplayCtr; //搜索控制器 表视图
@property (weak, nonatomic) IBOutlet UISearchBar *theSearchBar;

@property (nonatomic,retain)NSString *uid;



@end
