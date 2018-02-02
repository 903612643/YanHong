//
//  YH_allPersonViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/3/1.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_allPersonViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HttpRequestClassDelegate>
{
    UITableView *theTableView;
    HttpRequestCalss *httpRequest;
    NSDictionary *dic;
    
    UILabel *titlelable1;
    UILabel *titlelable2;
    UILabel *titlelable4;
    UILabel *titlelable5;
    
    UIImageView *imageView1;
    
    NSMutableArray *SaleArray;
    
    
    int i;
}






@end
