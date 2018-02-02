//
//  YH_SaleHouseViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/3/3.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"
#import "UIWindow+YzdHUD.h"

@interface YH_SaleHouseViewController : UIViewController<HttpRequestClassDelegate>

{
    NSMutableDictionary *dic;
    HttpRequestCalss *httpRequest;
    NSMutableArray *array;
    
    UIImageView  *image2;
    
    UILabel *titleLable1;
    
    UILabel *titleLable2;
    
    UILabel *titleLable3;
    
    UILabel *titleLable4;
    UIImageView  *image1;
    
    NSInteger _thePageNum;
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
