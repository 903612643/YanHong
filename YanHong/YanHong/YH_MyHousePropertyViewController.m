//
//  YH_MyHousePropertyViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/4/7.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_MyHousePropertyViewController.h"
#import "HouesBinDingViewController.h"

@interface YH_MyHousePropertyViewController ()

@end

@implementation YH_MyHousePropertyViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
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
    NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1103\",\"errcode\":\"000\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"username\":\"%@\",\"apptype\":\"2\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
//        
//    } fail:^{
//        
//    }];

}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    self.hidesBottomBarWhenPushed=YES;
    
    array=[[NSMutableArray alloc] init];
    
    [array addObject:@""];
    [array addObject:@""];
    [array addObject:@""];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return array.count+1;


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIder = @"cell";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIder];
            
        cell.backgroundColor=[UIColor whiteColor];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        tableView.separatorStyle = NO;
        
        if (indexPath.row!=array.count) {
            
            UIImageView *bagView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 15, theWidth-20, 125)];
            
            //bagView.backgroundColor=[UIColor colorWithRed:22/255.0 green:144/255.0 blue:149/255.0 alpha:1];
            
            bagView.image=[UIImage imageNamed:@"bagViewPic"];
            
            bagView.layer.cornerRadius=8;
            bagView.layer.masksToBounds=YES;

            [cell addSubview:bagView];
            
            UILabel *lineLable=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, (theWidth-20)-20, 1)];
            lineLable.alpha=0.05;
            lineLable.backgroundColor=[UIColor blackColor];
            [bagView addSubview:lineLable];
            
            UILabel *houseName=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, (theWidth-20)-40, 40)];
            
            houseName.textColor=[UIColor whiteColor];
            houseName.font=[UIFont systemFontOfSize:23];
            [bagView addSubview:houseName];
            
            UILabel *houseNo=[[UILabel alloc] initWithFrame:CGRectMake(10, ((125-40)-30*2)/3+40+2, (theWidth-20)-80, 30)];
            
            houseNo.textColor=[UIColor whiteColor];
            houseNo.font=[UIFont systemFontOfSize:16];
            [bagView addSubview:houseNo];
            
            UILabel *houseTime=[[UILabel alloc] initWithFrame:CGRectMake(10, ((125-40)-30*2)/3*2+30+40-5, (theWidth-20)-80, 30)];
            houseTime.textColor=[UIColor whiteColor];
            houseTime.font=[UIFont systemFontOfSize:12];
            [bagView addSubview:houseTime];
            
            //交物业费
            UIButton *payButton=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-20)-120, ((125-40)-30*2)/3*2+30+40-5, 100, 30)];
            payButton.titleLabel.font=[UIFont systemFontOfSize:14];
            payButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
            [payButton setTitleColor:[UIColor colorWithRed:121/255.0 green:235/255.0 blue:221/255.0 alpha:1] forState:UIControlStateNormal];
            [payButton setTitle:@"交物业费" forState:UIControlStateNormal ];
            [payButton addTarget:self action:@selector(payAction) forControlEvents: UIControlEventTouchUpInside ];
            
          //  [bagView addSubview:payButton];
            
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake((theWidth-20)-20, ((125-40)-30*2)/3*2+30+41, 15, 18)];
            imageView.image=[UIImage imageNamed:@"housePayPic"];
          //  [bagView addSubview:imageView];
            
            //删除
            _delButton=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-20)-30, 5, 25, 25)];
            //[delButton setImage:[UIImage imageNamed:@"housedelPic"] forState:UIControlStateNormal];
            _delButton.backgroundColor=[UIColor clearColor];
            [_delButton setTitle:@"×" forState:UIControlStateNormal];
            _delButton.titleLabel.font=[UIFont systemFontOfSize:32];
            [_delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _delButton.tag=indexPath.row;
            [_delButton addTarget:self action:@selector(delAction:) forControlEvents: UIControlEventTouchUpInside ];
           // [bagView addSubview:_delButton];
            
           if (array.count!=0) {
            
                    
                
                NSDictionary *dict=[array objectAtIndex:indexPath.row];
               // houseName.text=[dict objectForKey:@"projectname"];
                    
                    houseName.text=@"海港小镇";
                
                
//                houseNo.text=[[NSString alloc] initWithFormat:@"%@号楼  %@房",[dict objectForKey:@"buildno"],[dict objectForKey:@"roomno"] ];
//                
//                
//                houseTime.text=[[NSString alloc] initWithFormat:@"%@  交房",[dict objectForKey:@"signdate"] ];
                    houseNo.text=@"9号楼  9房";
                    
                    
                    houseTime.text=@"20201225交房";

            }
        
            
        }else{
            //添加
            UIButton *addHouse=[UIButton buttonWithType:UIButtonTypeCustom];
            addHouse.layer.borderWidth = 1.5;
            addHouse.layer.borderColor = [UIColor colorWithRed:217/255.0 green:219/255.0 blue:219/255.0 alpha:1].CGColor;
            addHouse.layer.cornerRadius = 6;
            addHouse.titleLabel.font=[UIFont systemFontOfSize:16];
            [addHouse setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            addHouse.frame=CGRectMake(10, 30, theWidth-20,40);
            [addHouse setTitle:@"➕添加新绑定" forState:UIControlStateNormal ];
            [addHouse addTarget:self action:@selector(addHouseAction) forControlEvents: UIControlEventTouchUpInside ];
            [cell addSubview:addHouse];

        }
        
    }
    
    return cell;
}



#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (indexPath.row!=array.count) {
            
            return 140;
    }else{
        
        return 500;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)payAction

{
    
}

-(void)addHouseAction
{
    HouesBinDingViewController *mid=[[HouesBinDingViewController alloc] init];
    mid.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:mid animated:YES];
}

-(void)delAction:(UIButton *)sender
{
    NSLog(@"ldlkfljksdjklfljk=%ld",(long)sender.tag);
    [array removeObjectAtIndex:sender.tag];
    [_tableView reloadData];
}


#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSDictionary alloc] initWithDictionary:json];

    if ([[dic objectForKey:@"result"] isKindOfClass:[NSNull class]]) {
        
    }else{
        
       //  array=[[NSArray alloc] initWithArray:[dic objectForKey:@"result"]];
    }
    
     NSLog(@"委托后的数据：%@",array);
    
    [_tableView reloadData];
    
    
    
}
//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{

    
    
}


@end
