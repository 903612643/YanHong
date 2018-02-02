//
//  YH_AllBillViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/2/29.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_AllBillViewController : UIViewController<HttpRequestClassDelegate>
{

    NSArray *_listArry;
    UILabel *timeLable1;
    UILabel *moneyLable;
    UILabel *timeLable2;
    UILabel *isSale;
    UILabel *saleTypeLable;
    
    HttpRequestCalss *httpRequest;
    
    NSDictionary *dic;
}
@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@end
