//
//  YH_SaleHouseViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/3/3.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_SaleHouseViewController.h"
#import "HouseSaleViewController.h"
#import "YH_RentHouseDetailViewController.h"

#import "MJRefresh.h"

@interface YH_SaleHouseViewController ()

@end

@implementation YH_SaleHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"房屋出售";
    
    //默认第一页
    [self httpData:@"1"];
    
    _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
    
    //返回Item
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(houseSaleAction)];
    
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
    
    NSString *strJson = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1059\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"type\":\"%@\",\"page\":\"%@\",\"count\":\"%@\",\"apptype\":\"2 \"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],@"1",pageNum,@"5"];
    
    httpRequest=[[HttpRequestCalss alloc] init];
    httpRequest.delegate=self;
    [httpRequest httpRequest:strJson];
    
}

-(void)popAction
{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}
-(void)houseSaleAction
{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    HouseSaleViewController *house=[[HouseSaleViewController alloc] init];
    
    [self.navigationController pushViewController:house animated:YES];
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
        
        image1=[[UIImageView alloc] initWithFrame:CGRectMake(10, 2, theWidth-20, 150)];
        
        
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
      
        image2.image=[UIImage imageNamed:@"make5"];
        
   //     [image1 addSubview:image2];
        
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
        
        if (array!=nil && array.count!=0) {
            
            NSDictionary *dict=[array objectAtIndex:indexPath.row];
            
            [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
            
            titleLable4.text=[dict objectForKey:@"fname"];
            
            titleLable1.text=[[NSString alloc] initWithFormat:@"%@%@",[dict objectForKey:@"buildings"],[dict objectForKey:@"housetype"]];
            
            
            titleLable3.text=[dict objectForKey:@"createtime"];
            titleLable2.text=[[NSString alloc] initWithFormat:@"¥%@万/套",[dict objectForKey:@"price"] ];
            
            
        }else{
            
            [self.view.window showHUDWithText:@"系统繁忙" Type:ShowPhotoNo Enabled:YES];
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
   
        YH_RentHouseDetailViewController *houseInfo=[[YH_RentHouseDetailViewController alloc] init];
        
        NSMutableDictionary *dict=[array objectAtIndex:indexPath.row];
    
    
        houseInfo.tradetypeIs2=dict;
    
        houseInfo.ctrType=@"1";

    
        [self.navigationController pushViewController:houseInfo animated:YES];

    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
