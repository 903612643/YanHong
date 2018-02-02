//
//  LinkViewController.h
//  YanHong
//
//  Created by anbaoxing on 16/3/25.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface LinkViewController : UIViewController <HttpRequestClassDelegate>
{
    HttpRequestCalss *httpRequest;
}

@property (nonatomic, copy) NSString *projectID;
@property (nonatomic, copy) NSString *keyName;

@end
