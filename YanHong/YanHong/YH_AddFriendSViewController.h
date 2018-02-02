//
//  MoblieFriendViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/21.
//  Copyright © 2015年 anbaoxing. All rights reserved.

#import <UIKit/UIKit.h>

@interface YH_AddFriendSViewController : UIViewController<UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    

    UIView *view;
    UITableView *headTableView;
    UILabel *nameLable;     //联系人姓名

    UILabel *nameLable1;     //联系人姓名
    UIImageView *imageView; //头像

    UIButton *ruqeustButton;
    
    UIButton *ruqeustButton1;
    
    
    UILabel *isAddLable;     //联系人姓名

   
    
}
@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@property (strong, nonatomic) IBOutlet UISearchDisplayController *theSearchDisplayCtr; //搜索控制器 表视图
@property (weak, nonatomic) IBOutlet UISearchBar *theSearchBar;



@property (nonatomic,retain)NSMutableArray *allArr; //通讯录数组






@end
