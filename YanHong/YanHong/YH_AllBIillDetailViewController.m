//
//  YH_AllBIillDetailViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/4/13.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_AllBIillDetailViewController.h"

@interface YH_AllBIillDetailViewController ()

@end

@implementation YH_AllBIillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    array = @[
              
              @{
                  @"title": @"",
                  
                  @"datas": @[@"",@""]
                  },
              
              @{
                  @"title" : @"",
                  @"datas": @[@"说明", @"时间",@"订单号"]
                  }
              ];

    
    _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return array.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    NSDictionary *dict=[array objectAtIndex:section];
    NSArray *arr=[dict objectForKey:@"datas"];
    
    return arr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIder = @"cell";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIder];
        
        cell.backgroundColor=[UIColor whiteColor];
        
        if (indexPath.section==0) {
            
            if (indexPath.row==0) {
                
                UILabel *saletype=[[UILabel alloc] initWithFrame:CGRectMake(20, 10,200, 20)];
                saletype.font=[UIFont systemFontOfSize:13];
                [cell addSubview:saletype];
                
                UILabel *money=[[UILabel alloc] initWithFrame:CGRectMake(20, 50,200, 30)];
                money.font=[UIFont systemFontOfSize:38];
                
                [cell addSubview:money];
                
                int k=[[_dict objectForKey:@"state"] intValue];
                
                int j=[[_dict objectForKey:@"type"] intValue];
                
                
                
                if (k==0) {
                    
                    saletype.text = @"交易失败";
                    saletype.textColor=[UIColor redColor];
                    money.textColor=[UIColor redColor];
                    
                    if (j==1) {
                        
                        money.text = [[NSString alloc] initWithFormat:@"+%@",[_dict objectForKey:@"price"]];
                        
                    }else{
                        money.text = [[NSString alloc] initWithFormat:@"-%@",[_dict objectForKey:@"price"]];
                    }
                    
                    
                    
                }else if (k==1){
                    
                    saletype.text = @"交易成功";
                    saletype.textColor=[UIColor colorWithRed:53/255.0 green:163/255.0 blue:46/255.0 alpha:1];
                    money.textColor=[UIColor colorWithRed:53/255.0 green:163/255.0 blue:46/255.0 alpha:1];
                    
                    if (j==1) {
                        
                        money.text = [[NSString alloc] initWithFormat:@"+%@",[_dict objectForKey:@"price"]];
                        
                    }else{
                        money.text = [[NSString alloc] initWithFormat:@"-%@",[_dict objectForKey:@"price"]];
                    }
                    
                    
                }else if (k==2){
                    
                    saletype.text = @"正在审核...";
                    saletype.textColor=[UIColor grayColor];
                    money.textColor=[UIColor grayColor];
                    
                    if (j==1) {
                        
                        money.text = [[NSString alloc] initWithFormat:@"+%@",[_dict objectForKey:@"price"]];
                        
                    }else{
                        money.text = [[NSString alloc] initWithFormat:@"-%@",[_dict objectForKey:@"price"]];
                    }
                    
                    
                }

                
            }else{
                
                UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 40, 40)];
                imageView.layer.cornerRadius=20;
                imageView.layer.masksToBounds=YES;
                imageView.backgroundColor=[UIColor groupTableViewBackgroundColor];
                [cell addSubview:imageView];
                
                UILabel *saleTypeLable=[[UILabel alloc] initWithFrame:CGRectMake(80, 25, 80, 20)];
                saleTypeLable.alpha=0.6;
                saleTypeLable.backgroundColor=[UIColor clearColor];
                saleTypeLable.text=[_dict objectForKey:@"detail"];
                [cell addSubview:saleTypeLable];
                
            }
            
            
        }else if (indexPath.section==1){
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(80, 20, theWidth-70, 20)];
            if (indexPath.row==0) {
                lable.text=[_dict objectForKey:@"detail"];
            }else if (indexPath.row==1){
                lable.text=[_dict objectForKey:@"createtime"];
            }else{
                lable.text=[_dict objectForKey:@"zdxqno"];
            }
            [cell addSubview:lable];
        }
        
    }
    
    NSDictionary *dict=[array objectAtIndex:indexPath.section];
    NSArray *arr=[dict objectForKey:@"datas"];
    cell.textLabel.alpha=0.6;
    cell.textLabel.text=arr[indexPath.row];
    
    return cell;
    
    
}



#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 100;
        }else{
            return 70;
        }
        
    }else{
        
        return 60;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section==0) {
        
        return 1;
        
    }else{
        
        return 15;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 15)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
