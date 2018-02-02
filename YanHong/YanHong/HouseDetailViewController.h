//
//  HouseDetailViewController.h
//  YanHong
//
//  Created by anbaoxing on 16/3/23.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface HouseDetailViewController : UIViewController <HttpRequestClassDelegate>
{
    HttpRequestCalss *httpRequest;
    NSDictionary *dict;
}

@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *projectID;
@property (nonatomic, strong) NSArray *projectDatas;

- (void)backBtnClicked;
- (void)showLinkContent:(UIButton *)btn;

@end
