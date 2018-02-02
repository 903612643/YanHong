//
//  Alipay.h
//  YanHong
//
//  Created by anbaoxing on 16/1/15.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSString *msg);

@interface Alipay : NSObject

+ (void)payForAlipayWithAmount:(int)amount phonenum:(NSString *)phoneNum title1:(NSString *)title1 title2:(NSString *)title2 title3:(NSString *)title3 price:(NSString *)price myblock:(MyBlock)myBlock;



@end
