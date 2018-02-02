//
//  YH_FriendInfoViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/3/15.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YH_FriendInfoViewController : UIViewController
{
    NSArray *array;
    NSArray *lableArr;
    UILabel *nameLable;
    UILabel *addLable;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableViiew;

@property (nonatomic,retain)NSMutableDictionary *dict;

@end
