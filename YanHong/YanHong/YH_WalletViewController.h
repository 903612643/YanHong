//
//  YH_WalletViewController.h
//  YanHong
//
//  Created by anbaoxing on 16/2/27.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "HttpRequestCalss.h"

@interface YH_WalletViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HttpRequestClassDelegate>
{
    HttpRequestCalss *httpRequest;
    NSDictionary *dic;
    
    UILabel *accountLabel ;
    
    NSString *theUrl;

    
    NSMutableArray *dataArray;
    

}

@end
