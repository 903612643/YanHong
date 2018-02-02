//
//  MoblieFriendViewController.m
//  YanHong
//
//  Created by Mr.yang on 15/12/21.
//  Copyright © 2015年 anbaoxing. All rights reserved.

#import "YH_MyGuestViewController.h"

#import "pinyin.h"

#import "UIWindow+YzdHUD.h"

#import "SuggestViewController.h"

#import "YH_GuestInfoViewController.h"


@interface YH_MyGuestViewController ()

@end

@implementation YH_MyGuestViewController

//线程方法
-(void)httpData
{
    
    NSString *strJson1;
    //当前时间
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssSS";
    NSString *dateString = [formatter stringFromDate:date];
    
    NSLog(@"allStr=%@",allStr);
    
    if (allStr.length==0) {
       
        //进入下载我的客户信息
       strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1025\",\"errcode\":\"000\",\"errmsg\":\"\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"acceptType\":\"0\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
        
    }else{
        
        //进入下载我的客户信息
        strJson1 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1025\",\"errcode\":\"000\",\"errmsg\":\"\",\"timestamp\":\"%@\",\"uid\":\"%@\",\"acceptType\":\"%@\"}",dateString,[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],[allStr substringFromIndex:1]];
        
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

-(void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]!=nil) {
        
        _allArr = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"myGuest"]];
        
        if (_allArr.count!=0) {
            
            [self addAZ:_allArr];
            
        }else{
            [self httpData];
        }
       
    }
    
}

static int theFont;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    allStr=[[NSString alloc] init];
    
    //   GCD  第六中创建线程方法
    // 创建一个队列
    dispatch_queue_t queue = dispatch_queue_create("YH", nil);
    //    创建异步线程
    dispatch_async(queue, ^{
        
        [self httpData];
        
        //      回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            self.tabBarController.tabBar.hidden=NO;
 
            
            //屏幕适配
            if (IS_IPHONE_4_OR_LESS) {  // 4S
                

                theFont=16;
                
            }else if (IS_IPHONE_5) {  // 5, 5S

                theFont=16;
                
            }else if (IS_IPHONE_6) {  // 6

                theFont=18;
                
            }else if (IS_IPHONE_6P) {  // 6P
                

                
                theFont=18;
                
            }
            
            UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            button1.frame=CGRectMake(0,0,25,20);
            [button1 setImage:[UIImage imageNamed:@"buttonPic3"] forState:UIControlStateNormal ];
           // [button1 addTarget:self action:@selector(button3Aciton) forControlEvents: UIControlEventTouchUpInside ];
            UIBarButtonItem *rigItem1=[[UIBarButtonItem alloc] initWithCustomView:button1];
            
            UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            button2.frame=CGRectMake(0,0,25, 20);
            [button2 setImage:[UIImage imageNamed:@"buttonPic3"] forState:UIControlStateNormal ];
            [button2 addTarget:self action:@selector(button2Aciton) forControlEvents: UIControlEventTouchUpInside ];
            UIBarButtonItem *rigItem2=[[UIBarButtonItem alloc] initWithCustomView:button2];
            
            UIButton *button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            button3.frame=CGRectMake(0,0,25, 20);
            [button3 setImage:[UIImage imageNamed:@"buttonPic1"] forState:UIControlStateNormal ];
            [button3 addTarget:self action:@selector(button1Aciton) forControlEvents: UIControlEventTouchUpInside ];
            UIBarButtonItem *rigItem3=[[UIBarButtonItem alloc] initWithCustomView:button3];
            
            NSArray *array=@[rigItem2,rigItem3];
            [self setToolbarItems:array animated:YES];
            self.navigationItem.rightBarButtonItems=array;
            
            UIButton *button4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            button4.frame=CGRectMake(0,0,25, 20);
            [button4 setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal ];
            [button4 addTarget:self action:@selector(button1Aciton) forControlEvents: UIControlEventTouchUpInside ];
            UIBarButtonItem *rigItem4=[[UIBarButtonItem alloc] initWithCustomView:button3];
            
            NSArray *array1=@[rigItem4];
            [self setToolbarItems:array1 animated:YES];
            self.navigationItem.leftBarButtonItems=array1;
            

            //返回Item
            self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction)];
            
            
            UIView *theview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
            theview.backgroundColor=[UIColor groupTableViewBackgroundColor];
            theview.tag=101;
            [theview bringSubviewToFront:_theTableView];
            [self.view addSubview:theview];
            
            tishilable=[[UILabel alloc] initWithFrame:CGRectMake(0,((theHeight-110)-30)/2, theWidth, 30)];
            tishilable.textAlignment=NSTextAlignmentCenter;
            tishilable.font=[UIFont systemFontOfSize:20];
            tishilable.alpha=0.4;
            [theview addSubview:tishilable];
    
            
            isClick=YES;
            
            isButtonCheck=YES;
           
            str1=[[NSString alloc] init];
            str2=[[NSString alloc] init];
            str3=[[NSString alloc] init];
            str4=[[NSString alloc] init];
            str5=[[NSString alloc] init];
            str6=[[NSString alloc] init];
            
        });
        
    });

}

-(void)checkButtonCeate
{
   UIButton *_theButton1=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4, 0, 85, 50)];
    [_theButton1 addTarget:self action:@selector(theButton1Action) forControlEvents:UIControlEventTouchUpInside];
    _theButton1.backgroundColor=[UIColor clearColor];
    [popview addSubview:_theButton1];
    
    UIButton *_theButton2=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*2+20, 0, 85, 50)];
    [_theButton2 addTarget:self action:@selector(theButton2Action) forControlEvents:UIControlEventTouchUpInside];
    _theButton2.backgroundColor=[UIColor clearColor];
    [popview addSubview:_theButton2];
    
    UIButton *_theButton3=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*3+20*2, ((150-50)-20*2)/3-10, 85, 40)];
    [_theButton3 addTarget:self action:@selector(theButton3Action) forControlEvents:UIControlEventTouchUpInside];
    [popview addSubview:_theButton3];
    
   UIButton *_theButton4=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4, ((150-50)-20*2)/3*2+10, 85, 40)];
    _theButton4.backgroundColor=[UIColor clearColor];
    [_theButton4 addTarget:self action:@selector(theButton4Action) forControlEvents:UIControlEventTouchUpInside];
    [popview addSubview:_theButton4];
    
    UIButton *_theButton5=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*2+20, ((150-50)-20*2)/3*2+10, 85, 40)];
    [_theButton5 addTarget:self action:@selector(theButton5Action) forControlEvents:UIControlEventTouchUpInside];
    [popview addSubview:_theButton5];
    
    UIButton *_theButton6=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*3+20*2, ((150-50)-20*2)/3*2+10, 85, 40)];
    [_theButton6 addTarget:self action:@selector(theButton6Action) forControlEvents:UIControlEventTouchUpInside];
    [popview addSubview:_theButton6];
    
    
}

-(void)selectView
{
    popview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 150)];
    popview.tag=102;
    popview.backgroundColor=[UIColor whiteColor];
    [popview bringSubviewToFront:_theTableView];
    [self.view addSubview:popview];
    
    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 150-50, theWidth, 1)];
    lineView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [popview addSubview:lineView];
    
    //代码可用for优化，
    theButton1=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4, ((150-50)-20*2)/3, 20, 20)];
    theButton1.layer.borderWidth = 1;
    theButton1.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [popview addSubview:theButton1];
    
    theButton2=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*2+20, ((150-50)-20*2)/3, 20, 20)];
    theButton2.layer.borderWidth = 1;
    theButton2.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [popview addSubview:theButton2];
    
    theButton3=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*3+20*2, ((150-50)-20*2)/3, 20, 20)];
    theButton3.layer.borderWidth = 1;
    theButton3.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [popview addSubview:theButton3];
    
    theButton4=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4, ((150-50)-20*2)/3*2+20, 20, 20)];
    theButton4.layer.borderWidth = 1;
    theButton4.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [popview addSubview:theButton4];
    
    theButton5=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*2+20, ((150-50)-20*2)/3*2+20, 20, 20)];
    theButton5.layer.borderWidth = 1;
    theButton5.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [popview addSubview:theButton5];
    
    theButton6=[[UIButton alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*3+20*2, ((150-50)-20*2)/3*2+20, 20, 20)];
    theButton6.layer.borderWidth = 1;
    theButton6.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [popview addSubview:theButton6];
    
    //放大button按钮以便选择
    [self checkButtonCeate];
    
    
    NSArray *theLableArr=@[@"已接收",@"来电",@"来访",@"认筹",@"认购",@"签约"];
    for (int i=0; i<6; i++) {
        
        if (i<3) {
            
            UILabel *theLable=[[UILabel alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*(i+1)+20*i+25, ((150-50)-20*2)/3, 60, 20)];
            theLable.font=[UIFont systemFontOfSize:14];
            theLable.text=theLableArr[i];
            theLable.alpha=0.8;
            theLable.backgroundColor=[UIColor clearColor];
            [popview addSubview:theLable];
            
        }else{
            
            UILabel *theLable=[[UILabel alloc] initWithFrame:CGRectMake((theWidth-30*3)/4*(i-2)+20*(i-3)+25, ((150-50)-20*2)/3*2+20, 60, 20)];
            theLable.font=[UIFont systemFontOfSize:14];
            theLable.text=theLableArr[i];
            theLable.alpha=0.8;
            theLable.backgroundColor=[UIColor clearColor];
            [popview addSubview:theLable];
            
        }
        
    }
    
    
    UIButton *theButton7=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    theButton7.frame=CGRectMake(((theWidth-80*2)-40*3)/4+80, (150-50)+(50-25)/3, 40, 25);
    [theButton7 setTitle:@"取消" forState:UIControlStateNormal];
    [theButton7 addTarget:self action:@selector(theButton7Action) forControlEvents:UIControlEventTouchUpInside];
    [theButton7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    theButton7.titleLabel.font=[UIFont systemFontOfSize:16];
    theButton7.layer.borderWidth = 1;
    theButton7.alpha=0.8;
    theButton7.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    theButton7.layer.cornerRadius=9;
    [popview addSubview:theButton7];
    
    UIButton *theButton8=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    theButton8.frame=CGRectMake(((theWidth-80*2)-40*3)/4*2+40+80, (150-50)+(50-25)/3, 40, 25);
    [theButton8 addTarget:self action:@selector(theButton8Action) forControlEvents:UIControlEventTouchUpInside];
    [theButton8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [theButton8 setTitle:@"重置" forState:UIControlStateNormal];
    theButton8.layer.borderWidth = 1;
    theButton8.alpha=0.4;
    theButton8.layer.borderColor = [UIColor grayColor].CGColor;
    theButton8.layer.cornerRadius=9;
    [popview addSubview:theButton8];
    
    theButton9=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    theButton9.frame=CGRectMake(((theWidth-80*2)-40*3)/4*3+40*2+80, (150-50)+(50-25)/3, 40, 25);
    [theButton9 setTitleColor:PublieCorlor forState:UIControlStateNormal];
    [theButton9 addTarget:self action:@selector(theButton9Action) forControlEvents:UIControlEventTouchUpInside];
    [theButton9 setTitle:@"确定" forState:UIControlStateNormal];
    theButton9.layer.borderWidth = 1;
    theButton9.layer.cornerRadius=9;
    theButton9.alpha=0.8;
    theButton9.layer.borderColor = PublieCorlor.CGColor;
    [popview addSubview:theButton9];
    
    popButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 150, theWidth, theHeight-150)];
    popButton.tag=103;
   // [popButton addTarget:self action:@selector(popActionButton) forControlEvents:UIControlEventTouchUpInside];
    [popButton bringSubviewToFront:_theTableView];
    popButton.backgroundColor=[UIColor blackColor];
    popButton.alpha=0.6;
    [self.view addSubview:popButton];
    
    
}

-(void)theButton1Action
{
    if (isButtonCheck==YES) {
        
        [theButton1 setImage:[UIImage imageNamed:@"YesRe"] forState:UIControlStateNormal];
        isButtonCheck=NO;
        str1=@",1";
        
        
    }else{
        
        [theButton1 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        isButtonCheck=YES;

        str1=@",";
    }
    
}

-(void)theButton2Action
{
    
    if (isButtonCheck==YES) {
        
        [theButton2 setImage:[UIImage imageNamed:@"YesRe"] forState:UIControlStateNormal];

        isButtonCheck=NO;
        str2=@",2";
 
    }else{
        
        [theButton2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        isButtonCheck=YES;
        str2=@"";
    }
    
}
-(void)theButton3Action
{
    
    if (isButtonCheck==YES) {
        
        [theButton3 setImage:[UIImage imageNamed:@"YesRe"] forState:UIControlStateNormal];
        
        isButtonCheck=NO;
        str3=@",3";
        
    }else{
        
        [theButton3 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        isButtonCheck=YES;
        str3=@"";
        
        
    }
    
}
-(void)theButton4Action
{
    
    if (isButtonCheck==YES) {
        
        [theButton4 setImage:[UIImage imageNamed:@"YesRe"] forState:UIControlStateNormal];
        
        isButtonCheck=NO;
        str4=@",4";
        
    }else{
        
        [theButton4 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        isButtonCheck=YES;
        str4=@"";
        
    }
    
}
-(void)theButton5Action
{
    
    if (isButtonCheck==YES) {
        
        [theButton5 setImage:[UIImage imageNamed:@"YesRe"] forState:UIControlStateNormal];
        
        isButtonCheck=NO;
        str5=@",5";
        
    }else{
        
        [theButton5 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        isButtonCheck=YES;
        str5=@"";
        
    }
    
}
-(void)theButton6Action
{
    if (isButtonCheck==YES) {
        
        [theButton6 setImage:[UIImage imageNamed:@"YesRe"] forState:UIControlStateNormal];
        isButtonCheck=NO;
        str6=@",6";
        
    }else{

        [theButton6 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        isButtonCheck=YES;
        str6=@",";
        
        
    }
    
}
//取消
-(void)theButton7Action
{
      //移除视图
    for (UIView *subviews in [self.view subviews]) {
        
        if (subviews.tag==102) {
            [subviews removeFromSuperview];
        }
        if (subviews.tag==103) {
            [subviews removeFromSuperview];
        }
      
    }
      
}
//重置
-(void)theButton8Action
{
    
    [theButton1 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [theButton2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [theButton3 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [theButton4 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [theButton5 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [theButton6 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    //初始化数据
    str1=@"";
    str2=@"";
    str3=@"";
    str4=@"";
    str5=@"";
    str6=@"";
    

}

//确认
-(void)theButton9Action
{
    
    
    allStr=[[NSString alloc] initWithFormat:@"%@%@%@%@%@%@",str1,str2,str3,str4,str5,str6];

    //重新下载我的客户
    [self httpData];

   //移除视图
    for (UIView *subviews in [self.view subviews]) {
        
        if (subviews.tag==102) {
            [subviews removeFromSuperview];
        }
        if (subviews.tag==103) {
            [subviews removeFromSuperview];
        }
        //初始化数据
        str1=@"";
        str2=@"";
        str3=@"";
        str4=@"";
        str5=@"";
        str6=@"";
    }
    
    if (allStr.length!=0) {
        
        [self.view.window showHUDWithText:@"请稍等..." Type:ShowLoading Enabled:YES];
        
        UIView *theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
        theView.tag=104;
        [theView bringSubviewToFront:_theTableView];
        theView.backgroundColor=[UIColor blackColor];
        theView.alpha=0.3;
        [self.view addSubview:theView];

        
    }
    
    
}

-(void)popAction
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//判断用户开开头字符是数字或其他字符
-(BOOL)name:(NSString *)name;
{
    
    NSString *NubStr = @"^[0-9]*$";
    
    NSString *OthStr = @"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NubStr];
    
    BOOL isMatch1 = [pred1 evaluateWithObject:name];
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", OthStr];
    
    BOOL isMatch2 = [pred2 evaluateWithObject:name];
    
    
    if (!isMatch2 || isMatch1) {
        
     
        return YES;
        
    }
    
    
    return NO;
}

-(void)popActionButton
{
    
    if (isClick==NO) {
        
        for (UIView *subviews in [self.view subviews]) {
            if (subviews.tag==102) {
                [subviews removeFromSuperview];
            }
            if (subviews.tag==103) {
                [subviews removeFromSuperview];
            }
        }
        
        
    }
    
    isClick = YES;
  
}

-(void)button1Aciton
{

    SuggestViewController *log=[[SuggestViewController alloc] init];
    log.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:log animated:YES];

}

-(void)button2Aciton

{
    if(isClick == NO)
    {
        
        for (UIView *subviews in [self.view subviews]) {
            if (subviews.tag==102) {
                [subviews removeFromSuperview];
            }
            if (subviews.tag==103) {
                [subviews removeFromSuperview];
            }
        }
        

        isClick = YES;
        
    }else {
        

        [self selectView];

        isClick = NO;
    }
  
}

//把数组加入到A～Z
-(void)addAZ:(NSMutableArray *)arrAZ{
    
    //    联系人分组
    _theSectionDic = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < 27; i++)
    {
       if (i==26) {
            
            [_theSectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
            
        }else {
            
            [_theSectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
            
        }
        
        
    }//26个字母
    
    
    if ([arrAZ isKindOfClass:[NSNull class]]) {
        
        
    }else{
        //    把联系人加入26个字母
        for (NSDictionary *dict in arrAZ) {
            
            NSString *nameStr=[dict objectForKey:@"name"];
            
           // NSLog(@"[nameStr substringToIndex:1]=%@",[nameStr substringToIndex:1]);

                if (nameStr.length!=0) {
                    ////判断是数字或其他字符开头
                    if ([self name:[nameStr substringToIndex:1]]==YES) {
    
                        
                        arry = [_theSectionDic objectForKey:@"#"];
                        [arry addObject:dict];
                        
                        
                    }else{
                        //判断是否中文开头
                        if ([self IsChinese:nameStr]==YES) {
                            
                            NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([nameStr characterAtIndex:0])]uppercaseString];
                            arry = [_theSectionDic objectForKey:singlePinyinLetter];
                            
                            [arry addObject:dict];
                            
                        }else{
                            //否则英文字母开头
                            NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",([nameStr characterAtIndex:0])]uppercaseString];
                            arry = [_theSectionDic objectForKey:singlePinyinLetter];
                            [arry addObject:dict];
                            
                        }
  
                }
            }
            
            
            
        }
        //    把A~Z key中空的值，去掉
        for (NSString *key in [_theSectionDic allKeys]) {
            
            if ([key isEqualToString:@"#"]) {
                
                NSArray *arry1 = [_theSectionDic objectForKey:key];
                
                if ([arry1 count]==0) {
                    
                    [_theSectionDic removeObjectForKey:key];
                }

                
            }else{
                
                NSArray *arry1 = [_theSectionDic objectForKey:key];
                
                if ([arry1 count]==0) {
                    
                    [_theSectionDic removeObjectForKey:key];
                }
            }
        
            
           
        }
        NSLog(@"_theSectionDic=%@",[_theSectionDic allKeys ]);
        //   A~Z 排序
        _SortArry = [[_theSectionDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        _theSortArry  = [[NSMutableArray alloc] initWithArray:_SortArry];
        
        // NSLog(@"_theSortArry=%@",_theSortArry);
        [_theTableView reloadData];
    }
    
    

    
}

//判断是否有中文
-(BOOL)IsChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
           return YES;
        }
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

//让分割线左对齐
-(void)viewDidLayoutSubviews {
    
    if ([_theTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_theTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_theTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_theTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    //[self.view.window showHUDWithText:@"正在加载..." Type:ShowLoading Enabled:YES];
        
        if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
            
            return myArr.count;
            
        }else
        {
            NSString *key = [_theSortArry objectAtIndex:section];
            NSArray *arry1 = [_theSectionDic objectForKey:key];
            return arry1.count;
        }
        
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIder = @"cell";
 //   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIder];
      UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIder];
       // cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        

        
//        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
//        imageView.backgroundColor=[UIColor clearColor];
//        [cell.contentView addSubview:imageView];
//        
//        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(55, 7, theWidth-60, 30)];
//        nameLable.backgroundColor=[UIColor clearColor];
//        nameLable.font=[UIFont systemFontOfSize:theFont];
//        [cell.contentView addSubview:nameLable];
//       
//       // NSLog(@"myArr=%@",myArr);
//        if (myArr.count!=0) {
//            
//            NSDictionary *dict=[myArr objectAtIndex:indexPath.row];
//            
//            NSString *strName=[dict objectForKey:@"name"];
//            imageView.image=[UIImage imageNamed:@"friendHeadPic"];
//            nameLable.text = strName;
//            
//        }
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, (70-50)/2, 50, 50)];
        imageView.image=[UIImage imageNamed:@"friendHeadPic"];
        imageView.layer.cornerRadius=25;
        imageView.layer.masksToBounds=YES;
        imageView.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:imageView];
        
        
        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(75, 7, 150, 30)];
        nameLable.alpha=0.8;
        nameLable.backgroundColor=[UIColor clearColor];
        nameLable.font=[UIFont systemFontOfSize:theFont];
        [cell.contentView addSubview:nameLable];
        
        addLable=[[UILabel alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
        addLable.alpha=0.4;
        addLable.backgroundColor=[UIColor clearColor];
        addLable.font=[UIFont systemFontOfSize:theFont-6];
        [cell.contentView addSubview:addLable];
        
        phoneLable=[[UILabel alloc] initWithFrame:CGRectMake(75, 37, 150, 30)];
        phoneLable.alpha=0.8;
        phoneLable.backgroundColor=[UIColor clearColor];
        phoneLable.font=[UIFont systemFontOfSize:theFont-4];
        [cell.contentView addSubview:phoneLable];
        
        UIImageView *imageViewLable=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth-40-20, 10, 40, 20)];
        [cell.contentView addSubview:imageViewLable];
        
    
        NSDictionary *dic1=[myArr objectAtIndex:indexPath.row];
            
            
        nameLable.text = [dic1 objectForKey:@"name"];
        [nameLable sizeToFit];
        CGFloat nameLabelCenterX = nameLable.frame.size.width / 2 + 75;
        CGFloat nameLabelCeneterY = nameLable.frame.size.height / 2 + 10;
        nameLable.center = CGPointMake(nameLabelCenterX, nameLabelCeneterY);
        addLable.text = [[NSString alloc] initWithFormat:@"【%@】",[dic1 objectForKey:@"address"] ];
        CGFloat addLabelCenterX = nameLable.frame.size.width + 80 + addLable.frame.size.width / 2;
        addLable.center = CGPointMake(addLabelCenterX, nameLabelCeneterY);
        
        
        NSString *phoneStr=[dic1 objectForKey:@"mobile"];
        phoneLable.text=[[NSString alloc] initWithFormat:@"%@ %@ %@",[phoneStr substringToIndex:3],[phoneStr substringWithRange:NSMakeRange(3,4)],[phoneStr substringFromIndex:7]];
        
        
        if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"1"]) {
            
            imageViewLable.image=[UIImage imageNamed:@"geust1"];
            
        }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"2"]){
            
            imageViewLable.image=[UIImage imageNamed:@"geust2"];
            
            
        }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"3"]){
            
            imageViewLable.image=[UIImage imageNamed:@"geust3"];
            
            
        }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"4"]){
            
            imageViewLable.image=[UIImage imageNamed:@"geust4"];
            
            
        }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"5"]){
            
            imageViewLable.image=[UIImage imageNamed:@"geust5"];
            
            
        }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"6"]){
            
            imageViewLable.image=[UIImage imageNamed:@"geust6"];
        
          }
        
        }else{
            
            imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, (70-50)/2, 50, 50)];
        imageView.image=[UIImage imageNamed:@"friendHeadPic"];
        imageView.layer.cornerRadius=25;
        imageView.layer.masksToBounds=YES;
        imageView.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:imageView];
        
        
        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(75, 7, 150, 30)];
        nameLable.alpha=0.8;
        nameLable.backgroundColor=[UIColor clearColor];
        nameLable.font=[UIFont systemFontOfSize:theFont];
        [cell.contentView addSubview:nameLable];
        
        addLable=[[UILabel alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
        addLable.alpha=0.4;
        addLable.backgroundColor=[UIColor clearColor];
        addLable.font=[UIFont systemFontOfSize:theFont-6];
        [cell.contentView addSubview:addLable];
        
        phoneLable=[[UILabel alloc] initWithFrame:CGRectMake(75, 37, 150, 30)];
        phoneLable.alpha=0.8;
        phoneLable.backgroundColor=[UIColor clearColor];
        phoneLable.font=[UIFont systemFontOfSize:theFont-4];
        [cell.contentView addSubview:phoneLable];
        
        UIImageView *imageViewLable=[[UIImageView alloc] initWithFrame:CGRectMake(theWidth-40-20, 10, 40, 20)];
        [cell.contentView addSubview:imageViewLable];
        
        if (_theSortArry.count!=0) {
            
            NSString *key = [_theSortArry objectAtIndex:indexPath.section];
            NSArray *arry1 = [_theSectionDic objectForKey:key];
            NSDictionary *dic1=[arry1 objectAtIndex:indexPath.row];
            
            
            nameLable.text = [dic1 objectForKey:@"name"];
            [nameLable sizeToFit];
            CGFloat nameLabelCenterX = nameLable.frame.size.width / 2 + 75;
            CGFloat nameLabelCeneterY = nameLable.frame.size.height / 2 + 10;
            nameLable.center = CGPointMake(nameLabelCenterX, nameLabelCeneterY);
            addLable.text = [[NSString alloc] initWithFormat:@"【%@】",[dic1 objectForKey:@"address"] ];
            CGFloat addLabelCenterX = nameLable.frame.size.width + 80 + addLable.frame.size.width / 2;
            addLable.center = CGPointMake(addLabelCenterX, nameLabelCeneterY);
            
            
            NSString *phoneStr=[dic1 objectForKey:@"mobile"];
            phoneLable.text=[[NSString alloc] initWithFormat:@"%@ %@ %@",[phoneStr substringToIndex:3],[phoneStr substringWithRange:NSMakeRange(3,4)],[phoneStr substringFromIndex:7]];
            
        
            if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"1"]) {
                
                imageViewLable.image=[UIImage imageNamed:@"geust1"];
                
            }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"2"]){
                
                imageViewLable.image=[UIImage imageNamed:@"geust2"];
                
                
            }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"3"]){
                
                imageViewLable.image=[UIImage imageNamed:@"geust3"];
                
                
            }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"4"]){
                
                imageViewLable.image=[UIImage imageNamed:@"geust4"];
                
                
            }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"5"]){
                
                imageViewLable.image=[UIImage imageNamed:@"geust5"];
                
                
            }else if ([[[NSString alloc] initWithFormat:@"%@",[dic1 objectForKey:@"accept"]] isEqualToString:@"6"]){
                
                imageViewLable.image=[UIImage imageNamed:@"geust6"];
                
                
            }
            
            
            
        }
        
        

    }
    
   
  
    return cell;
}


#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
   // NSLog(@"_theSortArry=%@",_theSortArry);
    
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 1;
    }else
    {
        return _theSortArry.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView
    )
    {
        return 0.001;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 0.001;
    }else
    {
        return 1;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        
        
        return nil;
    }
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 15)];
    view1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 2.5, theWidth-20, 15)];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    NSString *key = [_theSortArry objectAtIndex:section];
    label.text =  [[NSString alloc] initWithFormat:@"%@",key];
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
    
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        
        
        NSDictionary *dic1=[myArr objectAtIndex:indexPath.row];
        
     
        if ([_ctrType isEqualToString:@"1"]) {
            
            //添加 字典，将label的值通过key值设置传递
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[dic1 objectForKey:@"name"],@"guestname", nil];
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"notificationname" object:nil userInfo:dict];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
            
        }else{
            
            
            YH_GuestInfoViewController *my=[[YH_GuestInfoViewController alloc] init];
            
            my.dic=dic1;
            [self.navigationController pushViewController:my animated:YES];
            
            
        }
        
    }else{
        
        
        NSString *key = [_theSortArry objectAtIndex:indexPath.section];
        NSArray *arry1 = [_theSectionDic objectForKey:key];
        NSDictionary *dic1=[arry1 objectAtIndex:indexPath.row];
        
        if ([_ctrType isEqualToString:@"1"]) {
            

            //添加 字典，将label的值通过key值设置传递
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[dic1 objectForKey:@"name"],@"guestname", nil];
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"notificationname" object:nil userInfo:dict];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            
            YH_GuestInfoViewController *my=[[YH_GuestInfoViewController alloc] init];

            
             my.dic=dic1;
             [self.navigationController pushViewController:my animated:YES];
            
        }
        
        
        
    }
    
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

    myArr=[[ NSMutableArray  alloc] init];
    
    NSLog(@"myarr=%@",myArr);
    
    NSLog(@"_theSortArry=%@",_theSortArry);
    
    for (NSString *Str in _theSortArry) {
        
        NSArray *arr=[_theSectionDic objectForKey:Str];
        
        for (NSDictionary *dict in arr)  {
            
            NSString *theCityName =[dict objectForKey:@"name"];
            NSString *themoblie=[dict objectForKey:@"mobile"];
            
            NSRange theSearchRange = NSMakeRange(0, theCityName.length);
            NSRange foundRange = [theCityName rangeOfString:searchText options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch range:theSearchRange];
            NSRange foundRange1 = [themoblie rangeOfString:searchText options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch range:theSearchRange];
            
            if (foundRange.length || foundRange1.length) {
                
                [myArr addObject:dict];
                
            }
            
        }
        
    }
    
    
    NSLog(@"arr=%@",myArr);
    
   
}

#pragma mark HttpRequestClassDelegate

-(void)dissActon
{
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
}

//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    
    [self performSelector:@selector(dissActon) withObject:self afterDelay:0.5];
    
    NSLog(@"委托后的数据：%@",dic);
    
    if (COMMANDINT==COMMAND1026) {
        
        if ([[dic objectForKey:@"errcode"] isEqualToString:@"000"]) {
            
            _allArr=[dic objectForKey:@"result"];
            
            [self addAZ:_allArr];
            
            //添加到本地数据
            NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:_allArr];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:encodemenulist forKey:@"myGuest"];
            
            [defaults synchronize];

            
            NSArray *arrCout=[dic objectForKey:@"result"];
            
            if ([arrCout isKindOfClass:[NSNull class]] || arrCout.count==0) {
                
                UIView *theview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
                theview.backgroundColor=[UIColor groupTableViewBackgroundColor];
                theview.tag=101;
                [theview bringSubviewToFront:_theTableView];
                [self.view addSubview:theview];
                
                tishilable=[[UILabel alloc] initWithFrame:CGRectMake(0,((theHeight-110)-30)/2, theWidth, 30)];
                tishilable.textAlignment=NSTextAlignmentCenter;
                tishilable.font=[UIFont systemFontOfSize:25];
                tishilable.alpha=0.4;
                [theview addSubview:tishilable];
                tishilable.text=@"无结果";
                
                
            }else{
                
                _theSearchBar.placeholder=[[NSString alloc] initWithFormat:@"共有%lu个客户",(unsigned long)arrCout.count];
                
                for (UIView *subviews in [self.view subviews]) {
                    
                    if (subviews.tag==101) {
                        [subviews removeFromSuperview];
                    }
                    if (subviews.tag==104) {
                        [subviews removeFromSuperview];
                    }
                }
                
                
            }
        }else{
            
            [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
        }
    }else{
        [self.view.window showHUDWithText:[dic objectForKey:@"errmsg"] Type:ShowPhotoNo Enabled:YES];
    }
        
    
    
    
    [_theTableView reloadData];
    
}




//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
 
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    

    
}

@end
