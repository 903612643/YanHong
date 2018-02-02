//
//  YH_FriendInfoViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/3/15.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_FriendInfoViewController.h"
#import "YH_FriendRemarksViewController.h"
#import "YH_FriendViewController.h"

@interface YH_FriendInfoViewController ()

@end

@implementation YH_FriendInfoViewController


- (void)tongzhi:(NSNotification *)text{
    
    [_dict removeObjectForKey:@"nickname"];
    
    [_dict setObject:text.userInfo[@"friname"] forKey:@"nickname"];
    nameLable.text=text.userInfo[@"friname"];
    [nameLable sizeToFit];
    [addLable sizeToFit];
    
    CGFloat nameLabelCenterX = nameLable.frame.size.width / 2 + 90;
    CGFloat nameLabelCeneterY = nameLable.frame.size.height / 2 + 10;
    nameLable.center = CGPointMake(nameLabelCenterX, nameLabelCeneterY);
    
    CGFloat addLabelCenterX = nameLable.frame.size.width + 100 + addLable.frame.size.width / 2;
    addLable.center = CGPointMake(addLabelCenterX, nameLabelCeneterY);
    
    UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 15)];
    imageView1.backgroundColor=[UIColor clearColor];
    [addLable addSubview:imageView1];
    
    NSString *sexStr=[[NSString alloc] initWithFormat:@"%@",[_dict objectForKey:@"gender"] ];
    
    if ([sexStr isEqual:@"1"]|| [sexStr isEqual:@"(null)"] ||sexStr.length==0) {
        
        imageView1.image=[UIImage imageNamed:@"theman"];
        
    }else{
        
        imageView1.image=[UIImage imageNamed:@"thewoman"];
    }
    

  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"notificationfriname" object:nil];
    
    NSLog(@"dict=%@",_dict);
    
    
    array = @[
                      
                      @{
                          @"title": @"",
            
                          @"datas": @[@""]
                          },
                      
                      @{
                         @"title" : @"",
                          @"datas": @[@"设置备注和标签", @"电话号码"]
                          },
                      
                      @{
                          @"title" : @"",
                          @"datas" : @[@"朋友圈"],
                       @"images":@[@"discover_friend"]
                          
                          }
                      ];
    
    
    
    
    _tableViiew.backgroundColor=[UIColor groupTableViewBackgroundColor];

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
            
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
            
            NSString *imageStr=[_dict objectForKey:@"headpicture"];
            
            if (imageStr.length!=0) {
                
                NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[_dict objectForKey:@"headpicture"]];
                
                UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
                
                imageView.image=_decodedImage;
                
            }else{
                
                imageView.image=[UIImage imageNamed:@"theHead"];
                
            }
            
            [cell addSubview:imageView];
            
            nameLable=[[UILabel alloc] init];
            nameLable.alpha=0.8;
            nameLable.text=[_dict objectForKey:@"nickname"];
            nameLable.backgroundColor=[UIColor clearColor];
            nameLable.font=[UIFont systemFontOfSize:16];
            [cell.contentView addSubview:nameLable];
            
            addLable=[[UILabel alloc] init];
            addLable.text = @"    ";
            addLable.backgroundColor=[UIColor clearColor];
            addLable.font=[UIFont systemFontOfSize:16];
            [cell.contentView addSubview:addLable];
            
            [nameLable sizeToFit];
            [addLable sizeToFit];
            CGFloat nameLabelCenterX = nameLable.frame.size.width / 2 + 90;
            CGFloat nameLabelCeneterY = nameLable.frame.size.height / 2 + 10;
            nameLable.center = CGPointMake(nameLabelCenterX, nameLabelCeneterY);

            CGFloat addLabelCenterX = nameLable.frame.size.width + 100 + addLable.frame.size.width / 2;
            addLable.center = CGPointMake(addLabelCenterX, nameLabelCeneterY);
            
            UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 15)];
            imageView1.backgroundColor=[UIColor clearColor];
            [addLable addSubview:imageView1];
            
            NSString *sexStr=[[NSString alloc] initWithFormat:@"%@",[_dict objectForKey:@"gender"] ];

            if ([sexStr isEqual:@"1"]|| [sexStr isEqual:@"(null)"] ||sexStr.length==0) {

                imageView1.image=[UIImage imageNamed:@"theman"];

            }else{

                imageView1.image=[UIImage imageNamed:@"thewoman"];
            }
            
            
            NSArray *TitleArray=@[@"经纪人√",@"实名",@"业主",@"驴友",@"导游"];
            
            for (int i=0; i<5; i++) {
                
                if (i==0) {
                    
                    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(90, 42, 60, 20)];
                    lable.tag=0;
                    lable.text=TitleArray[i];
                    lable.textAlignment=NSTextAlignmentCenter;
                    lable.textColor=[UIColor colorWithRed:91/255.0 green:177/255.0 blue:97/255.0 alpha:1];
                    lable.layer.borderWidth = 1;
                    lable.layer.borderColor = [UIColor colorWithRed:91/255.0 green:177/255.0 blue:97/255.0 alpha:1].CGColor;
                    lable.layer.cornerRadius = 4;
                    lable.font=[UIFont systemFontOfSize:13];
                    [cell addSubview:lable];
                    
                }else{
                    
                    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(90+60+10*i+35*(i-1), 42, 35, 20)];
                    lable.tag=i;
                    lable.alpha=0.6;
                    lable.layer.borderWidth = 1;
                    lable.layer.borderColor = [UIColor grayColor].CGColor;
                    lable.layer.cornerRadius = 4;
                    lable.textColor=[UIColor grayColor];
                    lable.textAlignment=NSTextAlignmentCenter;
                    lable.font=[UIFont systemFontOfSize:13];
                    lable.text=TitleArray[i];
                    [cell addSubview:lable];
                    
                    
                }
                
                
                
            }
            
      
        }else if (indexPath.section==1){
            
            if (indexPath.row==0) {
                
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
            }else{
                
                UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(100, 12, 200, 20)];
                lable2.backgroundColor=[UIColor clearColor];
                lable2.textColor=[UIColor colorWithRed:82/255.0 green:102/255.0 blue:140/255.0 alpha:1];
                lable2.text=[_dict objectForKey:@"phone1"];
                lable2.font=[UIFont systemFontOfSize:14];
                [cell addSubview:lable2];

            }
            
            UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(20, 12, 200, 20)];
            lable1.backgroundColor=[UIColor clearColor];
            lable1.font=[UIFont systemFontOfSize:14];
            [cell addSubview:lable1];
            
            
            NSDictionary *dict=array[indexPath.section];
            
            NSArray *arr=[dict objectForKey:@"datas"];
            
            lable1.text=[arr objectAtIndex:indexPath.row];
            
     
        }else if (indexPath.section==2){
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 30, 30)];
            
            [cell addSubview:imageView];
            
            
            UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(60, 12, 100, 20)];
            lable1.backgroundColor=[UIColor clearColor];
            lable1.font=[UIFont systemFontOfSize:14];
            [cell addSubview:lable1];
            
            
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(theWidth-70, 2, 40, 40)];
            view.backgroundColor=[UIColor clearColor];
            [cell addSubview:view];
            
            UIImageView *imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 34, 34)];
            imageView1.backgroundColor=[UIColor greenColor];
            imageView1.image=[UIImage imageNamed:@"theHead"];
          //  [view addSubview:imageView1];
            
            UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(35, 0, 8, 8)];
            lable2.backgroundColor=PublieCorlor;
            lable2.layer.cornerRadius=4;
            lable2.layer.masksToBounds=YES;
            lable2.font=[UIFont systemFontOfSize:14];
           // [view addSubview:lable2];
            
 
            NSDictionary *dict=array[indexPath.section];
            
            NSArray *arr=[dict objectForKey:@"images"];
            
            imageView.image=[UIImage imageNamed:[arr objectAtIndex:indexPath.row]];
            NSArray *arr1=[dict objectForKey:@"datas"];
            lable1.text=[arr1 objectAtIndex:indexPath.row];
            
            
            
            
        }

        
    }

    return cell;
}



#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section==0) {
        return 80;
    }else{
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
    if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            
            YH_FriendRemarksViewController *rem=[[YH_FriendRemarksViewController alloc] init];
            rem.dict=_dict;
            [self.navigationController pushViewController:rem animated:YES];

        }else{
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[_dict objectForKey:@"phone1"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
        
        
    }else if (indexPath.section==2) {
        
        if (indexPath.row==0) {
            
            YH_FriendViewController *fri=[[YH_FriendViewController alloc] init];
            fri.title=@"朋友圈";
            fri.ctrType=@"1";
            fri.nickName=[_dict objectForKey:@"nickname"];
            fri.headStr=[_dict objectForKey:@"headpicture"];
            fri.friendUid = [_dict[@"uid"] stringValue];
            fri.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:fri animated:YES];
            
        }
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
