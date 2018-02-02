//
//  PicBrowserViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/1/9.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "PicBrowserViewController.h"

@interface PicBrowserViewController ()

@end

@implementation PicBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *title=[[NSString alloc] initWithFormat:@"第%d/%lu张",1,(unsigned long)_imageArray.count];
    
    self.title=title;
   // NSLog(@"imageArr=%@",_imageArray);
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
    [self.view addSubview:view];
    
    _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
    //设置内容大小
    _scrollView.contentSize=CGSizeMake(theWidth*_imageArray.count, 0);
    //设置是否分页
    _scrollView.pagingEnabled=YES;
    
     _scrollView.delegate=self;
    
    [view addSubview:_scrollView];
   
    
    
    for (int i=0; i<_imageArray.count; i++) {
        
//        //Base64字符串转UIImage图片：
//        NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:_imageArray[i]];
//        
//        UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
        
        //加入imange
        UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth*i, 0, theWidth, theHeight)];
        
        imageView1.image=_imageArray[i];
        
        [_scrollView addSubview:imageView1];
        

    }
    
    if (_imageArray.count!=1) {
        
        //加入 UIPageControl
        pageCtr=[[UIPageControl alloc] initWithFrame:CGRectMake((theWidth)/2, theHeight-100, 10, 20)];
        pageCtr.backgroundColor=[UIColor redColor];
        pageCtr.numberOfPages=_imageArray.count;
        pageCtr.tag=102;
        pageCtr.pageIndicatorTintColor=[UIColor whiteColor];
        pageCtr.currentPageIndicatorTintColor=[UIColor redColor];
        [self.view addSubview:pageCtr];
        

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    
    if ([scrollView isMemberOfClass:[UITableView class]]) {
       
    }else
    {
        //NSLog(@"scrollView.contentOffset.x = %f",scrollView.contentOffset.x);
        
        int index = scrollView.contentOffset.x/theWidth;
        
        pageCtr.currentPage = index;
        
     //   NSLog(@"index=%d",index);
        
        NSString *title=[[NSString alloc] initWithFormat:@"第%d/%lu张",index+1,(unsigned long)_imageArray.count];

        self.title=title;
        
        if (scrollView.contentOffset.x==theWidth*_imageArray.count) {
            
            [_scrollView setContentOffset:CGPointMake(theWidth, 0)];
            //pageCtr.currentPage = 0;
            
        }else if (scrollView.contentOffset.x==0)
        {
            [_scrollView setContentOffset:CGPointMake(0, 0)];
            
            // pageCtr.currentPage=2;
        }
        
        
    }
    
}// called when scroll view grinds to a halt


@end
