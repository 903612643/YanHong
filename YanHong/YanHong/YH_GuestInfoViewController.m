//
//  YH_GuestInfoViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/3/16.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_GuestInfoViewController.h"
#import "YH_FollowGuestInfoViewController.h"

@interface YH_GuestInfoViewController ()

@end

@implementation YH_GuestInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"客户详情";
    
    //使用数据结构，建立表结构，不使用数据
    array = @[
              
              @{
                  @"title": @"",
                  
                  @"datas": @[@"",@""]
                  }
              
//              @{
//                  @"title" : @"",
//                  @"datas": @[@""]
//                  }
//              ,
//              
//              @{
//                  @"title" : @"",
//                  @"datas" : @[@"", @""],
//       
//                  }
              ];
    
    
    
    NSLog(@"dic=%@",_dic);
    
    _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, theHeight-120, theWidth, 60)];
    view.backgroundColor=[UIColor colorWithRed:211/255.0 green:51/255.0 blue:21/255.0 alpha:1];
    [view bringSubviewToFront:_tableView];
    [self.view addSubview:view];
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 160, 20)];
    lable.backgroundColor=[UIColor clearColor];
    lable.font=[UIFont systemFontOfSize:14];
    lable.text=@"您的专属置业顾问";
    lable.textColor=[UIColor whiteColor];
    [view addSubview:lable];
    
    UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(100, 22, 160, 30)];
    lable1.backgroundColor=[UIColor clearColor];
    lable1.text=[_dic objectForKey:@"consultantname"];
    lable1.font=[UIFont systemFontOfSize:22];
    lable1.textColor=[UIColor whiteColor];
    [view addSubview:lable1];
    [lable1 sizeToFit];
    CGFloat nameLabelCenterX = lable1.frame.size.width / 2 +130;
    CGFloat nameLabelCeneterY = lable1.frame.size.height / 2 + 22;
    lable1.center = CGPointMake(nameLabelCenterX, nameLabelCeneterY);
    UIButton *messButton=[[UIButton alloc] initWithFrame:CGRectMake(theWidth-110, 20, 30, 30)];
    messButton.titleLabel.text=@"mess2";
    [messButton addTarget:self action:@selector(callOrMessAction:) forControlEvents:UIControlEventTouchUpInside];
    [messButton setImage:[UIImage imageNamed:@"guestMessPic1"] forState:UIControlStateNormal];
    
    [view addSubview:messButton];
    
    UIButton *callButton=[[UIButton alloc] initWithFrame:CGRectMake(theWidth-50, 20, 30, 30)];
    callButton.titleLabel.text=@"call2";
    [callButton addTarget:self action:@selector(callOrMessAction:) forControlEvents:UIControlEventTouchUpInside];
    [callButton setImage:[UIImage imageNamed:@"guestCallPic1"] forState:UIControlStateNormal];
    [view addSubview:callButton];

    
    
    
}
-(void)callOrMessAction:(UIButton *)sender{

    
    if ([sender.titleLabel.text isEqualToString:@"call2"]) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[_dic objectForKey:@"consultantmobile"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }else if ([sender.titleLabel.text isEqualToString:@"call1"]){
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[_dic objectForKey:@"mobile"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }else if ([sender.titleLabel.text isEqualToString:@"mess2"]) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"sms://%@",[_dic objectForKey:@"consultantmobile"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }else if ([sender.titleLabel.text isEqualToString:@"mess1"]) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"sms://%@",[_dic objectForKey:@"mobile"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
    
    
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
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.section==0) {
            
            if (indexPath.row==0) {
            
                
                UILabel *nameLable=[[UILabel alloc] init];
                nameLable.alpha=0.8;
                nameLable.text=[_dic objectForKey:@"name"];
                nameLable.backgroundColor=[UIColor clearColor];
                nameLable.font=[UIFont systemFontOfSize:16];
                [cell.contentView addSubview:nameLable];
                
                UILabel *addLable=[[UILabel alloc] init];
                addLable.text = @"    ";
                addLable.backgroundColor=[UIColor clearColor];
                addLable.font=[UIFont systemFontOfSize:16];
                [cell.contentView addSubview:addLable];
                
                [nameLable sizeToFit];
                [addLable sizeToFit];
                CGFloat nameLabelCenterX = nameLable.frame.size.width / 2 + 20;
                CGFloat nameLabelCeneterY = nameLable.frame.size.height / 2 + 10;
                nameLable.center = CGPointMake(nameLabelCenterX, nameLabelCeneterY);
                
                CGFloat addLabelCenterX = nameLable.frame.size.width + 30 + addLable.frame.size.width / 2;
                addLable.center = CGPointMake(addLabelCenterX, nameLabelCeneterY);
                
                UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 15)];
                imageView1.backgroundColor=[UIColor clearColor];
                [addLable addSubview:imageView1];
                
                if ([[_dic objectForKey:@"gender"] isEqualToString:@"男"]) {
                    imageView1.image=[UIImage imageNamed:@"theman"];
                }else{
                    imageView1.image=[UIImage imageNamed:@"theman"];
                }


                
                UILabel *phoneLable=[[UILabel alloc] initWithFrame:CGRectMake(20, nameLabelCeneterY+20, 200, 20)];
                phoneLable.backgroundColor=[UIColor clearColor];
                phoneLable.text=[_dic objectForKey:@"mobile"];
                phoneLable.alpha=0.4;
                [cell addSubview:phoneLable];
                
                
                UIView *view=[[UIView alloc] initWithFrame:CGRectMake(theWidth-130, 10, 1, 60)];
                view.backgroundColor=[UIColor groupTableViewBackgroundColor];
                [cell addSubview:view];
                
                UIButton *messButton=[[UIButton alloc] initWithFrame:CGRectMake(theWidth-110, 25, 30, 30)];
                messButton.titleLabel.text=@"mess1";
                [messButton addTarget:self action:@selector(callOrMessAction:) forControlEvents:UIControlEventTouchUpInside];
                [messButton setImage:[UIImage imageNamed:@"guestMessPic"] forState:UIControlStateNormal];
                [cell addSubview:messButton];
                
                UIButton *callButton=[[UIButton alloc] initWithFrame:CGRectMake(theWidth-50, 25, 30, 30)];
                callButton.titleLabel.text=@"call1";
                [callButton addTarget:self action:@selector(callOrMessAction:) forControlEvents:UIControlEventTouchUpInside];
                [callButton setImage:[UIImage imageNamed:@"guestCallPic"] forState:UIControlStateNormal];
                [cell addSubview:callButton];
                

            }else{
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 200, 20)];
                lable.backgroundColor=[UIColor clearColor];
                lable.text=@"客户备注";
                [cell addSubview:lable];
               
                UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(20, 40, theWidth-40, 20)];
                lable1.backgroundColor=[UIColor clearColor];
                
                if ([[_dic objectForKey:@"remark"] isEqualToString:@""]) {
                    
                    lable1.text=@"暂无备注信息";
                    
                }else{
                    
                    lable1.text=[_dic objectForKey:@"remark"];
                }
                lable1.alpha=0.4;
                [cell addSubview:lable1];
            }
            
        }else if (indexPath.section==1){
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text=@"跟进纪录";

            
        }else if (indexPath.section==2){
            
            if (indexPath.row==0) {
                
                cell.textLabel.text=@"意向楼盘";
                
            }else{
                
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
                UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(20, 12, theWidth-40, 20)];
                lable.backgroundColor=[UIColor clearColor];
                lable.text=[_dic objectForKey:@"address"];
                [cell addSubview:lable];

                
            }
            
        }
        
        
    }
    
    return cell;
}



#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            return 80;
        }else{
            
            return 70;
        }
        
        
    }else if (indexPath.section==2){
        
        if (indexPath.row==0) {
            return 44;
        }else{
            
            return 100;
        }
        
    }else {
    
        return 44;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 20;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 20)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
//    if (indexPath.section==1) {
//        
//        YH_FollowGuestInfoViewController *foll=[[YH_FollowGuestInfoViewController alloc] init];
//        foll.dic=_dic;
//        [self.navigationController pushViewController:foll animated:YES];
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
