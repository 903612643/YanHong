//
//  YH_MyViewController.h
//  YanHong
//
//  Created by anbaoxing on 16/2/26.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"
#import "UIWindow+YzdHUD.h"

@interface YH_MyViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,HttpRequestClassDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    HttpRequestCalss *httpRequest;
    NSDictionary *dic;
    UITableView *_tableView;
    UILabel *nameLabel ;
    UIView *_theView;
    UILabel *signatureLabel;

    
    UILabel *dataLabel ;
     UIView *popview;
    NSArray *dataArray ;
    
    UIButton *headButton;
    UIButton *LableButton1;
    UIButton *LableButton2;
    BOOL isClick;
    NSString *theUrl;
    
    UIView *theBView;
    
    BOOL addLastDataIsYes;
}

@property (strong, nonatomic) UIWindow *window;


@end
