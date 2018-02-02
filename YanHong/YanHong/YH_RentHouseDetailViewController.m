//
//  YH_RentHouseDetailViewController.m
//  YanHong
//
//  Created by Mr.yang on 16/3/9.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_RentHouseDetailViewController.h"
#import "UIWindow+YzdHUD.h"
#import "HouseSaleNextViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "OrderHouseViewController.h"

@interface YH_RentHouseDetailViewController ()

@end

@implementation YH_RentHouseDetailViewController

static int Scroll_Size;

static int theFont;

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    [_tradetypeIs2 removeObjectForKey:@"headpicture"];
    [_tradetypeIs2 removeObjectForKey:@"photo1"];
    
    NSLog(@"_tradetypeIs2=%@",_tradetypeIs2);
    
    self.title=[_tradetypeIs2 objectForKey:@"buildings"];
    
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theFont=14;
        
        Scroll_Size =150;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theFont=14;
        Scroll_Size =178;
        
        
    }else if (IS_IPHONE_6) {  // 6
        
        theFont=18;
        
        Scroll_Size =220;
        
        
    }else if (IS_IPHONE_6P){
        
        theFont=18;
        
        Scroll_Size =250;
    }
    
    view=[[UIView alloc] initWithFrame:CGRectMake(0, theHeight-110, theWidth, 50)];
    view.backgroundColor=[UIColor colorWithRed:239/255.0 green:240/255.0 blue:241/255.0 alpha:1];
    view.tag=103;
    [self.view addSubview:view];

    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(theWidth/3, 0, 0.4, 50)];
    view1.alpha=0.4;
    view1.backgroundColor=[UIColor grayColor];
    [view addSubview:view1];
    
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(theWidth/3*2, 0, 0.6, 50)];
    view2.alpha=0.4;
    view2.backgroundColor=[UIColor grayColor];
    [view addSubview:view2];
    
    UIImageView *theimageView1=[[UIImageView alloc ] initWithFrame:CGRectMake(10, 15, 20, 20)];
    theimageView1.image=[UIImage imageNamed:@"my_about"];
    [view addSubview:theimageView1];
    
    UIImageView *theimageView2=[[UIImageView alloc ] initWithFrame:CGRectMake(10+theWidth/3, 15, 20, 20)];
    theimageView2.image=[UIImage imageNamed:@"my_about"];
    [view addSubview:theimageView2];
    
    UILabel *thelable1=[[UILabel alloc] initWithFrame:CGRectMake(35, 15, theWidth/3, 20)];
    thelable1.textAlignment=NSTextAlignmentLeft;
    thelable1.backgroundColor=[UIColor clearColor];
    thelable1.text=@"电话咨询";
    thelable1.font=[UIFont systemFontOfSize:14];
    [view addSubview:thelable1];
    
    UILabel *thelable2=[[UILabel alloc] initWithFrame:CGRectMake(35+theWidth/3, 15, theWidth/3, 20)];
    thelable2.textAlignment=NSTextAlignmentLeft;
    thelable2.backgroundColor=[UIColor clearColor];
    thelable2.text=@"转发";
    thelable2.font=[UIFont systemFontOfSize:14];
    [view addSubview:thelable2];
    
    
    buyButton=[[UIButton alloc] initWithFrame:CGRectMake(theWidth/3*2+(theWidth/3-theWidth/3+15), 10, theWidth/3-15*2, 30)];
    buyButton.titleLabel.font=[UIFont systemFontOfSize:15];
    buyButton.backgroundColor=PublieCorlor;
    buyButton.layer.cornerRadius=4;
    buyButton.layer.masksToBounds=YES;
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:buyButton];


    //已经购买或者是自己发布的删除视图
    if ([[_tradetypeIs2 objectForKey:@"dealstate"] isEqualToString:@"2"]) {

        for (UIView *subviews in [self.view subviews]) {
            if (subviews.tag==103) {
                [subviews removeFromSuperview];
            }
        }
    }
    //电话咨询
    
    callPhoneButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, theWidth/3, 50)];
    [callPhoneButton addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:callPhoneButton];
    
    //转发
    
    forWardButton=[[UIButton alloc] initWithFrame:CGRectMake(theWidth/3, 0, theWidth/3, 50)];
    [forWardButton addTarget:self action:@selector(forWardAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:forWardButton];

    
    //自己发布的
    if ([_ctrType isEqualToString:@"1"]) {
        
        
        [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        
        [buyButton addTarget:self action:@selector(OrderAction) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *theUid=[[NSString alloc] initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
        
        NSString *allUid=[[NSString alloc] initWithFormat:@"%@",[_tradetypeIs2 objectForKey:@"uid"]];
        
     
            if ([theUid isEqualToString:allUid]) {
                
                for (UIView *subviews in [self.view subviews]) {
                    if (subviews.tag==103) {
                        [subviews removeFromSuperview];
                    }
                }
                
                
        }

        
    }else {
        
        [buyButton setTitle:@"立即预订" forState:UIControlStateNormal];
        
        NSString *theUid=[[NSString alloc] initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
        
        NSString *allUid=[[NSString alloc] initWithFormat:@"%@",[_tradetypeIs2 objectForKey:@"uid"]];
        
            if ([theUid isEqualToString:allUid]) {
                
                for (UIView *subviews in [self.view subviews]) {
                    if (subviews.tag==103) {
                        [subviews removeFromSuperview];
                    }
                }

        }
        
    }
    
    
    //下载图片
    
    [self httpData:@"1"];
    
    //    //取消系统自带的返回按钮
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
    //返回Item
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];

    imageArray =[[NSMutableArray alloc] init];
    
    //默认第一张开始
    picCount=1;
  
}

-(void)popAction
{
   
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)forWardAction:(UIButton *)sender
{
    
    if ([_ctrType isEqualToString:@"1"]) {

   
        HouseSaleNextViewController *forWard=[[HouseSaleNextViewController alloc] init];
        
        forWard.title=@"我要转发";
        
        forWard.forwardInfo=_tradetypeIs2;
        
        forWard.hid=[_tradetypeIs2 objectForKey:@"infoid"];
        
        forWard.allPersonUid=[_tradetypeIs2 objectForKey:@"uid"];
    
        forWard.theprice=[_tradetypeIs2 objectForKey:@"price"];
        
        
        [self.navigationController pushViewController:forWard animated:YES];

        
    }else{
        
        [self shareContent:sender];
        
    }
}

-(void)callAction:(UIButton *)sender
{
  
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[_tradetypeIs2 objectForKey:@"disphone"]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

-(void)OrderAction

{
    
    if ([_ctrType isEqualToString:@"1"]) {
        
        OrderHouseViewController *order=[[OrderHouseViewController alloc] init];
        
        order.uid=[_tradetypeIs2 objectForKey:@"fid"];;
        
        order.infoId=[_tradetypeIs2 objectForKey:@"id"];;
        
        order.hid=[_tradetypeIs2 objectForKey:@"infoid"];;
        
        order.price=[_tradetypeIs2 objectForKey:@"price"];
        
        order.orderTitle=[_tradetypeIs2 objectForKey:@"buildings"];
        
        order.orderComment=[_tradetypeIs2 objectForKey:@"housetype"];
        
        [self.navigationController pushViewController:order animated:YES];
        
    }else{
        
    
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
        return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellId=@"myCell";
    
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (myCell==nil) {
        
        myCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        myCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (indexPath.row==0) {
            
            headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, Scroll_Size)];
            [myCell  addSubview:headView];

            _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, theWidth, Scroll_Size)];
            [headView addSubview:_scrollView];
                

        }else if (indexPath.row==1){
            
            lable1=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, theWidth-40, 30)];
        
            lable1.textAlignment=NSTextAlignmentLeft;
            lable1.backgroundColor=[UIColor clearColor];
            [myCell addSubview:lable1];
            lable1.text=[_tradetypeIs2 objectForKey:@""];
            lable2=[[UILabel alloc] initWithFrame:CGRectMake(10, 45, theWidth, 30)];
            lable2.textColor=PublieCorlor;
            lable2.textAlignment=NSTextAlignmentLeft;
            lable2.backgroundColor=[UIColor clearColor];
            [myCell addSubview:lable2];

        }else if (indexPath.row==2){
            
            UILabel *lable3=[[UILabel alloc] initWithFrame:CGRectMake(10, (120-20*3)/4, 50, 20)];
            lable3.alpha=0.6;
            lable3.font=[UIFont systemFontOfSize:14];
            lable3.text=@"户型：";
            lable3.textAlignment=NSTextAlignmentLeft;
            lable3.backgroundColor=[UIColor clearColor];
            [myCell addSubview:lable3];
            
            UILabel *lable4=[[UILabel alloc] initWithFrame:CGRectMake(10, (120-20*3)/4*2+20, 50, 20)];
            lable4.text=@"楼层：";
            lable4.alpha=0.6;
            lable4.font=[UIFont systemFontOfSize:14];
            lable4.textAlignment=NSTextAlignmentLeft;
            lable4.backgroundColor=[UIColor clearColor];
            [myCell addSubview:lable4];
            
            UILabel *lable5=[[UILabel alloc] initWithFrame:CGRectMake(10, (120-20*3)/4*3+20*2, 80, 20)];
            lable5.text=@"所属小区：";
            lable5.alpha=0.6;
            lable5.font=[UIFont systemFontOfSize:14];
            lable5.textAlignment=NSTextAlignmentLeft;
            lable5.backgroundColor=[UIColor clearColor];
            [myCell addSubview:lable5];
            
            UILabel *lable6=[[UILabel alloc] initWithFrame:CGRectMake(theWidth/2, (120-20*3)/4, 50, 20)];
            lable6.textAlignment=NSTextAlignmentLeft;
            lable6.text=@"面积：";
            lable6.alpha=0.6;
            lable6.font=[UIFont systemFontOfSize:14];
            lable6.backgroundColor=[UIColor clearColor];
            [myCell addSubview:lable6];
            
            UILabel *lable7=[[UILabel alloc] initWithFrame:CGRectMake(theWidth/2, (120-20*3)/4*2+20, 50, 20)];
            lable7.alpha=0.6;
            lable7.textAlignment=NSTextAlignmentLeft;
            lable7.text=@"朝向：";
            lable7.font=[UIFont systemFontOfSize:14];
            lable7.backgroundColor=[UIColor clearColor];
            [myCell addSubview:lable7];
        
                
            if ([_ctrType isEqualToString:@"1"]) {
                
                UILabel *lable8=[[UILabel alloc] initWithFrame:CGRectMake(theWidth/2, (120-20*3)/4*3+20*2, 50, 20)];
                lable8.alpha=0.6;
                lable8.text=@"装修：";
                lable8.font=[UIFont systemFontOfSize:14];
                lable8.textAlignment=NSTextAlignmentLeft;
                lable8.backgroundColor=[UIColor clearColor];
                [myCell addSubview:lable8];
                
                title6=[[UILabel alloc] initWithFrame:CGRectMake(theWidth/2+40, (120-20*3)/4*3+20*2, theWidth/2, 20)];
                title6.font=[UIFont systemFontOfSize:14];
                title6.textAlignment=NSTextAlignmentLeft;
                title6.backgroundColor=[UIColor clearColor];
                    
                }
            
            title1=[[UILabel alloc] initWithFrame:CGRectMake(50, (120-20*3)/4, theWidth/2-50, 20)];
            title1.textAlignment=NSTextAlignmentLeft;
            title1.backgroundColor=[UIColor clearColor];
    
            title1.font=[UIFont systemFontOfSize:14];
            [myCell addSubview:title1];
            
            title2=[[UILabel alloc] initWithFrame:CGRectMake(50, (120-20*3)/4*2+20, theWidth/2-50, 20)];
            title2.textAlignment=NSTextAlignmentLeft;
            title2.backgroundColor=[UIColor clearColor];
            
            title2.font=[UIFont systemFontOfSize:14];
            [myCell addSubview:title2];
            
            title3=[[UILabel alloc] initWithFrame:CGRectMake(80, (120-20*3)/4*3+20*2, theWidth/2-80, 20)];
            title3.textAlignment=NSTextAlignmentLeft;
            title3.font=[UIFont systemFontOfSize:14];
    
            title3.backgroundColor=[UIColor clearColor];
            [myCell addSubview:title3];
            
            title4=[[UILabel alloc] initWithFrame:CGRectMake(theWidth/2+40, (120-20*3)/4, theWidth/2, 20)];
            title4.font=[UIFont systemFontOfSize:14];
            title4.textAlignment=NSTextAlignmentLeft;
            title4.backgroundColor=[UIColor clearColor];
            [myCell addSubview:title4];
            
            title5=[[UILabel alloc] initWithFrame:CGRectMake(theWidth/2+40, (120-20*3)/4*2+20, theWidth/2, 20)];

            title5.textAlignment=NSTextAlignmentLeft;
            title5.font=[UIFont systemFontOfSize:14];
            title5.backgroundColor=[UIColor clearColor];
            [myCell addSubview:title5];
            
    
            
            [myCell addSubview:title6];
                

        }else if (indexPath.row==3){
            
            if ([_ctrType isEqualToString:@"1"]) {
                
                UILabel *lable3=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
                lable3.alpha=0.6;
                lable3.font=[UIFont systemFontOfSize:14];
                lable3.text=@"房屋描述";
                lable3.textAlignment=NSTextAlignmentLeft;
                lable3.backgroundColor=[UIColor clearColor];
                [myCell addSubview:lable3];
                
                title8=[[UILabel alloc] initWithFrame:CGRectMake(10, 30, theWidth, 20)];
                title8.font=[UIFont systemFontOfSize:14];
                title8.textAlignment=NSTextAlignmentLeft;
                title8.backgroundColor=[UIColor clearColor];
                
                CGSize size = CGSizeMake(theWidth-20, MAXFLOAT);
                title8.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize = [title8 sizeThatFits:size];
                title8.frame = CGRectMake(10, 30,theWidth-20, lableSize.height);
                [myCell addSubview:title8];
                
                }else{
                
                UILabel *lable3=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
                lable3.alpha=0.6;
                lable3.font=[UIFont systemFontOfSize:14];
                lable3.text=@"配套设施：";
                lable3.textAlignment=NSTextAlignmentLeft;
                lable3.backgroundColor=[UIColor clearColor];
                [myCell addSubview:lable3];
                
                title7=[[UILabel alloc] initWithFrame:CGRectMake(80, 10, theWidth, 20)];
                
                title7.font=[UIFont systemFontOfSize:14];
                title7.textAlignment=NSTextAlignmentLeft;
                title7.backgroundColor=[UIColor clearColor];
                [myCell addSubview:title7];
                
                view=[[UIView alloc] initWithFrame:CGRectMake(10, 40, theWidth, 1)];
                view.backgroundColor=[UIColor grayColor];
                view.alpha=0.2;
                [myCell addSubview:view];

                UILabel *lable4=[[UILabel alloc] initWithFrame:CGRectMake(10, 50, 80, 20)];
                lable4.alpha=0.6;
                lable4.font=[UIFont systemFontOfSize:14];
                lable4.text=@"房屋描述";
                lable4.textAlignment=NSTextAlignmentLeft;
                lable4.backgroundColor=[UIColor clearColor];
                [myCell addSubview:lable4];
                
                title8=[[UILabel alloc] initWithFrame:CGRectMake(10, 80, theWidth, 20)];
                title8.font=[UIFont systemFontOfSize:14];
                title8.textAlignment=NSTextAlignmentLeft;
    
                title8.backgroundColor=[UIColor clearColor];
                title8.text=[_tradetypeIs2 objectForKey:@"comment"];
                CGSize size = CGSizeMake(theWidth-20, MAXFLOAT);
                title8.numberOfLines = 0;
                //    ios8使用的方法
                CGSize lableSize = [title8 sizeThatFits:size];
                title8.frame = CGRectMake(10, 80,theWidth-20, lableSize.height);
                [myCell addSubview:title8];
                

            }
            
            
            
            
        }
        
    }

    
    if ([_ctrType isEqualToString:@"1"]) {
        
        if (indexPath.row==0) {
            
            if (imageArray.count!=0) {
                //设置内容大小
                _scrollView.contentSize=CGSizeMake(theWidth*imageArray.count, 0);
                //设置是否分页
                _scrollView.pagingEnabled=YES;
                
                _scrollView.delegate=self;
                
                for (int i=0; i<imageArray.count; i++) {
                    
                    imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth*i, 0, theWidth, Scroll_Size)];
                    [_scrollView addSubview:imageView1];
                    
                    imageView1.image=[imageArray objectAtIndex:i];
                    
                    
                }
               

            }else{
                imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth, Scroll_Size)];
                [_scrollView addSubview:imageView1];
                imageView1.image=[UIImage imageNamed:@"NoPic.jpg"];

            }
            
        }else{
            
            lable1.text=[[NSString alloc] initWithFormat:@"%@ %@",[_tradetypeIs2 objectForKey:@"buildings"],[_tradetypeIs2 objectForKey:@"housetype"]];
            lable2.text=[[NSString alloc] initWithFormat:@"¥%@万/套",[_tradetypeIs2 objectForKey:@"price"]];
            title1.text=[_tradetypeIs2 objectForKey:@"housetype"];
            title2.text=[_tradetypeIs2 objectForKey:@"floor"];
            title3.text=[[NSString alloc] initWithFormat:@"%@%@",[_tradetypeIs2 objectForKey:@"address"],[_tradetypeIs2 objectForKey:@"buildings"]];
            title4.text=[[NSString alloc] initWithFormat:@"%@㎡",[_tradetypeIs2 objectForKey:@"area"]];
            title5.text=[_tradetypeIs2 objectForKey:@"orientation"];
            title7.text=[_tradetypeIs2 objectForKey:@"mating"];
        }
        
    }else {

        if (indexPath.row==0) {
            
            if (imageArray.count!=0) {
                //设置内容大小
                _scrollView.contentSize=CGSizeMake(theWidth*imageArray.count, 0);
                //设置是否分页
                _scrollView.pagingEnabled=YES;
                
                _scrollView.delegate=self;
                
                for (int i=0; i<imageArray.count; i++) {
                    
                    imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth*i, 0, theWidth, Scroll_Size)];
                    [_scrollView addSubview:imageView1];
                    
                    imageView1.image=[imageArray objectAtIndex:i];
                    
                    
                }

            }else{

                imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, theWidth, Scroll_Size)];
                [_scrollView addSubview:imageView1];
                imageView1.image=[UIImage imageNamed:@"NoPic.jpg"];
     
            }
            
        

            
        }else{
            
            lable1.text=[[NSString alloc] initWithFormat:@"%@ %@",[_tradetypeIs2 objectForKey:@"buildings"],[_tradetypeIs2 objectForKey:@"housetype"]];
            lable2.text=[[NSString alloc] initWithFormat:@"¥%@元/晚",[_tradetypeIs2 objectForKey:@"price"]];
            title1.text=[_tradetypeIs2 objectForKey:@"housetype"];
            title2.text=[_tradetypeIs2 objectForKey:@"floor"];
            title3.text=[[NSString alloc] initWithFormat:@"%@%@",[_tradetypeIs2 objectForKey:@"address"],[_tradetypeIs2 objectForKey:@"buildings"]];
            title4.text=[[NSString alloc] initWithFormat:@"%@㎡",[_tradetypeIs2 objectForKey:@"area"]];
            title5.text=[_tradetypeIs2 objectForKey:@"orientation"];
            title7.text=[_tradetypeIs2 objectForKey:@"mating"];
            
    
        }
    
        
    }
        
        NSString *theUid=[[NSString alloc] initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
        
        NSString *allUid=[[NSString alloc] initWithFormat:@"%@",_allPersonUid];
        
        if (theUid==nil || allUid==nil) {
            
        }else{
            
            //不能转发自己发布的
            if ([theUid isEqualToString:allUid]) {
                
                for (UIView *subviews in [self.view subviews]) {
                    if (subviews.tag==103) {
                        [subviews removeFromSuperview];
                    }
                }
                
                
            }
        }

 
    
    
    return myCell;
    
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
 
        if (indexPath.row==0) {
            
            return Scroll_Size;
            
        }else if (indexPath.row==1){
            
            return 80;
            
        }else if (indexPath.row==2){
            
            return 120;
            
        }else {
            
            CGSize size = CGSizeMake(theWidth-20, MAXFLOAT);
            title8.numberOfLines = 0;
            //    ios8使用的方法
            CGSize lableSize = [title8 sizeThatFits:size];
            
            
            if ([_ctrType isEqualToString:@"1"]) {
                
                return lableSize.height+190;
                
            }else{
                
                return lableSize.height+200;
            }

            
    }

        
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0;
}

#pragma mark  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        
    }else
    {
        
        int index = scrollView.contentOffset.x/theWidth;
        
        pageCtr.currentPage = index;
        
        countlLable.text=[[NSString alloc] initWithFormat:@"%d/%lu",index+1,(unsigned long)imageArray.count];

    }
    
}

-(void)httpData:(NSString*)photoNo
{
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *strJson1;
    
    if ([_ctrType isEqualToString:@"1"]) {
        
        //图片获取
       strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1065\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"hid\":\"%@\",\"no\":\"%@\",\"type\":\"1\",\"apptype\":\"2\"}",dateString,@"0",[_tradetypeIs2 objectForKey:@"infoid"],photoNo];
        
        
    }else if([_ctrType isEqualToString:@"2"]){
        
        //图片获取
        strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1065\",\"errcode\":\"000\",\"errmsg\":\"提示信息\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"hid\":\"%@\",\"type\":\"2\",\"no\":\"%@\",\"apptype\":\"2\"}",dateString,@"0",[_tradetypeIs2 objectForKey:@"infoid"],photoNo];
        
    }
    
    //post 请求
    httpRequest=[[HttpRequestCalss alloc] init];
    
    NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson1 success:^(id responseObject) {
        
    } fail:^{
        
    }];
    
}

#pragma mark HttpRequestClassDelegate

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1066) {
        
        if ([[dic objectForKey:@"photo"] isKindOfClass:[NSNull class]] || [[dic objectForKey:@"photo"] isEqualToString:@""]) {
            
            imageView1.image=[UIImage imageNamed:@"NoPic.jpg"];
        
        }else{
            
            picCount++;
            
            NSLog(@"piccount=%d",picCount);
            
            NSData *_decodedImageData = [[NSData alloc] initWithBase64Encoding:[dic objectForKey:@"photo"]];
            
            UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
            [imageArray addObject:_decodedImage];
            
            //继续下载图片
            [self httpData:[[NSString alloc] initWithFormat:@"%d",picCount]];
            
        }
        
    }
    
    if (imageArray.count!=0) {
        
        countlLable=[[UILabel alloc] initWithFrame:CGRectMake(theWidth-50, Scroll_Size-35, 40, 17)];
        countlLable.backgroundColor=[UIColor colorWithRed:35/255.0 green:40/255.0 blue:47/255.0 alpha:1];
        countlLable.textColor=[UIColor whiteColor];
        countlLable.layer.cornerRadius=4;
        countlLable.textAlignment=NSTextAlignmentCenter;
        countlLable.text=[[NSString alloc] initWithFormat:@"1/%lu",(unsigned long)imageArray.count];
        countlLable.font=[UIFont systemFontOfSize:12];
        countlLable.layer.masksToBounds=YES;
        [countlLable bringSubviewToFront:_scrollView];
        
        [headView addSubview:countlLable];
        
    }
    
    [_tableView reloadData];
    
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
    
}

- (void)shareContent:(id)sender
{
    //判断是否登陆，由登陆状态判断启动页面
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        //1、构造分享内容
        //1.1、要分享的图片（以下分别是网络图片和本地图片的生成方式的示例）
        
        //id<ISSCAttachment> remoteAttachment = [ShareSDKCoreService attachmentWithUrl:@"http://f.hiphotos.bdimg.com/album/w%3D2048/sign=df8f1fe50dd79123e0e09374990c5882/cf1b9d16fdfaaf51e6d1ce528d5494eef01f7a28.jpg"];
        
        id<ISSCAttachment> localAttachment = [ShareSDKCoreService attachmentWithPath:[[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"]];
        
        NSString *titleStr=[[NSString alloc] initWithFormat:@"%@ %@ %@ %@元/晚",[_tradetypeIs2 objectForKey:@"address"],[_tradetypeIs2 objectForKey:@"housetype"],[_tradetypeIs2 objectForKey:@"area"],[_tradetypeIs2 objectForKey:@"price"]];
        
        NSLog(@"titleStr=%@",titleStr);
        
        //1.2、以下参数分别对应：内容、默认内容、图片、标题、链接、描述、分享类型
        id<ISSContent> publishContent = [ShareSDK content:[_tradetypeIs2 objectForKey:@"address"]
                                           defaultContent:nil
                                                    image:localAttachment
                                                    title:titleStr
                                                      url:nil
                                              description:nil
                                                mediaType:SSPublishContentMediaTypeNews];
        
        //1.3、自定义各个平台的分享内容(非必要)
        [self customizePlatformShareContent:publishContent];
        
        //1.5、分享菜单栏选项排列位置和数组元素index相关(非必要)
        NSArray *shareList = [ShareSDK customShareListWithType:
                              // SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                              // SHARE_TYPE_NUMBER(ShareTypeFacebook),
                              SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                              SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                              // SHARE_TYPE_NUMBER(ShareTypeSMS),
                              SHARE_TYPE_NUMBER(ShareTypeQQ),
                              SHARE_TYPE_NUMBER(ShareTypeQQSpace),
                              // SHARE_TYPE_NUMBER(ShareTypeMail),
                              //   SHARE_TYPE_NUMBER(ShareTypeCopy),
                              nil];
        
        //1+、创建弹出菜单容器（iPad应用必要，iPhone应用非必要）
        id<ISSContainer> container = [ShareSDK container];
        [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
        //2、展现分享菜单
        [ShareSDK showShareActionSheet:container
                             shareList:shareList
                               content:publishContent
                         statusBarTips:NO
                           authOptions:nil
                          shareOptions:nil
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    
                                    NSLog(@"=== response state :%zi ",state);
                                    
                                    //可以根据回调提示用户。
                                    if (state == SSResponseStateSuccess)
                                    {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                        message:nil
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"确定"
                                                                              otherButtonTitles:nil, nil];
                                        [alert show];
                                    }
                                    else if (state == SSResponseStateFail)
                                    {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                        message:[NSString stringWithFormat:@"%@",[error errorDescription]]
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"确定"
                                                                              otherButtonTitles:nil, nil];
                                        [alert show];
                                    }
                                }];
        
    }else{
        
        
    }
    
}

- (void)customizePlatformShareContent:(id<ISSContent>)publishContent
{
    //定制QQ空间分享内容
    [publishContent addQQSpaceUnitWithTitle:@"热门楼盘"
                                        url:_uid
                                       site:nil
                                    fromUrl:nil
                                    comment:@"comment"
                                    summary:@"summary"
                                      image:nil
                                       type:@(4)
                                    playUrl:nil
                                       nswb:0];
    
    
}

@end
