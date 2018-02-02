//
//  BuyHouseViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/1/20.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "BuyHouseViewController.h"

#import "UIWindow+YzdHUD.h"

#import "PhoneClass.h"

#import "NSString+MD5.h"

#import "Alipay.h"

@interface BuyHouseViewController ()
{
    UIView *backgroundView;
    NSString *price;
    NSString *orderid;
}

@end

@implementation BuyHouseViewController

static int theFont;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theFont=14;
        
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theFont=14;
        
    }else if (IS_IPHONE_6) {  // 6
        
        theFont=18;
        
        
    }else if (IS_IPHONE_6P){
        
        theFont=18;
        
    }
    

        self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        UILabel *titleLable=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        titleLable.font=[UIFont systemFontOfSize:theFont];
        titleLable.text=@"房屋名称：";
        [self.view addSubview:titleLable];
        
        UILabel *commentLable=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 100, 20)];
    commentLable.font=[UIFont systemFontOfSize:theFont];
        commentLable.text=@"房屋描述：";
        [self.view addSubview:commentLable];
        
        UILabel *priceLable=[[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 20)];
        priceLable.font=[UIFont systemFontOfSize:theFont];
        priceLable.text=@"房屋价格：";
        [self.view addSubview:priceLable];
        
        UILabel *titleLable1=[[UILabel alloc] initWithFrame:CGRectMake(100, 10, theWidth-120, 20)];
        titleLable1.font=[UIFont systemFontOfSize:theFont];
        titleLable1.backgroundColor=[UIColor groupTableViewBackgroundColor];
        titleLable1.textAlignment=NSTextAlignmentRight;
        titleLable1.text=_orderTitle;
        [self.view addSubview:titleLable1];
        
        UILabel *commentLable1=[[UILabel alloc] initWithFrame:CGRectMake(100, 40, theWidth-120, 20)];
        commentLable1.font=[UIFont systemFontOfSize:theFont];
        commentLable1.textAlignment=NSTextAlignmentRight;
        commentLable1.text=_orderComment;
        [self.view addSubview:commentLable1];
        
        UILabel *priceLable1=[[UILabel alloc] initWithFrame:CGRectMake(100, 70, theWidth-120, 20)];
        priceLable1.font=[UIFont systemFontOfSize:theFont];
        priceLable1.textColor=[UIColor orangeColor];
        priceLable1.textAlignment=NSTextAlignmentRight;
        priceLable1.text=[[NSString alloc ] initWithFormat:@"%@万元",_orderPrice ];
        [self.view addSubview:priceLable1];
 
        UIButton *buyButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        buyButton.backgroundColor=PublieCorlor;
        buyButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
        buyButton.frame=CGRectMake(10, 120, theWidth-20, 38);
        [buyButton setTitle:@"支付" forState:UIControlStateNormal];
        [buyButton addTarget:self action:@selector(rechargeClicked) forControlEvents:UIControlEventTouchUpInside];
        [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:buyButton];
        buyButton.layer.cornerRadius=8;
        buyButton.layer.masksToBounds=YES;

    
}

-(void)rechargeClicked{

    NSLog(@"orderno=%@",_orderNo);
    NSLog(@"_orderPrice=%@",_orderPrice);
    NSLog(@"_orderTitle=%@",_orderTitle);
    NSLog(@"_orderComment=%@",_orderComment);
    
    int theprice=[_orderPrice intValue];

    NSLog(@"price=%d",theprice);
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *priceStr=[[NSString alloc] initWithFormat:@"%@,0000",_orderPrice ];
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    PhoneClass *phoneClass = [[PhoneClass alloc] init];
    
    if ([phoneClass phone:phoneStr] == YES) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要购买吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                   {
                       
                    NSString *title1=[[NSString alloc ] initWithFormat:@"购买：%@",_orderTitle];
                       
                    [Alipay payForAlipayWithAmount:[priceStr intValue] phonenum:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] title1:title1 title2:@"购买房子用户名" title3:@"购买" price:priceStr myblock:^(NSString *msg)
                     {
                         if ([msg isEqualToString:@"9000"]) {
                              {
                                  //修改订单状态
                                  NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1069\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"infoid\":\"%@\",\"hid\":\"%@\",\"orderno\":\"%@\",\"payamount\":\"%@\",\"paytype\":\"2\",\"paytime\":\"%@\",\"account\":\"\",\"payname\":\"\",\"bank\":\"\",\"pay\":\"1\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],_infoId,_hid,_orderNo,priceStr,dateString];
                                  
                                  //post 请求
                                  
                                  httpRequest=[[HttpRequestCalss alloc] init];
                                  
                                  NSString *url1=[NSString stringWithFormat:THE_POSTURL];
                                  
                                  httpRequest.delegate=self;
                                  
                                  [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                  
                                  [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
                                      
                                  } fail:^{
                                      
                                  }];
                                  
                            
                                  //添加 字典，将label的值通过key值设置传递
                                  NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"已支付",@"payEnd",nil];
                                  //创建通知
                                  NSNotification *notification =[NSNotification notificationWithName:@"notificationActionPay" object:nil userInfo:dict];
                                  //通过通知中心发送通知
                                  [[NSNotificationCenter defaultCenter] postNotification:notification];
                                  
                                  
                                  [self performSelector:@selector(poPAciton) withObject:self afterDelay:1];
                                  
                             }
                             
                         }
                     }];
                }
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:action1];
            [alertController addAction:action2];
            
            [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        [self.view.window showHUDWithText:@"手机号码格式不正确" Type:ShowPhotoNo Enabled:YES];
    }
}
-(void)poPAciton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);

    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    // NSLog(@"error = %@",error);
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    
}


@end
