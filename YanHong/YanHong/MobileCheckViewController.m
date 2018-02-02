//
//  MobileCheckViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/24.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "MobileCheckViewController.h"
#import "MoblieFriendListViewController.h"
#import "UIWindow+YzdHUD.h"

@interface MobileCheckViewController ()

@end

@implementation MobileCheckViewController

static int theFont;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _theTableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        
        theFont=14;
        
    }else if (IS_IPHONE_5) {  // 5, 5S

        
        theFont=14;
        
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
-(void)popAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIder = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIder];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIder];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, (60-35)/2, 35, 35)];
        NSString *imagStr=[[NSString alloc] initWithFormat:@"request%ld",indexPath.row+4];
        imageView.image=[UIImage imageNamed:imagStr];
        imageView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [cell.contentView addSubview:imageView];
        
        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(60, 15, 150, 30)];
        nameLable.backgroundColor=[UIColor clearColor];
        nameLable.alpha=1;
        nameLable.font=[UIFont systemFontOfSize:theFont];
        [cell.contentView addSubview:nameLable];

       
    }
    
    //NSArray *thearr=@[@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间",@"手机通讯录联系人"];
    NSArray *thearr=@[@"邀请好友",@"手机通讯录联系人"];
    nameLable.text=[thearr objectAtIndex:indexPath.row];
    
    
    
    return cell;
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
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
        MoblieFriendListViewController *moblie=[[MoblieFriendListViewController alloc] init];
        moblie.uid=_uid;
        moblie.hidesBottomBarWhenPushed=YES;
        moblie.title=@"邀请手机通讯录";
        [self.navigationController pushViewController:moblie animated:YES];
    
    
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 30)];
    view1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, theWidth-20, 20)];
    label.font=[UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    label.text =  @"分享到";
    [view1 addSubview:label];
    
    return view1;
    
}


@end
