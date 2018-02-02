//
//  YH_GuestInfoViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/3/16.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YH_GuestInfoViewController : UIViewController
{
    NSArray *array;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,retain)NSDictionary *dic;

@end
