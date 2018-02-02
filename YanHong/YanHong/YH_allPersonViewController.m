//
//  YH_allPersonViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/3/1.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_allPersonViewController.h"
#import "SuggestViewController.h"
#import "YH_MyGuestViewController.h"
#import "YH_WalletViewController.h"
#import "WebViewController.h"
#import "UIImageView+AFNetworking.h"

@interface YH_allPersonViewController ()

@end

@implementation YH_allPersonViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //   GCD  第六中创建线程方法
    // 创建一个队列
    dispatch_queue_t queue = dispatch_queue_create("YH", nil);
    //    创建异步线程
    dispatch_async(queue, ^{
        
        [self httpData];
        
        //      回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            self.title=@"全民经纪人";
            
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:47/255.0 green:53/255.0 blue:61/255.0 alpha:1.0];
            
            self.navigationController.navigationBar.translucent = NO; //使导航栏与界面的颜色保持一致
            [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
   
            //返回Item
            self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
            theTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight-64)];
            theTableView.delegate=self;
            theTableView.dataSource=self;
    
            [self.view addSubview:theTableView];

        });
    });
 
}
-(void)httpData
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //请求数据
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1043\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\"}",dateString];
    
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];

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


#pragma  mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return SaleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (myCell==nil) {
        
        myCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        tableView.separatorStyle = NO;
        
                
        if (indexPath.row==0) {
            
            UIImageView *imageView=[[UIImageView alloc ] initWithFrame:CGRectMake(10, 22, 90, 30)];
            imageView.image=[UIImage imageNamed:@"theImagejie"];
            [myCell addSubview:imageView];
            
            imageView1=[[UIImageView alloc ] initWithFrame:CGRectMake(10, 60, theWidth-20, 170)];
           // imageView1.image=[UIImage imageNamed:@"houseBgm.jpg"];
            [myCell addSubview:imageView1];
            
            UIImageView *subimageView=[[UIImageView alloc ] initWithFrame:CGRectMake((theWidth-70)-20,170-15-60 , 60, 60)];
            subimageView.image=[UIImage imageNamed:@"subImage"];
            //[imageView1 addSubview:subimageView];
            
            titlelable4=[[UILabel alloc] initWithFrame:CGRectMake(15, 5, 30, 20)];
            titlelable4.text=@"佣金";
            titlelable4.textAlignment=NSTextAlignmentCenter;
            titlelable4.font=[UIFont systemFontOfSize:11];
            titlelable4.textColor=[UIColor whiteColor];
            //[subimageView addSubview:titlelable4];
            
            titlelable5=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-100, 170-50, 80, 20)];
            titlelable5.textAlignment=NSTextAlignmentCenter;
            titlelable5.font=[UIFont systemFontOfSize:11];
            titlelable5.textColor=[UIColor whiteColor];
          //  [imageView1 addSubview:titlelable5];

            
            
            UILabel *titlelable6=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 90, 20)];
            titlelable6.text=@"在售楼盘";
            titlelable6.textColor=[UIColor whiteColor];
            titlelable6.backgroundColor=[UIColor clearColor];
            [imageView addSubview:titlelable6];

            
            titlelable1=[[UILabel alloc] initWithFrame:CGRectMake(10, 240, theWidth/2+20, 20)];
            titlelable1.font=[UIFont systemFontOfSize:15];
            titlelable1.backgroundColor=[UIColor clearColor];
            [myCell addSubview:titlelable1];
            
            titlelable2=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-100, 240, 100, 20)];
            titlelable2.backgroundColor=[UIColor clearColor];
            titlelable2.textColor=PublieCorlor;
            titlelable2.font=[UIFont systemFontOfSize:15];
            [myCell addSubview:titlelable2];
            
            UILabel *titlelable3=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-100-26, 242, 25, 20)];
            titlelable3.backgroundColor=[UIColor clearColor];
            titlelable3.text=@"均价";
            titlelable3.font=[UIFont systemFontOfSize:11];
            [myCell addSubview:titlelable3];
            
            NSDictionary *dict=[SaleArray objectAtIndex:indexPath.row];
            
            NSString *urlStr = [dict objectForKey:@"bigImageUrl"];
            
            NSURL *url=[NSURL URLWithString:urlStr];
            
            [imageView1 setImageWithURL:url placeholderImage:[UIImage imageNamed:@"NoPic.jpg"]];
            
            titlelable1.text=[[NSString alloc] initWithFormat:@"%@%@",[dict objectForKey:@"projectCity"],[dict objectForKey:@"projectName"]];
            
            
            titlelable2.text=[[NSString alloc] initWithFormat:@"¥%@/㎡",[dict objectForKey:@"avaPrice"] ];
            
            titlelable5.text=[[NSString alloc] initWithFormat:@"%@",[dict objectForKey:@"commScale"] ];

            
        }else{
            
            imageView1=[[UIImageView alloc ] initWithFrame:CGRectMake(10, 0, theWidth-20, 170)];
           //imageView1.image=[UIImage imageNamed:@"houseBgm.jpg"];
            [myCell addSubview:imageView1];
            
            UIImageView *subimageView=[[UIImageView alloc ] initWithFrame:CGRectMake((theWidth-70)-20,170-15-60 , 60, 60)];
            subimageView.image=[UIImage imageNamed:@"subImage"];
           // [imageView1 addSubview:subimageView];
            
            titlelable4=[[UILabel alloc] initWithFrame:CGRectMake(15, 5, 30, 20)];
            titlelable4.text=@"佣金";
            titlelable4.textAlignment=NSTextAlignmentCenter;
            titlelable4.font=[UIFont systemFontOfSize:11];
            titlelable4.textColor=[UIColor whiteColor];
            //[subimageView addSubview:titlelable4];
            
            titlelable5=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-100, 170-50, 80, 20)];
            titlelable5.textAlignment=NSTextAlignmentCenter;
            titlelable5.font=[UIFont systemFontOfSize:11];
            titlelable5.textColor=[UIColor whiteColor];
           // [imageView1 addSubview:titlelable5];


            titlelable1=[[UILabel alloc] initWithFrame:CGRectMake(10, 180, theWidth/2+20, 20)];
        
            titlelable1.font=[UIFont systemFontOfSize:15];
            titlelable1.backgroundColor=[UIColor clearColor];
            [myCell addSubview:titlelable1];
            
            titlelable2=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-100, 180, 100, 20)];
            titlelable2.backgroundColor=[UIColor clearColor];
            titlelable2.textColor=PublieCorlor;
            titlelable2.font=[UIFont systemFontOfSize:15];
        
            [myCell addSubview:titlelable2];
            
            UILabel *titlelable3=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-100-26, 182, 25, 20)];
            titlelable3.backgroundColor=[UIColor clearColor];
            titlelable3.text=@"均价";
            titlelable3.font=[UIFont systemFontOfSize:11];
            [myCell addSubview:titlelable3];
            
            
            NSDictionary *dict=[SaleArray objectAtIndex:indexPath.row];
            
            NSString *urlStr = [dict objectForKey:@"bigImageUrl"];
            
            NSURL *url=[NSURL URLWithString:urlStr];
            
            [imageView1 setImageWithURL:url placeholderImage:[UIImage imageNamed:@"NoPic.jpg"]];
            
            titlelable1.text=[[NSString alloc] initWithFormat:@"%@%@",[dict objectForKey:@"projectCity"],[dict objectForKey:@"projectName"]];
            
            titlelable2.text=[[NSString alloc] initWithFormat:@"¥%@/㎡",[dict objectForKey:@"avaPrice"] ];
            
            titlelable5.text=[[NSString alloc] initWithFormat:@"%@",[dict objectForKey:@"commScale"] ];

            
            
            
        }
        
    }
    
    
    return myCell;
    
}

#pragma  mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row==0) {
        return 280;
    }else{
        return 220;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.001;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 100)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *subview=[[UIView alloc] initWithFrame:CGRectMake(0, 100, theWidth, 20)];
    subview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [view addSubview:subview];
    
    UIButton *button1=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-50*4)/5, (100-50)/2-10, 50,50)];
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:[UIImage imageNamed:@"button1"] forState:UIControlStateNormal];
    [view addSubview:button1];
    
    UIButton *button2=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-50*4)/5*2+50, (100-50)/2-10, 50,50)];
    [button2 setImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
    
    UIButton *button3=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-50*4)/5*3+50*2, (100-50)/2-10, 50,50)];
    [button3 setImage:[UIImage imageNamed:@"button3"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button3];
    
    UIButton *button4=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-50*4)/5*4+50*3, (100-50)/2-10, 50,50)];
    [button4 setImage:[UIImage imageNamed:@"button4"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button4];
    
    NSArray *titleArr=@[@"推荐客户",@"我的客户",@"我的钱包",@"佣金细则"];
    for (int i=0; i<4; i++) {
        
        UILabel *lable=[[UILabel alloc] init];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.font=[UIFont systemFontOfSize:14];
        lable.text=titleArr[i];
        lable.backgroundColor=[UIColor clearColor];
        [view addSubview:lable];
        if(i==0){
            
            lable.frame=CGRectMake((theWidth-60*4)/5*(i+1)+60*i+3, (100-50)/2-10+50, 60, 20);
            
        }else if(i==3){
            
            lable.frame=CGRectMake((theWidth-60*4)/5*(i+1)+60*i-2, (100-50)/2-10+50, 60, 20);
        }else{
            lable.frame=CGRectMake((theWidth-60*4)/5*(i+1)+60*i, (100-50)/2-10+50, 60, 20);
        }
        
        
    }

    
    return view;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)button1Action
{
    SuggestViewController *sug=[[SuggestViewController alloc] init];
    sug.title=@"推荐客户";
    [self.navigationController pushViewController:sug animated:YES];
    
}
-(void)button2Action
{
//    YH_MyGuestViewController *myG=[[YH_MyGuestViewController alloc] init];
//    myG.title=@"我的客户";
//    [self.navigationController pushViewController:myG animated:YES];
    
    YH_MyGuestViewController *guest=[[YH_MyGuestViewController alloc] init];
    
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:guest];

    guest.title=@"客户管理";
    
    [self presentViewController:nac animated:YES completion:^{
        
    }];

    
}

-(void)button3Action
{
    YH_WalletViewController *wall=[[YH_WalletViewController alloc ] init];
    wall.title=@"我的钱包";
    [self.navigationController pushViewController:wall animated:YES];
    
    
}
-(void)button4Action
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    //佣金细则
    NSString *strJson2 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1019\",\"uid\":\"%@\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"keyname\":\"c106\",\"apptype\":\"2\"}",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],dateString];
    
    //postter
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
    theTableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);
    
 if (COMMANDINT==COMMAND1020){
     
     WebViewController *web=[[WebViewController alloc ] init];
     
     web.title=@"佣金细则";
     web.HouesStr=[dic objectForKey:@"url"];
     
     [self.navigationController pushViewController:web animated:YES
      ];
     
 }else if (COMMANDINT==COMMAND1044)
 {
     SaleArray=[dic objectForKey:@"result"];
 }
    
    [theTableView reloadData];
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    // NSLog(@"error = %@",error);
  
}

@end
