//
//  OrderHouseViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/1/16.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface OrderHouseViewController : UIViewController<HttpRequestClassDelegate>
{
    HttpRequestCalss *httpRequest;
    
    NSDictionary *dic;
    
    UIButton *buyButton;
}

@property (nonatomic,retain)NSString *uid;

@property (nonatomic,retain)NSString *infoId;

@property (nonatomic,retain)NSString *price;

@property (nonatomic,retain)NSString *orderTitle;

@property (nonatomic,retain)NSString *hid;

@property (nonatomic,retain)NSString *orderComment;

@end
