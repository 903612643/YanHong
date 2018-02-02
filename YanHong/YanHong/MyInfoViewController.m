//
//  MyInfoViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/14.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "MyInfoViewController.h"
#import "WebViewController.h"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

static int theFont;

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //手机号码正确，请求数据
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1055\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"count\":\"20\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    
    //postter
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S

        
        theFont=18;
        
        
    }else if (IS_IPHONE_5) {  // 5, 5S

        theFont=18;
        
    }else if (IS_IPHONE_6) {  // 6
        

        
        theFont=18;
        
    }else if (IS_IPHONE_6P) {  // 6P
        
        
        theFont=18;
    }

    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];

    
    
    
}
-(void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    NSString *resultStr=[[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"result"] ];
    
    if ([dic objectForKey:@"result"]!=nil && resultStr.length!=0) {
    
        NSArray *array=[[NSArray alloc] initWithArray:[dic objectForKey:@"result"]];
        
        return array.count;

    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (myCell==nil) {
        
        myCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        myCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
        imageView.image=[UIImage imageNamed:@"infoPic"];
        imageView.backgroundColor=[UIColor clearColor];
        [myCell addSubview:imageView];
        
    
        _theLable1=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, theWidth/2, 20)];
        _theLable1.font=[UIFont systemFontOfSize:theFont-3];
        _theLable1.backgroundColor=[UIColor clearColor];
        
        [myCell addSubview:_theLable1];
        
        _theLable2=[[UILabel alloc] initWithFrame:CGRectMake(50, 30, theWidth-70, 25)];
        _theLable2.font=[UIFont systemFontOfSize:theFont-6];
        _theLable2.alpha=0.4;
        _theLable2.backgroundColor=[UIColor clearColor];
        
        [myCell addSubview:_theLable2];
        
        _theLable3=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-100, 10, 80, 20)];
        _theLable3.font=[UIFont systemFontOfSize:theFont-6];
        _theLable3.alpha=0.4;
        _theLable3.textAlignment=NSTextAlignmentRight;
        _theLable3.backgroundColor=[UIColor clearColor];
        [myCell addSubview:_theLable3];
        
        NSString *resultStr=[[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"result"] ];
        
        if ([dic objectForKey:@"result"]!=nil && resultStr.length!=0) {
            
            arry=[[NSArray alloc] initWithArray:[dic objectForKey:@"result"]];
            
            
            if (arry!=nil && arry.count!=0) {
                
                NSDictionary *dict=[arry objectAtIndex:indexPath.row];
                
                _theLable1.text=[dict objectForKey:@"title"];
                _theLable2.text=[dict objectForKey:@"content"];
                _theLable3.text=[dict objectForKey:@"disdate"];
                
                
                
            }
            
        }


        
    }
    
    
    return myCell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 60;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

    
    NSDictionary *dict=[arry objectAtIndex:indexPath.row];
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //进入下载我的客户信息
    NSString *strJson2 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1087\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"mid\":\"%@\",\"apptype\":\"2\"}",dateString,[dict objectForKey:@"id"]];
    
    //post 请求
    
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url2=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url2 parameters:strJson2 success:^(id responseObject) {
        
    } fail:^{
        
    }];

    
}

#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSDictionary alloc] initWithDictionary:json];

    NSLog(@"dic=%@",dic);
    
    NSArray *theA=[dic objectForKey:@"result"];
    
    NSLog(@"theA.count=%ld",theA.count);
    
    
    self.title=[[NSString alloc] initWithFormat:@"消息(%lu)",(unsigned long)theA.count];
    
    if ([[dic objectForKey:@"errcode"] isEqualToString:@"001"]) {
        
        UIView *addview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight-60)];
        addview.tag=101;
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0,((theHeight-60)-30)/2, theWidth, 30)];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.font=[UIFont systemFontOfSize:20];
        lable.alpha=0.4;
        lable.text=@"还没有数据";
        [addview addSubview:lable];
        addview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_theTableView addSubview:addview];
    }
    
    if (COMMANDINT==COMMAND1088) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            WebViewController *spe=[[WebViewController alloc] init];
            spe.title=@"消息详情";
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:spe];
            spe.HouesStr=[dic objectForKey:@"url"];
            [self presentViewController:navigation animated:YES completion:nil];

            
        }
    }
    
    
    
    
    
    
    [_theTableView reloadData];
    
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
  
    // NSLog(@"error = %@",error);
    
}



@end
