//
//  YH_RentHouseDetailViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/3/9.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_RentHouseDetailViewController : UIViewController<UIScrollViewDelegate,HttpRequestClassDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *imageView1;
    UILabel *title1;
    UILabel *title2;
    UILabel *title3;
    UILabel *title4;
    UILabel *title5;
    UILabel *title6;
    UILabel *title7;
    UILabel *title8;
    UILabel *lable1;
    UILabel *lable2;
    UIButton *buyButton;
    UIView *_theView;
    UIView *view;
    UIButton *callPhoneButton;
    UIButton *forWardButton;
    UILabel *countlLable;
    UIView *headView;
    
    
    HttpRequestCalss *httpRequest;
    NSDictionary *dic;
    int picCount;
    NSMutableDictionary *thePicDic;
    UIPageControl *pageCtr;
    NSMutableArray *imageArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,retain)NSString *uid;

@property (nonatomic,retain)NSString *houseid;

@property (nonatomic,retain)NSString *infoid;

@property (nonatomic,retain)NSString *allPersonUid;

@property (nonatomic,retain)NSMutableDictionary *tradetypeIs2;

@property (nonatomic,retain)NSString *ctrType;//判断是出租还是出售


@end
