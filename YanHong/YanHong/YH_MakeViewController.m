//
//  YH_MakeViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/3/3.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_MakeViewController.h"
#import "YH_allPersonViewController.h"
#import "YH_SaleHouseViewController.h"
#import "YH_RentHouseViewController.h"
#import "UIWindow+YzdHUD.h"
#import "MJRefresh.h"
#import "YH_RentHouseDetailViewController.h"

@interface YH_MakeViewController ()

@end

@implementation YH_MakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"赚房差";
    
    _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    //默认第一页
    [self httpData:@"1"];
    
    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    
    array=[[NSMutableArray alloc] init];
    
    [self setTheRefresh];
    
}

-(void)httpData:(NSString *)pageNum
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1059\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"type\":\"%@\",\"page\":\"%@\",\"count\":\"%@\",\"apptype\":\"2 \"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],@"3",pageNum,@"5"];

    httpRequest=[[HttpRequestCalss alloc] init];
    httpRequest.delegate=self;
    [httpRequest httpRequest:strJson];
    
}

-(void)popAction
{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
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
    
    return array.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (myCell==nil) {
        
        myCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
       // tableView.separatorStyle = NO;
        
        UIImageView  *image1=[[UIImageView alloc] initWithFrame:CGRectMake(10, 2, theWidth-20, 150)];
    
        if (array!=nil && array.count!=0) {
            
            
            NSDictionary *dict=[array objectAtIndex:indexPath.row];
            
            NSString *imagStr=[dict objectForKey:@"photo1"];
            
            if (imagStr.length!=0) {
                
                NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[dict objectForKey:@"photo1"]];
                
                UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
                
                image1.image=_decodedImage;
                
            }else{
                
                image1.image=[UIImage imageNamed:@"NoPic.jpg"];
            }
            
        }

        [myCell addSubview:image1];
        
        image2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [image1 addSubview:image2];
        
        titleLable1=[[UILabel alloc] initWithFrame:CGRectMake(15, 150+5, theWidth/2+50, 30)];
        titleLable1.font=[UIFont systemFontOfSize:15];
        [myCell addSubview:titleLable1];
        
        titleLable2=[[UILabel alloc] initWithFrame:CGRectMake(15, 150+30, theWidth/2+50, 30)];
        titleLable2.font=[UIFont systemFontOfSize:15];
        titleLable2.textColor=[UIColor redColor];
        [myCell addSubview:titleLable2];
        
        titleLable3=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-138, 150+30, 120, 30)];
        titleLable3.textAlignment=NSTextAlignmentRight;
        titleLable3.font=[UIFont systemFontOfSize:11];
        titleLable3.alpha=0.5;
        [myCell addSubview:titleLable3];
        
        titleLable4=[[UILabel alloc] initWithFrame:CGRectMake(0, 110, theWidth-20-40-15, 30)];
        titleLable4.font=[UIFont systemFontOfSize:15];
        titleLable4.textAlignment=NSTextAlignmentRight;
        titleLable4.textColor=[UIColor whiteColor];
        
        [image1 addSubview:titleLable4];
        
        UIImageView  *image3=[[UIImageView alloc] initWithFrame:CGRectMake((theWidth-20)-40-10, 150-40-10, 40, 40)];
        image3.layer.cornerRadius=20;
        image3.backgroundColor=[UIColor whiteColor];
        [image1 addSubview:image3];
        
        UIImageView  *image4=[[UIImageView alloc] initWithFrame:CGRectMake((theWidth-20)-40-9, 150-40-9, 38.2, 38.2)];
        image4.layer.cornerRadius=19.1;
        image4.layer.masksToBounds=YES;
        if (array!=nil && array.count!=0) {
            
            NSDictionary *dict=[array objectAtIndex:indexPath.row];
            
            NSString *imagStr=[dict objectForKey:@"headpicture"];
            
            if (imagStr.length!=0) {
                
                NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[dict objectForKey:@"headpicture"]];
                
                UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
                
                image4.image=_decodedImage;
                
            }else{
                
                image4.image=[UIImage imageNamed:@"theHead"];
            }
            
        }

        [image1 addSubview:image4];
        
        UIImageView  *localeImage=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth-70, 150+15, 12, 18)];
        localeImage.backgroundColor=[UIColor clearColor];
        localeImage.image=[UIImage imageNamed:@"localImage"];
        [myCell addSubview:localeImage];
        
        UILabel  *titleLable5=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-50, 150+15, 50, 15)];
        titleLable5.text=@"0.5km";
        titleLable5.alpha=0.4;
        titleLable5.font=[UIFont systemFontOfSize:11];
        titleLable5.textAlignment=NSTextAlignmentLeft;
        [myCell addSubview:titleLable5];


    }
    
    if (array!=nil && array.count!=0) {
        
        [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
        
        NSDictionary *dict=[array objectAtIndex:indexPath.row];
        
        titleLable4.text=[dict objectForKey:@"fname"];
        
        titleLable1.text=[[NSString alloc] initWithFormat:@"%@%@",[dict objectForKey:@"buildings"],[dict objectForKey:@"housetype"]];
        
        
        if ([[dict objectForKey:@"tradetype"] isEqualToString:@"2"]) {
            
            image2.image=[UIImage imageNamed:@"make4"];
            titleLable3.text=[dict objectForKey:@"createtime"];
            titleLable2.text=[[NSString alloc] initWithFormat:@"¥%@元/月",[dict objectForKey:@"price"] ];
            
        }else{
            
            titleLable3.text=[dict objectForKey:@"createtime"];
            titleLable2.text=[[NSString alloc] initWithFormat:@"¥%@万/套",[dict objectForKey:@"price"] ];
            image2.image=[UIImage imageNamed:@"make5"];
            
        }
        
        
    }

    return myCell;

}

#pragma mark UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 230;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 140;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 125)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIView *subview=[[UIView alloc] initWithFrame:CGRectMake(0, 125, theWidth, 15)];
    subview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [view addSubview:subview];
    
    UIButton *button1=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-50*3)/4, 60, 50,50)];
    button1.backgroundColor=[UIColor clearColor];
    [button1 setImage:[UIImage imageNamed:@"make1"] forState:UIControlStateNormal];
    [view addSubview:button1];
    
    UIButton *button2=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-50*3)/4*2+50, 60, 55,50)];
   
    [button2 setImage:[UIImage imageNamed:@"make2"] forState:UIControlStateNormal];
    [view addSubview:button2];
    
    UIButton *button3=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-50*3)/4*3+50*2, 60, 50,50)];
    [button3 setImage:[UIImage imageNamed:@"make3"] forState:UIControlStateNormal];
    [view addSubview:button3];
    
    UIButton *button4=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, (theWidth-10*4)/3,100)];
    button4.backgroundColor=[UIColor clearColor];
    [button4 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button4];
    
    UIButton *button5=[[UIButton alloc] initWithFrame:CGRectMake(10*2+(theWidth-10*4)/3, 10, (theWidth-10*4)/3,100)];
    button5.backgroundColor=[UIColor clearColor];
    [button5 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button5];
    
    UIButton *button6=[[UIButton alloc] initWithFrame:CGRectMake(10*3+(theWidth-10*4)/3*2, 10, (theWidth-10*4)/3,100)];
    button6.backgroundColor=[UIColor clearColor];
    [button6 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button6];
    

    NSArray *titleArr=@[@"全名经纪人",@"周租月租",@"房屋买卖"];
    NSArray *titleArr1=@[@"人脉变财富，成交赚佣1%",@"比酒店更便宜，出游新选择",@"二手房交易市场"];
    
    for (int i=0; i<3; i++) {
        
        UILabel *lable=[[UILabel alloc] init];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.font=[UIFont systemFontOfSize:14];
        lable.text=titleArr[i];
        lable.backgroundColor=[UIColor clearColor];
        [view addSubview:lable];
        
        UILabel *lable1=[[UILabel alloc] init];
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.font=[UIFont systemFontOfSize:8];
        lable1.text=titleArr1[i];
        lable1.alpha=0.4;
        lable1.backgroundColor=[UIColor clearColor];
        [view addSubview:lable1];
        
        if (i==0) {
            
            lable.frame=CGRectMake((theWidth-60*3)/4*(i+1)+60*i-20, 15, 100, 20);
            lable.textColor=[UIColor redColor];
            lable1.frame=CGRectMake((theWidth-120*3)/4*(i+1)+120*i+10, 35, 120, 20);
            
            
        }else  if(i==2){
            
            lable.frame=CGRectMake((theWidth-60*3)/4*(i+1)+60*i-2, 15, 60, 20);
            lable.textColor=[UIColor colorWithRed:48/255.0 green:118/255.0 blue:188/255.0 alpha:1];
            lable1.frame=CGRectMake((theWidth-120*3)/4*(i+1)+120*i-18, 35, 120, 20);
            
        }else{
            lable.frame=CGRectMake((theWidth-60*3)/4*(i+1)+60*i, 15, 60, 20);
            lable.textColor=[UIColor colorWithRed:100/255.0 green:184/255.0 blue:0/255.0 alpha:1];
            lable1.frame=CGRectMake((theWidth-120*3)/4*(i+1)+120*i, 35, 120, 20);
        }
        
            
     
    }
    
    
    return view;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    YH_RentHouseDetailViewController *houseInfo=[[YH_RentHouseDetailViewController alloc] init];
    
    houseInfo.hidesBottomBarWhenPushed=YES;
    
    
    NSMutableDictionary *dict=[array objectAtIndex:indexPath.row];
    
    
    if ([[dict objectForKey:@"tradetype"] isEqualToString:@"2"]) {
        
        houseInfo.ctrType=@"2";
        
    }else if ([[dict objectForKey:@"tradetype"] isEqualToString:@"1"]){
        
        houseInfo.ctrType=@"1";
    
    }
    
    houseInfo.tradetypeIs2=dict;
    
    [self.navigationController pushViewController:houseInfo animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

-(void)button1Action
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    YH_allPersonViewController *all=[[YH_allPersonViewController alloc] init];
    [self.navigationController pushViewController:all animated:YES];
}
-(void)button2Action
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    YH_RentHouseViewController *all=[[YH_RentHouseViewController alloc] init];
    [self.navigationController pushViewController:all animated:YES];
}

-(void)button3Action
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    YH_SaleHouseViewController *all=[[YH_SaleHouseViewController alloc] init];
    [self.navigationController pushViewController:all animated:YES];
}





#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSMutableDictionary alloc] initWithDictionary:json];
    
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
    
    if (COMMANDINT==COMMAND1060){
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            if (_thePageNum!=1) {
                
                [array addObjectsFromArray:[dic objectForKey:@"result"]];
                
            }else{
                
                array=[dic objectForKey:@"result"];
                
            }
            
            if (array.count!=0) {
                
                NSMutableArray *thearr=[[NSMutableArray alloc] init];
                
                for (NSDictionary *dict in array) {
                    
                    NSString *imageStr=[dict objectForKey:@"photo1"];
                    
                    if (imageStr.length!=0) {
                        
                        [thearr addObject:dict];
                        
                    }
                    
                }
                
                array = thearr;
                
            }else{
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, theHeight/2-100, theWidth, 30)];
                lable.alpha=0.4;
                lable.textAlignment=NSTextAlignmentCenter;
                lable.font=[UIFont systemFontOfSize:18];
                lable.text=@"去发布房源信息？";
                _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
                [_tableView addSubview:lable];
                
                
            }

        }else{
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
        }
        
    }
    
    [_tableView reloadData];
    
    
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
    
}


-(void)setTheRefresh
{
    [_tableView addHeaderWithTarget:self action:@selector(theHeadAction)];
    
    [_tableView addFooterWithTarget:self action:@selector(theFooterAction)];
    
    
}
-(void)theHeadAction
{
    _thePageNum=1;
    NSLog(@"_thePageNum=%ld",(long)_thePageNum);
    [self httpData:[[NSString alloc] initWithFormat:@"%ld",(long)_thePageNum]];
    
}
-(void)theFooterAction
{
    
    _thePageNum=_thePageNum+1;
    NSLog(@"_thePageNum=%ld",(long)_thePageNum);
    [self httpData:[[NSString alloc] initWithFormat:@"%ld",(long)_thePageNum]];
    
}



@end
