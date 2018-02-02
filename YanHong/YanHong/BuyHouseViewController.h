//
//  BuyHouseViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/1/20.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface BuyHouseViewController : UIViewController<HttpRequestClassDelegate>
{
    NSDictionary *dic;
    
    HttpRequestCalss *httpRequest;
}

@property (nonatomic,retain)NSString *orderTitle;

@property (nonatomic,retain)NSString *orderPrice;

@property (nonatomic,retain)NSString *orderComment;

@property (nonatomic,retain)NSString *orderNo;

@property (nonatomic,retain)NSString *uid;

@property (nonatomic,retain)NSString *infoId;

@property (nonatomic,retain)NSString *hid;

@end
