//
//  AllPersonViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/8.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//


#import "HttpRequestCalss.h"

static HttpRequestCalss *stance=nil;

@implementation HttpRequestCalss

+(HttpRequestCalss *)sharnInstance
{
    if (stance==nil) {
        
        stance=[[HttpRequestCalss alloc] init];
        
    }
    return stance;
}

-(void)httpRequest:(NSString*)url;
{
    //    创建AFN管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    让manager对象 不要帮我们解析数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    1、  NSString url
    NSMutableString *urlStr = [[NSMutableString alloc]initWithString:theURL];
    
    [urlStr appendString:url];
    //解析urlStr
    NSString *str = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
   // NSLog(@"str=%@",str);
    //    2、3、4、请求
    [manager GET:str  parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSData *data = responseObject;
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"String = %@",string);
        
        //        nsdata ----- 》  json
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     //   NSLog(@"json = %@",json);
        //成功调用
        if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(theSuccess:andHttpRequest:)]) {
            [self.delegate theSuccess:json andHttpRequest:self];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      //  NSLog(@"失败 = %@",error);
        //失败调用
        if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(theFail:andHttpRequest:)]) {
            [self.delegate theFail:error andHttpRequest:self];
        }
    }];
    
}
- (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)())fail
{
    // 创建AFN管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 设置请求格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/html",@"text/html", nil];
    
    NSString *headerData = parameters;
    headerData = [headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *parameters1 = @{@"mobile":headerData};
    
    //NSLog(@"parameters1=%@",parameters1);
    
    [manager POST:urlStr parameters:parameters1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = responseObject;
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"String = %@",string);
        
        id json =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
       // NSLog(@"json = %@",json);
        //这里就不设置委托了，加委托方法同get方法
        
        //成功调用
        if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(theSuccess:andHttpRequest:)]) {
            [self.delegate theSuccess:json andHttpRequest:self];
        }

        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // NSLog(@"%@", error);
        
        //失败调用
        if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(theFail:andHttpRequest:)]) {
            
            [self.delegate theFail:error andHttpRequest:self];
        }
        if (fail) {
            fail();
        }
    }];
    
}




@end
