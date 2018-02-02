//
//  HouseSaleNextViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/1/11.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface HouseSaleNextViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
    NSMutableArray *_titleArr;
    UITextField *price;
    UITextField *name;
    UITextField *phone;
    UITextField *codePass;
    UITextField *reciveCall;
    
    NSDictionary *dic;
    
    HttpRequestCalss *httpRequest;
    
    UITableViewCell *tabCell;
    
    NSArray *theArray;//确认发布的全部信息
    
    NSArray *theForwardInfoArray;//确认转发的全部信息
    
    NSMutableArray *addArr;
    
    UITableViewCell *cell;
    
    
    UIView *_theView;
    
    int index;
    
    UIButton *codeButton;
    
    UILabel *thepLable;
    UIImageView *_trackView;
    UIImageView *_progressView;
    int imageCount;


}
@property(nonatomic,retain)NSDictionary *forwardInfo;//转发的信息

@property(nonatomic,retain)NSMutableArray *imageArr;

@property(nonatomic,retain)NSString *hid;

@property (nonatomic,retain)NSString *uid;

@property (nonatomic,retain)NSMutableArray *arr;//发布信息

@property (nonatomic,retain)NSString *theprice;

@property (nonatomic,retain)NSString *allPersonUid;



@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
