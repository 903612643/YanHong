//
//  PicBrowserViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/1/9.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicBrowserViewController : UIViewController<UIScrollViewDelegate>
{
     UIScrollView *_scrollView;
    
     UIPageControl *pageCtr;
}
@property(nonatomic,retain)NSMutableArray *imageArray;

@end
