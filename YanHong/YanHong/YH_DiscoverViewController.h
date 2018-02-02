//
//  YH_DiscoverViewController.h
//  YanHong
//
//  Created by anbaoxing on 16/2/26.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"


@interface YH_DiscoverViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,HttpRequestClassDelegate>
{
    HttpRequestCalss *httpRequest;
    NSDictionary *dic;
}


@end
