//
//  Alipay.m
//  YanHong
//
//  Created by anbaoxing on 16/1/15.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "Alipay.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation Alipay


+ (void)payForAlipayWithAmount:(int)amount phonenum:(NSString *)phoneNum title1:(NSString *)title1 title2:(NSString *)title2 title3:(NSString *)title3 price:(NSString *)price myblock:(MyBlock)myBlock{
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088011031079202";
    NSString *seller = @"yanhongjituan@163.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANUHvT2hufIm8yjHeExYy/C4nf8+HDv5iXpKApBnmcZRhjmEXKyGGevcqHrddInFv6zs1v6S3wYWddx0HAQmwN5wmLFmU2z+cA06URrzfdERnBMPNOPJ5J8HESFgiKxjl7JSBx9xoQpkR6IHGxS5Bqe6huAWGYCn60ElL9aymba1AgMBAAECgYBI7CdJi6z9SXv/P5jceaEGPAxJrVc46Ii5BdCu4efvzURnN/oJTLZe2OALfvc/miOs7D4EUv5pNRMPbeeRPDrUyhO8viyyNNP3o6i2jvu2j+yTQBRmeUe5YTWJc2JAYb4BMy/4MH4gUUI3CcfQb2vLWWSCLKTZX1a/WqlB/pSwWQJBAPaijCi+xbLJ1FaD/zTgmGE+ZbMmMea2jbBgmf9bcU1pm4lzI6jZpXquJOhmy6uNnkoyBKeBjOAoMF9rizzurr8CQQDdHogtVmOtiHTTdM4+Kn93NJVR7Z5mkRwffoo+pk6N5wgkA7TwHwvSCmk92OPjovP423gePyZUe/FUcjHayWuLAkBQaBH1vqxJa490XTg4jvhey67wRwWByAZNeFD8dV1s9X8lwonfpIVUh620rr67wUHXwpLN4WiCM9gBY9hTFyWVAkAfCzdRLizGYz8LpP2DqtHEeaRxISw4+Cx7m3drPkwPDh2NeNvBToqJTZ7i6P1tqyYXjTB7BqCqAdCq63FmZxrrAkEAtlWcaS6Z5g1gVxzZ2EN7+ZspUJ9JlwHsYaYlrpPtM7vYjczSys2K3R2VwzLncEdtF4THnTY1zP7XJMWpco3Nfw==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    
//    order.productName = [NSString stringWithFormat:@"手机充值【%d】",amount]; //商品标题
//    order.productDescription = [NSString stringWithFormat:@"为手机号码为：%@，充值【%d】",phoneNum,amount]; //商品描述
    
    order.productName = [NSString stringWithFormat:@"%@%d元",title1,amount]; //商品标题
    
    order.productDescription = [NSString stringWithFormat:@"%@：%@，%@【%d元】",title2,phoneNum,title3,amount]; //商品描述
    
    order.amount = price; //商品价格
    //order.amount = @"0.01";
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"com.yanhong.yh";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",[resultDic[@"resultStatus"] class]);
            myBlock(resultDic[@"resultStatus"]);
        }];
        
    }
    
}

+ (NSString *)generateTradeNO
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *resultStr = [NSString stringWithFormat:@"YH%@%@",uid,[formatter stringFromDate:[NSDate date]]];
    return resultStr;
}

@end
