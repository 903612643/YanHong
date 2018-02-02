//
//  YH_OpinionViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/3/11.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"

@interface YH_OpinionViewController : UIViewController<UITextViewDelegate,HttpRequestClassDelegate>

{
    UITextView *_textView;
    UILabel *lable;
    
    HttpRequestCalss *httpReq;
}

@end
