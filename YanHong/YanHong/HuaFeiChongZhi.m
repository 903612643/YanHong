//
//  HuaFeiChongZhi.m
//  YanHong
//
//  Created by anbaoxing on 15/12/30.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "HuaFeiChongZhi.h"
#import "PhoneClass.h"
#import "UIWindow+YzdHUD.h"
#import "NSString+MD5.h"
#import "Alipay.h"
#import "MoblieFriendListViewController.h"

@interface HuaFeiChongZhi () <UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UITextField *textField;
    UILabel *siteLabel;
    UIButton *selectBtn;
    NSString *orderid;
    NSString *price;
    UIView *backgroundView;
    
    int theprice;
    
    NSUserDefaults *userDef;
}

@end


@implementation HuaFeiChongZhi

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}

-(void)popAction
{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

static int theFont;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"notificationPhone" object:nil];
    
    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        
        theFont=14;
        
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theFont=18;
        
    }else if (IS_IPHONE_6) {  // 6
        
        
        theFont=22;
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        theFont=22;
        
        
    }
    
    //navigationBar
    self.navigationItem.title = @"手机充值";
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithTitle:@"充值记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBBIClicked)];
   // self.navigationItem.rightBarButtonItem = rightBBI;
    
    //手机号输入框
    textField = [[UITextField alloc] initWithFrame:CGRectMake(13, 12, theWidth - 56, 38)];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor=[UIColor clearColor];
    textField.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:theFont+3];
    textField.keyboardType=UIKeyboardTypeNamePhonePad;
    textField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    textField.clearsOnBeginEditing = YES;
    textField.delegate = self;
    
    UIButton *imageView = [[UIButton alloc] init];
    imageView.frame = CGRectMake(theWidth-40, 16, 30, 30);
    [imageView setImage:[UIImage imageNamed:@"address.jpg"] forState:UIControlStateNormal];
    [imageView addTarget:self action:@selector(checkPersonButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imageView];
    
    [textField addTarget:self action:@selector(typingNumber) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:self action:@selector(returnKeyClicked) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:textField];

    siteLabel = [[UILabel alloc] init];
    siteLabel.frame = CGRectMake(20, 50, theWidth - 40, 12);
    siteLabel.textColor = [UIColor grayColor];
    siteLabel.font = [UIFont systemFontOfSize:12];
    //siteLabel.text = @"(广东移动)";
    [self.view addSubview:siteLabel];
    
    UILabel *pLineLabel = [[UILabel alloc] init];
    pLineLabel.alpha = 0.1;
    pLineLabel.frame = CGRectMake(0, 68, theWidth, 0.5);
    pLineLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:pLineLabel];

    //充值面值
    selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];//用于传值
    NSArray *valueArray = @[@"5元",@"10元",@"20元",@"30元",@"50元",@"100元",@"300元"];
    
    for (int i = 0; i < valueArray.count; i++) {
        
        CGRect viewRect;
        viewRect.size.width = (theWidth-40) / 3;
        viewRect.size.height = 68;
        viewRect.origin.x = 10 * ((i%3)+1) + viewRect.size.width * (i%3);
        viewRect.origin.y = 88 + (viewRect.size.height+10) * (i/3);
        UIView *chargeView = [[UIView alloc] init];
        chargeView.frame = viewRect;
        chargeView.layer.borderWidth = 1;
        chargeView.layer.borderColor = [UIColor redColor].CGColor;
        chargeView.layer.cornerRadius = 4;
        [self.view addSubview:chargeView];
        
        UILabel *chargeLabel = [[UILabel alloc] init];
        chargeLabel.textColor = [UIColor redColor];
        chargeLabel.textAlignment = NSTextAlignmentCenter;
        chargeLabel.font = [UIFont systemFontOfSize:18];
        chargeLabel.text = valueArray[i];
        [chargeLabel sizeToFit];
        CGPoint chargePoint;
        chargePoint.x = viewRect.size.width / 2;
        chargePoint.y = viewRect.size.height/2 - chargeLabel.frame.size.height/2;
        chargeLabel.center = chargePoint;
        [chargeView addSubview:chargeLabel];
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.text = [NSString stringWithFormat:@"售价:%@",valueArray[i]];
        [priceLabel sizeToFit];
        CGPoint pricePoint;
        pricePoint.x = viewRect.size.width / 2;
        pricePoint.y = viewRect.size.height/2 + priceLabel.frame.size.height/2;
        priceLabel.center = pricePoint;
        [chargeView addSubview:priceLabel];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        tapGestureRecognizer.delegate = self;
        [tapGestureRecognizer addTarget:self action:@selector(btnClicked:)];
        [chargeView addGestureRecognizer:tapGestureRecognizer];
    
    }
    
}

- (void)rightBBIClicked {
    NSLog(@"充值记录");
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] && touch.tapCount == 1) {
        UIView *chargeView = gestureRecognizer.view;
        
        UILabel *chargeLabel = chargeView.subviews[0];
        chargeLabel.textColor = [UIColor whiteColor];
        
        UILabel *priceLabel = chargeView.subviews[1];
        priceLabel.textColor = [UIColor whiteColor];
        
        chargeView.backgroundColor = [UIColor colorWithRed:214/255. green:142/255. blue:68/255. alpha:1.];
    }
    return YES;
    
}

-(void)btnClicked:(UITapGestureRecognizer *)tapGestureRecognizer{
    
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        UIView *chargeView = tapGestureRecognizer.view;
        
        UILabel *chargeLabel = chargeView.subviews[0];
        chargeLabel.textColor = [UIColor colorWithRed:214/255. green:142/255. blue:68/255. alpha:1.];
        
        UILabel *priceLabel = chargeView.subviews[1];
        priceLabel.textColor = [UIColor colorWithRed:214/255. green:142/255. blue:68/255. alpha:1.];
        
        chargeView.backgroundColor = [UIColor whiteColor];
        
        //选择的充值面值
        [selectBtn setTitle:[NSString stringWithFormat:@"%d",[chargeLabel.text intValue]] forState:UIControlStateNormal];
        
        [self rechargeClicked];
        
    }
    
}
- (void)tongzhi:(NSNotification *)text{
    
    NSLog(@"%@",text.userInfo[@"phoneNumber"]);
    
    NSString *string = [text.userInfo[@"phoneNumber"] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    textField.text=string;
    
}

-(void)checkPersonButtonAction
{
    MoblieFriendListViewController *mobList=[[MoblieFriendListViewController alloc] init];
    mobList.title=@"选择号码";
    [self.navigationController pushViewController:mobList animated:YES];
}

-(void)Action
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rechargeClicked{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSString *phoneStr = textField.text;
    NSString *valueStr = selectBtn.titleLabel.text;
    PhoneClass *phoneClass = [[PhoneClass alloc] init];
    if ([phoneClass phone:phoneStr] == YES) {
        if (valueStr.length != 0) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"该号码是否为您需要充值的手机号码?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
//                [self loadingView];
                
               // [self.view.window showHUDWithText:@"正在充值..." Type:ShowLoading Enabled:YES];
                
                NSString *strJson1 = [NSString stringWithFormat:@"http://op.juhe.cn/ofpay/mobile/telcheck?cardnum=%@&phoneno=%@&key=%@",valueStr,phoneStr,APPKEY];
                [self getRequestWithUrlStr:strJson1];
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:action1];
            [alertController addAction:action2];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }else{
            [self.view.window showHUDWithText:@"请选择需要充值的面额" Type:ShowPhotoNo Enabled:YES];
        }
    }else{
        [self.view.window showHUDWithText:@"手机号码格式不正确" Type:ShowPhotoNo Enabled:YES];
    }
}

-(void)typingNumber{
}

-(void)returnKeyClicked{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
}

#pragma mart - HttpRequest

-(void)getRequestWithUrlStr:(NSString *)urlStr{
    //检测是否手机号码和金额是否可以充值
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    NSString *param = [NSString stringWithFormat:@"cardnum=%@&phoneno=%@&key=%@",selectBtn.titleLabel.text,textField.text,APPKEY];
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data.length != 0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"error_code"] isEqualToNumber:@(0)]) {
                NSString *urlStr = @"http://op.juhe.cn/ofpay/mobile/telquery";
                [self queryCommodityRequestWithUrlStr:urlStr];
            }else{
                if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                    [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:dict[@"reason"] waitUntilDone:YES];
                }
            }
        }else{
            if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:error.localizedDescription waitUntilDone:YES];
            }
        }
        
    }];
    [dataTask resume];
}

-(void)queryCommodityRequestWithUrlStr:(NSString *)urlStr{
    //根据手机号和面值查询商品
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    NSString *param = [NSString stringWithFormat:@"cardnum=%@&phoneno=%@&key=%@",selectBtn.titleLabel.text,textField.text,APPKEY];
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data.length != 0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"error_code"] isEqualToNumber:@(0)]) {
                NSDictionary *resultDict = dict[@"result"];
                price = resultDict[@"inprice"];
                [self creatOrderFormWithinprice:price];
            }else{
                if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                    [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:dict[@"reason"] waitUntilDone:YES];
                }
            }
        }else{
            if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:error.localizedDescription waitUntilDone:YES];
            }
        }
    }];
    [dataTask resume];
}

-(void)creatOrderFormWithinprice:(NSString *)inprice{
    //创建订单
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSS"];
    orderid = [NSString stringWithFormat:@"YANHONG%@",[formatter stringFromDate:[NSDate date]]];//orderid
    
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1071\",\"errcode\":\"000\",\"timestamp\":\"137889283\",\"uid\":\"%@\",\"orderid\":\"%@\",\"inprice\":\"%@\",\"price\":\"%@\",\"recharge\":\"0\",\"phone\":\"%@\",\"pay\":\"0\",\"createtime\":\"%ld\"}",theURL,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],orderid,inprice,selectBtn.titleLabel.text,textField.text,(long)[[NSDate date] timeIntervalSince1970]];
    
    NSLog(@"%@",urlStr);
    
    NSString *urlStr1 = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlStr1];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data.length != 0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"errcode"] isEqualToString:@"000"]) {
                NSString *urlStr = @"http://op.juhe.cn/ofpay/mobile/yue";
                [self queryBalanceRequestWithUrlStr:urlStr ];
            }else{
                if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                    [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:dict[@"reason"] waitUntilDone:YES];
                }
            }
        }else{
            if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:error.localizedDescription waitUntilDone:YES];
            }
        }
    }];
    [dataTask resume];
}

-(void)queryBalanceRequestWithUrlStr:(NSString *)urlStr{
    //账户余额查询
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    NSString *timestamp = [NSString stringWithFormat:@"%zi",(NSInteger)[[NSDate date] timeIntervalSince1970]];
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@",OPENID,APPKEY,timestamp];
    NSLog(@"%@",signStr);
    NSString *sign = [signStr md5String];
    NSString *param = [NSString stringWithFormat:@"key=%@&timestamp=%@&sign=%@",APPKEY,timestamp,sign];
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data.length != 0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"error_code"] isEqualToNumber:@(0)]) {
                NSDictionary *resultDict = dict[@"result"];
                if ([resultDict[@"money"] floatValue] < [selectBtn.titleLabel.text floatValue]) {
                    //聚合账号余额不足
                    if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                        [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:@"暂时无法充值，请联系客服!" waitUntilDone:YES];
                    }
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{

                        [Alipay payForAlipayWithAmount:[selectBtn.titleLabel.text intValue] phonenum:textField.text title1:[[NSString alloc] initWithFormat:@"充值"] title2:@"为手机号码" title3:@"充值" price:price myblock:^(NSString *msg)
                         
                        {
                            NSLog(@"%@",msg);
                            
                            if ([msg isEqualToString:@"9000"]) {
                                
                                [self orderIsPay];
                                
                            }else{
                                
                            }
                        }];
                    });
                }
            }else{
                if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                    [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:dict[@"reason"] waitUntilDone:YES];
                }
            }
        }else{
            if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:error.localizedDescription waitUntilDone:YES];
            }
        }
    }];
    [dataTask resume];
}

-(void)orderIsPay{
    //订单已支付
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1073\",\"errcode\":\"000\",\"timestamp\":\"137889283\",\"uid\":\"%@\",\"orderid\":\"%@\",\"pay\":\"1\",\"createtime\":\"%ld\",}",theURL,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],orderid,(long)[[NSDate date] timeIntervalSince1970]];
    NSLog(@"%@",urlStr);
    NSString *urlStr1 = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlStr1];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data.length != 0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"errcode"] isEqualToString:@"000"]) {
                
                NSString *urlStr = @"http://op.juhe.cn/ofpay/mobile/onlineorder";
                [self rechargeRequestWithUrlStr:urlStr];
            }else{
                if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                    [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:dict[@"reason"] waitUntilDone:YES];
                }
            }
        }else{
            if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:error.localizedDescription waitUntilDone:YES];
            }
        }
    }];
    [dataTask resume];
}

-(void)rechargeRequestWithUrlStr:(NSString *)urlStr{
    //手机直接充值
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    NSString *phoneStr = textField.text;//phone
    NSString *valueStr = selectBtn.titleLabel.text;//value
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@%@",OPENID,APPKEY,phoneStr,valueStr,orderid];
    NSString *sign = [signStr md5String];
    NSString *param = [NSString stringWithFormat:@"key=%@&phoneno=%@&cardnum=%@&orderid=%@&sign=%@",APPKEY,phoneStr,valueStr,orderid,sign];
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data.length != 0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"error_code"] isEqualToNumber:@(0)]) {
                [self orderIsRecharge];
                if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                    [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:dict[@"reason"] waitUntilDone:YES];
                }
            }else{
                if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                    [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:dict[@"reason"] waitUntilDone:YES];
                }
            }
        }else{
            if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:error.localizedDescription waitUntilDone:YES];
            }
        }
    }];
    [dataTask resume];
}

-(void)orderIsRecharge{
    //  已充值
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1075\",\"errcode\":\"000\",\"timestamp\":\"137889283\",\"uid\":\"%@\",\"orderid\":\"%@\",\"recharge\":\"1\",\"createtime\":\"%ld\",}",theURL,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],orderid,(long)[[NSDate date] timeIntervalSince1970]];
    NSLog(@"%@",urlStr);
    NSString *urlStr1 = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlStr1];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data.length != 0) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if ([dict[@"errcode"] isEqualToString:@"000"]) {
                //订单修改成功
                NSLog(@"dict=%@",dict);
                
            }else{
                
                if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                    [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:dict[@"reason"] waitUntilDone:YES];
                    
                }
            }
        }else{
            if ([self respondsToSelector:@selector(ShowAlertWithString:)]) {
                [self performSelectorOnMainThread:@selector(ShowAlertWithString:) withObject:error.localizedDescription waitUntilDone:YES];
            }
        }
    }];
    [dataTask resume];
}

-(void)ShowAlertWithString:(NSString *)string{
    
//    [self removeLoadingView];
//    
//    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)loadingView{
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
    [self.view addSubview:backgroundView];
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80 , 80)];
    centerView.center = CGPointMake(backgroundView.center.x, backgroundView.center.y-64);
    centerView.backgroundColor = [UIColor grayColor];
    centerView.alpha = 0.8;
    [backgroundView addSubview:centerView];
    //调整边框
    centerView.layer.cornerRadius = 10;
    centerView.layer.masksToBounds = YES;
    //小菊花
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center = CGPointMake(centerView.frame.size.width / 2, centerView.frame.size.width / 2 - 10);
    [centerView addSubview:activityView];
    [activityView startAnimating];
    //请稍等
    UILabel *waitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, centerView.frame.size.width, 13)];
    waitLabel.text = @"加载中...";
    waitLabel.font = [UIFont systemFontOfSize:15];
    waitLabel.textColor = [UIColor whiteColor];
    waitLabel.textAlignment = NSTextAlignmentCenter;
    [centerView addSubview:waitLabel];
}

-(void)removeLoadingView{
    [backgroundView removeFromSuperview];
}

@end