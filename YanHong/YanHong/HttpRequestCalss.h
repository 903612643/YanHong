//
//  AllPersonViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/8.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#import <CommonCrypto/CommonDigest.h>

@class HttpRequestCalss;

@protocol HttpRequestClassDelegate <NSObject>

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;


@end

@interface HttpRequestCalss : NSObject
{
    id<HttpRequestClassDelegate>_delegate;
}

@property(nonatomic,retain) id<HttpRequestClassDelegate> delegate;

//开始请求
-(void)httpRequest:(NSString*)url;

//单例
+(HttpRequestCalss *)sharnInstance;


- (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail;



@end
