//
//  MyInfoViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/14.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface MyInfoViewController : UIViewController<HttpRequestClassDelegate>
{
    HttpRequestCalss *httpRequest;
    NSDictionary *dic;
    
    UILabel *_theLable1;
    UILabel *_theLable2;
    UILabel *_theLable3;
    
    NSArray *arry;
    
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@property (nonatomic,retain)NSString *uid;

@end
