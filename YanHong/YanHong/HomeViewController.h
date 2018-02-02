//
//  HomeViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/1.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HttpRequestCalss.h"

@interface HomeViewController : UIViewController<UIScrollViewDelegate,HttpRequestClassDelegate>
{
    int _index;
    UIView *_view;   //ScrollView的父View
    UIView *_subView;
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    UIPageControl *pageCtr;
    UIButton *appbtn; //_subView上的button;
    NSArray *_array;
    
    NSUserDefaults *userDefault;
    
    HttpRequestCalss *httpRequest;
    
    NSDictionary *dic;
    
    NSInteger theindex;

}


-(id)initwithTitle:(NSString *)title color:(UIColor *)color;



@end
