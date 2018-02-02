//
//  YH_AllBIillDetailViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/4/13.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YH_AllBIillDetailViewController : UIViewController
{
    NSArray *array;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,retain)NSDictionary *dict;

@end
