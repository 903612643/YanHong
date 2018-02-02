//
//  YH_MyHousePropertyViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/4/7.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_MyHousePropertyViewController : UIViewController<HttpRequestClassDelegate>
{
    HttpRequestCalss *httpRequest;
    
    NSDictionary *dic;
    
    NSMutableArray *array;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIButton *delButton;

@end
