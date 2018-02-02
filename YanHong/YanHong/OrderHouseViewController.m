//
//  OrderHouseViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/1/16.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "OrderHouseViewController.h"
#import "BuyHouseViewController.h"

#import "UIWindow+YzdHUD.h"

@interface OrderHouseViewController ()

@end

@implementation OrderHouseViewController

static int theFont;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"支付";
    
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theFont=14;

        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theFont=14;

    }else if (IS_IPHONE_6) {  // 6
        
        theFont=18;
        
        
    }else if (IS_IPHONE_6P){
        
        theFont=18;
        
    }
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"notificationActionPay" object:nil];
    
    
}

- (void)tongzhi:(NSNotification *)text{

    buyButton.backgroundColor=[UIColor colorWithRed:60/255.0 green:166/255.0 blue:249/255.0 alpha:1];
    [buyButton setTitle:[text.userInfo objectForKey:@"payEnd"] forState:UIControlStateNormal];
    buyButton.enabled=NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buyAction
{
    
    //NSLog(@"_infoId=%@",_infoId);
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1067\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"infoid\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],_infoId];
    
    httpRequest=[HttpRequestCalss sharnInstance];
    httpRequest.delegate=self;
    [httpRequest httpRequest:strJson1];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *mycellId=@"myCell";
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.row==0 || indexPath.row==2||indexPath.row==4) {
            
            cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
        }
        
        if (indexPath.row==1) {
            
            cell.textLabel.text=[[NSString alloc] initWithFormat:@"购买金额：%@万元",_price];
            cell.textLabel.font=[UIFont systemFontOfSize:theFont];
            
        }else if (indexPath.row==2){
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 7, 150, 30)];
            lable.font=[UIFont systemFontOfSize:theFont];
            lable.textColor=[UIColor redColor];
            lable.text=@"支付方式";
            [cell addSubview:lable];
            
        }else if (indexPath.row==3){
            
            UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 50, 30)];
            image.image=[UIImage imageNamed:@"zhifubao"];
            [cell addSubview:image];
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(70, 7, 60, 30)];
            lable.font=[UIFont systemFontOfSize:theFont];
            lable.text=@"支付宝";
            [cell addSubview:lable];

            
        }else if (indexPath.row==4){
            
            buyButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            buyButton.backgroundColor=PublieCorlor;
            buyButton.frame=CGRectMake(10, 30, theWidth-20, 38);
            [buyButton setTitle:@"去支付" forState:UIControlStateNormal];
            buyButton.titleLabel.font=[UIFont systemFontOfSize:theFont];
            [buyButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
            [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell addSubview:buyButton];
            buyButton.layer.cornerRadius=8;
            buyButton.layer.masksToBounds=YES;
            
            
        }
        
    }
    
    return cell;
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row==4) {
        return theHeight-40-44*4;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1068) {
        
        BuyHouseViewController *buyCtr=[[BuyHouseViewController alloc] init];
        buyCtr.title=@"支付宝支付";
        buyCtr.orderPrice=_price;
        buyCtr.orderTitle=_orderTitle;
        buyCtr.orderComment=_orderComment;
        buyCtr.infoId=_infoId;
        buyCtr.orderNo=[dic objectForKey:@"orderno"];
        buyCtr.uid=_uid;
        buyCtr.hid=_hid;
        
        [self.navigationController pushViewController:buyCtr animated:YES];
        
    }else {
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
    }
    
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    // NSLog(@"error = %@",error);
    
    
}

@end
