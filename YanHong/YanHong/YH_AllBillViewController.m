//
//  YH_AllBillViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/2/29.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_AllBillViewController.h"
#import "YH_BillViewController.h"
#import "YH_AllBIillDetailViewController.h"

@interface YH_AllBillViewController ()

@end

@implementation YH_AllBillViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self httpData];
    
    
}
-(void)httpData
{
    //当前时间
    NSDate *date=[NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    

    //手机号码正确，请求数据
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1081\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"type\":\"%@\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],@"0"];

    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _listArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"myCell";
    
    UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (tabCell == nil) {
        
        tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        tabCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        timeLable1=[[UILabel alloc] initWithFrame:CGRectMake(0, 15, 80, 20)];
        timeLable1.backgroundColor=[UIColor clearColor];
        timeLable1.textAlignment=NSTextAlignmentCenter;
        timeLable1.font=[UIFont systemFontOfSize:15];
        timeLable1.alpha=0.8;
        [tabCell addSubview:timeLable1];
        
        timeLable2=[[UILabel alloc] initWithFrame:CGRectMake(0, 35, 80, 20)];
        timeLable2.textAlignment=NSTextAlignmentCenter;
        timeLable2.font=[UIFont systemFontOfSize:11];
        timeLable2.alpha=0.4;
        timeLable2.backgroundColor=[UIColor clearColor];
        [tabCell addSubview:timeLable2];
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(80, 10, 40, 40)];
        imageView.layer.cornerRadius=20;
        imageView.layer.masksToBounds=YES;
        imageView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [tabCell addSubview:imageView];
        
        moneyLable=[[UILabel alloc] initWithFrame:CGRectMake(130, 10, 80, 20)];
        moneyLable.backgroundColor=[UIColor clearColor];
        [tabCell addSubview:moneyLable];
        
        saleTypeLable=[[UILabel alloc] initWithFrame:CGRectMake(130, 30, 80, 20)];
        saleTypeLable.font=[UIFont systemFontOfSize:13];
        saleTypeLable.alpha=0.6;
        saleTypeLable.backgroundColor=[UIColor clearColor];

        [tabCell addSubview:saleTypeLable];
        
        
        isSale=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-100, 20, 80, 20)];
        isSale.textAlignment=NSTextAlignmentRight;
        isSale.font=[UIFont systemFontOfSize:12];
        isSale.alpha=0.8;
        
        isSale.backgroundColor=[UIColor clearColor];
        [tabCell addSubview:isSale];
        
        NSDictionary *dict=[_listArry objectAtIndex:indexPath.row];
        
        timeLable2.text=[dict objectForKey:@"createtime"];
        moneyLable.text=[dict objectForKey:@"price"];
        saleTypeLable.text=[dict objectForKey:@"detail"];
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *inputDate = [inputFormatter dateFromString:[dict objectForKey:@"createtime"]];
        //NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:inputDate];
        timeLable1.text=[self weekdayStringFromDate:inputDate];
        
        
        int k=[[dict objectForKey:@"state"] intValue];
        
        if (k==0) {
            
            isSale.text=@"交易失败";
            isSale.textColor=[UIColor redColor];
            moneyLable.textColor=[UIColor redColor];
            
            
        }else if (k==1){
            
            isSale.text=@"交易成功";
            isSale.textColor=[UIColor colorWithRed:53/255.0 green:163/255.0 blue:46/255.0 alpha:1];
            moneyLable.textColor=[UIColor colorWithRed:53/255.0 green:163/255.0 blue:46/255.0 alpha:1];
            
        }else if (k==2){
            
            isSale.text=@"正在审核";
            isSale.textColor=[UIColor grayColor];
            moneyLable.textColor=[UIColor grayColor];
        }

        
        
    }
    

    return tabCell;
    
    
}

//输入参数是NSDate，输出结果是星期几的字符串。

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 60;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @"";
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    YH_AllBIillDetailViewController *billVC = [[YH_AllBIillDetailViewController alloc] init];
    billVC.title=@"账单明细";
    billVC.dict=[_listArry objectAtIndex:indexPath.row];
    billVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:billVC animated:YES];
}


#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1082) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"])
        {
            _listArry=[dic objectForKey:@"result"];

        }
    }
    
    [_theTableView reloadData];
    
    
}
  //请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    
}



@end
