//
//  MoblieFriendViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/21.
//  Copyright © 2015年 anbaoxing. All rights reserved.

#import "YH_AddFriendSViewController.h"
#import "MoblieFriendListViewController.h"
#import "MobileCheckViewController.h"
#import <AddressBook/AddressBook.h>
#import "pinyin.h"
#import "YH_FriendViewController.h"

#import "UIWindow+YzdHUD.h"


@interface YH_AddFriendSViewController ()

@end

@implementation YH_AddFriendSViewController


static int theFont;

-(void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];

    
    //屏幕适配
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
    
        
    
        
        theFont=15;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
 
    
        
        theFont=15;
        
    }else if (IS_IPHONE_6) {  // 6
        
  
        

        
        theFont=16;
        
    }else if (IS_IPHONE_6P) {  // 6P
        

        theFont=18;
        
    }
    
        //tableHeaderView
        view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,theWidth, 50)];
        view.backgroundColor=[UIColor clearColor];
        _theTableView.tableHeaderView=view;
        
        
        ruqeustButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, theWidth, 50)];
        ruqeustButton.backgroundColor = [UIColor clearColor];
        [ruqeustButton addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [ruqeustButton addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
        ruqeustButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        ruqeustButton.titleLabel.font=[UIFont systemFontOfSize:theFont-2];
        ruqeustButton.alpha=0.9;
        [ruqeustButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
        [view addSubview:ruqeustButton];
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(70, 10, 150, 30)];
        label.textAlignment=NSTextAlignmentLeft;
        label.text=@"导入手机通讯录";
        label.font=[UIFont systemFontOfSize:theFont-2];
        [ruqeustButton addSubview:label];
        
        UIImageView *theimageView=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth-30, (50-12.5)/2, 8.2, 12.5)];
        theimageView.image=[UIImage imageNamed:@"4"];
        [ruqeustButton addSubview:theimageView];
    
        UIImageView *theimageView1=[[UIImageView alloc] initWithFrame:CGRectMake(21, 10, 30, 30)];
        theimageView1.image=[UIImage imageNamed:[[NSString alloc] initWithFormat:@"request5"]];
        [view addSubview:theimageView1];
    
    
    NSLog(@"arr==%@",_allArr);
    
}

//  button1普通状态下的背景色
- (void)button1BackGroundNormal:(UIButton *)sender
{
    
    MoblieFriendListViewController *moblie=[[MoblieFriendListViewController alloc] init];
    moblie.hidesBottomBarWhenPushed=YES;
    moblie.title=@"邀请手机通讯录";
    [self.navigationController pushViewController:moblie animated:YES];
    sender.backgroundColor = [UIColor clearColor];
    
    
}

//  button1高亮状态下的背景色
- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 1;

    }else
    {
      
        return _allArr.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIder = @"cell";

      UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIder];
        
        
    }
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
        imageView.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:imageView];
        
        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(55, 7, 150, 30)];
        nameLable.backgroundColor=[UIColor clearColor];
        nameLable.alpha=0.7;
        nameLable.font=[UIFont systemFontOfSize:theFont-2];
        [cell.contentView addSubview:nameLable];
        
      
    }else{
        
        NSDictionary *dict=[_allArr objectAtIndex:indexPath.row];
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        imageView.backgroundColor=[UIColor clearColor];
        
        NSString *imageStr=[dict objectForKey:@"headpicture"];
        
        if (imageStr.length!=0) {
            
            NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[dict objectForKey:@"headpicture"]];
            
            UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
            
            imageView.image=_decodedImage;
            
        }else{
            
            imageView.image=[UIImage imageNamed:@"theHead"];
            
        }
        [cell.contentView addSubview:imageView];
        
        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(70, 8, 200, 20)];
        nameLable.text=[[NSString alloc] initWithFormat:@"%@",[dict objectForKey:@"nickname"]];
        nameLable.backgroundColor=[UIColor clearColor];
        nameLable.alpha=1;
    
        nameLable.textAlignment=NSTextAlignmentLeft;
        nameLable.font=[UIFont systemFontOfSize:theFont+2];
        [cell.contentView addSubview:nameLable];
        
        nameLable1=[[UILabel alloc] initWithFrame:CGRectMake(70, 30, 200, 20)];
    
        nameLable1.text=[[NSString alloc] initWithFormat:@"手机联系人：%@",[dict objectForKey:@"fname"]];
        nameLable1.backgroundColor=[UIColor clearColor];
        nameLable1.alpha=0.4;
        nameLable.textAlignment=NSTextAlignmentLeft;
        nameLable1.font=[UIFont systemFontOfSize:theFont-3];
        [cell.contentView addSubview:nameLable1];
        
        isAddLable=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-20-50, 20, 60, 20)];
        isAddLable.text=@"已添加";
        isAddLable.backgroundColor=[UIColor clearColor];
        isAddLable.alpha=0.3;
        isAddLable.textAlignment=NSTextAlignmentLeft;
        isAddLable.font=[UIFont systemFontOfSize:theFont-1];
        [cell.contentView addSubview:isAddLable];

        
    }
    

    return cell;
}



#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
   // NSLog(@"_theSortArry=%@",_theSortArry);
    
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 1;
    }else
    {
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView
    )
    {
        return 1;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        
        return nil;
    }
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 25)];
    view1.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, 20, 21)];
    label.font=[UIFont systemFontOfSize:14];
    label.backgroundColor=[UIColor clearColor];
    label.textColor = [UIColor grayColor];
    [view1 addSubview:label];
    return view1;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 0;
    }
    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UISearchDisplayDelegate

//如果搜索文字变化 会执行的委托方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString NS_DEPRECATED_IOS(3_0,8_0);
{
    [self filterContentOfSearchString:searchString];
    return YES;
}

//源字符串 搜索包含或等于的字符串
- (void)filterContentOfSearchString:(NSString *)searchText
{
    
//    myArr=[[ NSMutableArray  alloc] init];
//    for (NSString *Str in _theSortArry) {
//        NSArray *arr=[_theSectionDic objectForKey:Str];
//        
//        for (NSDictionary *dict in arr)  {
//            NSString *theCityName =[dict objectForKey:@"fname"];
//            NSRange theSearchRange = NSMakeRange(0, theCityName.length);
//            NSRange foundRange = [theCityName rangeOfString:searchText options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch range:theSearchRange];
//            if (foundRange.length) {
//                
//                [myArr addObject:dict];
//                
//            }
//            
//        }
//        
//    }
   
}

@end
