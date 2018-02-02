//
//  YH_FriendRemarksViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/3/16.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"
@interface YH_FriendRemarksViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate>
{
    NSArray *array;
    
    UITextField *textfield;
    HttpRequestCalss *httpRequest;
    NSDictionary *dic;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,retain)NSDictionary *dict;

@end
