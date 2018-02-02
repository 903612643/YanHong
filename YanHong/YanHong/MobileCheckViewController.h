//
//  MobileCheckViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/24.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobileCheckViewController : UIViewController
{
    UIImageView *imageView;
    UILabel *nameLable;
}
@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@property (nonatomic,retain)NSString *uid;

@end
