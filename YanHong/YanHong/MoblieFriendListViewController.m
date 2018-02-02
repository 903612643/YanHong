//
//  MoblieFriendListViewController .m
//  YanHong
//
//  Created by Mr.yang on 15/12/21.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "MoblieFriendListViewController.h"
#import <AddressBook/AddressBook.h>
#import "pinyin.h"
#import "UIWindow+YzdHUD.h"
#import "MoblieFriendViewController.h"
#import "HuaFeiChongZhi.h"


@interface MoblieFriendListViewController ()

@end

@implementation MoblieFriendListViewController


-(void)popAction{
    
    [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)timeAction:(NSTimer *)timer{
    
    theIndex++;
    NSLog(@"%d",theIndex);
    
    if (theIndex==5) {
        
        theIndex=0;
        [timer invalidate];
        
       // [self.view.window showHUDWithText:@"网络请求超时" Type:ShowPhotoNo Enabled:YES];
        [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
        
        
    }
    
}
static int theFont;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    
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
    
    if ([self.title isEqualToString:@"选择号码"]) {
        
    }else{
        //导入Item
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"导入" style:UIBarButtonItemStylePlain target:self action:@selector(theAlterAction)];
        
        
    }
    
    
    //tableFooterView
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(15, 0,theWidth, 40)];
    footView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    countLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, theWidth, 20)];
    countLable.font=[UIFont systemFontOfSize:theFont];
    countLable.alpha=0.6;
    countLable.textAlignment=NSTextAlignmentCenter;
    [footView addSubview:countLable];
    
    _theTableView.tableFooterView=footView;
   
    [self getContants];   //获取通讯录信息
    
    
}
-(void)theAlterAction
{
    [self requestAction:@"请确定导入通讯录?"];
}
//获取通讯录信息
-(void)getContants
{
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    int __block tip=0;
    //声明一个通讯簿的引用
    ABAddressBookRef addBook =nil;
    //因为在IOS6.0之后和之前的权限申请方式有所差别，这里做个判断
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        //创建通讯簿的引用
        addBook=ABAddressBookCreateWithOptions(NULL, NULL);
        //创建一个出事信号量为0的信号
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        //申请访问权限
        ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
            //greanted为YES是表示用户允许，否则为不允许
            if (!greanted) {
                tip=1;
            }
            //发送一次信号
            dispatch_semaphore_signal(sema);
        });
        //等待信号触发
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        //IOS6之前
        addBook =ABAddressBookCreate();
    }
    if (tip) {
        //做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\nSettings>General>Privacy" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return;
    }
    
    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addBook);
    
    strTemp = [[NSString alloc] init];
    
    //获取所有联系人，重新加入allArr数组
    allArr=[[NSMutableArray alloc] init];
    
    
    
    for (NSInteger i=0; i<number; i++) {
        
        //获取所有联系人，加入字典allDic
        allDic=[[NSMutableDictionary alloc] init];
        
        
        //获取联系人对象的引用
        ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
        //获取当前联系人名字
        NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        
        //获取当前联系人姓氏
        NSString*lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        
        
        //如果姓和名都不为空
        if (firstName!=nil && lastName!=nil) {
            name=[lastName stringByAppendingFormat:@"%@",firstName];
            
            [allDic setObject:name forKey:@"fname"];
            
            
        }
        else  if(lastName!=nil && firstName==nil){
            name=lastName;
            [allDic setObject:name forKey:@"fname"];
            
            
        }
        else  if(lastName==nil && firstName!=nil){
            name=firstName;
            [allDic setObject:name forKey:@"fname"];
            
           
            
            
        }else{
            name=@"";
        }

        //        //获取当前联系人中间名
        //        NSString*middleName=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonMiddleNameProperty));
        //        //获取当前联系人的名字前缀
        //        NSString*prefix=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonPrefixProperty));
        //        //获取当前联系人的名字后缀
        //        NSString*suffix=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonSuffixProperty));
        
        //获取当前联系人的昵称
        NSString*nickName=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonNicknameProperty));
        if (nickName.length!=0) {
            
        }else{
            nickName=@"";
        }
        
        //        //获取当前联系人的名字拼音
        //        NSString*firstNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonFirstNamePhoneticProperty));
        //        //获取当前联系人的姓氏拼音
        //        NSString*lastNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonLastNamePhoneticProperty));
        //        //获取当前联系人的中间名拼音
        //        NSString*middleNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonMiddleNamePhoneticProperty));
        
        //获取当前联系人的公司
        NSString *organization=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonOrganizationProperty));
        
        if (organization==nil) {
            [allDic setObject:@"" forKey:@"organization"];
        }else{
            [allDic setObject:organization forKey:@"organization"];
            
        }
        //获取当前联系人的职位
        NSString *job=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonJobTitleProperty));
        if (job==nil) {
            [allDic setObject:@"" forKey:@"job"];
        }else{
            [allDic setObject:job forKey:@"job"];
            
        }
        //获取当前联系人的部门
        NSString *department=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonDepartmentProperty));
        
        //        //获取当前联系人的生日
        //        NSString*birthday=(__bridge NSDate*)(ABRecordCopyValue(people, kABPersonBirthdayProperty));
        NSMutableArray * emailArr = [[NSMutableArray alloc]init];
        //获取当前联系人的邮箱 注意是数组
        ABMultiValueRef emails= ABRecordCopyValue(people, kABPersonEmailProperty);
        for (NSInteger j=0; j<ABMultiValueGetCount(emails); j++) {
            [emailArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(emails, j))];
        }
        NSString *email;
        
        if (emailArr!=nil &&emailArr.count!=0) {
            
            email=[emailArr objectAtIndex:0];
            
            [allDic setObject:[emailArr objectAtIndex:0]  forKey:@"email"];
            
        }
        
        //        //获取当前联系人的备注
        //        NSString*notes=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonNoteProperty));
        //获取当前联系人的电话 数组
        NSMutableArray * phoneArr = [[NSMutableArray alloc]init];
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
            [phoneArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j))];
        }
        //把电话号码放入json
        NSString *phone1=@"";
        NSString *phone2=@"";
        NSString *phone3=@"";
        NSString *phone4=@"";
        NSString *phone5=@"";

        if (phoneArr==nil) {

            [allDic setObject:@"" forKey:@"phone1"];
            [allDic setObject:@"" forKey:@"phone2"];
            [allDic setObject:@"" forKey:@"phone3"];
            [allDic setObject:@"" forKey:@"phone4"];
            [allDic setObject:@"" forKey:@"phone5"];
            
        }else if(phoneArr!=nil && phoneArr.count!=0){
            
            if (phoneArr.count==1) {
                
                phone1=[phoneArr objectAtIndex:0];
                [allDic setObject:phone1 forKey:@"phone1"];
                
                NSString *fristStr=[phone1 substringToIndex:1];
                
                if ([fristStr isEqualToString:@"1"] || [fristStr isEqualToString:@"+"]) {
                    
                    NSString *string = [phone1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone1=string;
                    
                    
                }else{
                    
                    phone1=[phoneArr objectAtIndex:0];
                    
        
                    
                }
                
               
                
                
                
            }else if (phoneArr.count==2){
                
                phone1=[phoneArr objectAtIndex:0];
                phone2=[phoneArr objectAtIndex:1];
                
                [allDic setObject:phone1 forKey:@"phone1"];
                [allDic setObject:phone2 forKey:@"phone2"];
                
                NSString *fristStr1=[phone1 substringToIndex:1];
                NSString *fristStr2=[phone2 substringToIndex:1];
                
                if ([fristStr1 isEqualToString:@"1"] || [fristStr1 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    phone1=string;
                    
                }else{
                    
                    phone1=[phoneArr objectAtIndex:0];
   
                }

                if ([fristStr2 isEqualToString:@"1"] || [fristStr2 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone2=string;
                    
                }else{
                    
                    phone2=[phoneArr objectAtIndex:1];

                }
                
                
                
                
                
            }else if (phoneArr.count==3){
                
                phone1=[phoneArr objectAtIndex:0];
                phone2=[phoneArr objectAtIndex:1];
                phone3=[phoneArr objectAtIndex:2];
                
                [allDic setObject:phone1 forKey:@"phone1"];
                [allDic setObject:phone2 forKey:@"phone2"];
                [allDic setObject:phone3 forKey:@"phone3"];
                
                NSString *fristStr1=[phone1 substringToIndex:1];
                NSString *fristStr2=[phone2 substringToIndex:1];
                NSString *fristStr3=[phone3 substringToIndex:1];
                
                if ([fristStr1 isEqualToString:@"1"] || [fristStr1 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone1=string;
                    
                }else{
                    
                    phone1=[phoneArr objectAtIndex:0];
                    
                }
                
                if ([fristStr2 isEqualToString:@"1"] || [fristStr2 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone2=string;
                    
                }else{
                    
                    phone2=[phoneArr objectAtIndex:1];
                }
                
                if ([fristStr3 isEqualToString:@"1"] || [fristStr3 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone3 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone3=string;
                    
                }else{
                    
                    phone3=[phoneArr objectAtIndex:2];
                }
                
                
              
                
            }else if (phoneArr.count==4){
                
                phone1=[phoneArr objectAtIndex:0];
                phone2=[phoneArr objectAtIndex:1];
                phone3=[phoneArr objectAtIndex:2];
                phone4=[phoneArr objectAtIndex:3];
                
                [allDic setObject:phone1 forKey:@"phone1"];
                [allDic setObject:phone2 forKey:@"phone2"];
                [allDic setObject:phone3 forKey:@"phone3"];
                [allDic setObject:phone4 forKey:@"phone4"];
                
                NSString *fristStr1=[phone1 substringToIndex:1];
                NSString *fristStr2=[phone2 substringToIndex:1];
                NSString *fristStr3=[phone3 substringToIndex:1];
                NSString *fristStr4=[phone4 substringToIndex:1];
                
                if ([fristStr1 isEqualToString:@"1"] || [fristStr1 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone1=string;
                    
                }else{
                    
                    phone1=[phoneArr objectAtIndex:0];
                    
                }
                
                if ([fristStr2 isEqualToString:@"1"] || [fristStr2 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone2=string;
                    
                }else{
                    
                    phone2=[phoneArr objectAtIndex:1];
                }
                
                if ([fristStr3 isEqualToString:@"1"] || [fristStr3 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone3 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone3=string;
                    
                }else{
                    
                    phone3=[phoneArr objectAtIndex:2];
                }
                
                if ([fristStr4 isEqualToString:@"1"] || [fristStr4 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone4 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone4=string;
                    
                }else{
                    
                    phone4=[phoneArr objectAtIndex:3];
                }
                
 
            }else if (phoneArr.count==5){
                
                phone1=[phoneArr objectAtIndex:0];
                phone2=[phoneArr objectAtIndex:1];
                phone3=[phoneArr objectAtIndex:2];
                phone4=[phoneArr objectAtIndex:3];
                phone5=[phoneArr objectAtIndex:4];
                
                [allDic setObject:phone1 forKey:@"phone1"];
                [allDic setObject:phone2 forKey:@"phone2"];
                [allDic setObject:phone3 forKey:@"phone3"];
                [allDic setObject:phone4 forKey:@"phone4"];
                [allDic setObject:phone5 forKey:@"phone5"];
                
                NSString *fristStr1=[phone1 substringToIndex:1];
                NSString *fristStr2=[phone2 substringToIndex:1];
                NSString *fristStr3=[phone3 substringToIndex:1];
                NSString *fristStr4=[phone4 substringToIndex:1];
                NSString *fristStr5=[phone5 substringToIndex:1];
                
                if ([fristStr1 isEqualToString:@"1"] || [fristStr1 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone1 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone1=string;
                    
                }else{
                    
                    phone1=[phoneArr objectAtIndex:0];
                    
                }
                
                if ([fristStr2 isEqualToString:@"1"] || [fristStr2 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone2=string;
                    
                }else{
                    
                    phone2=[phoneArr objectAtIndex:1];
                }
                
                if ([fristStr3 isEqualToString:@"1"] || [fristStr3 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone3 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone3=string;
                    
                }else{
                    phone3=[phoneArr objectAtIndex:2];
                    
                }
                
                if ([fristStr4 isEqualToString:@"1"] || [fristStr4 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone4 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone4=string;
                    
                }else{
                    phone4=[phoneArr objectAtIndex:3];
                    
                }
                
                if ([fristStr5 isEqualToString:@"1"] || [fristStr5 isEqualToString:@"+"]) {
                    
                    NSString *string = [phone5 stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    phone5=string;
                    
                }else{
                    
                    phone5=[phoneArr objectAtIndex:4];
                }
                
            }
        
        }
        
        //        //获取创建当前联系人的时间 注意是NSDate
        //        NSDate*creatTime=(__bridge NSDate*)(ABRecordCopyValue(people, kABPersonCreationDateProperty));
        //        //获取最近修改当前联系人的时间
        //        NSDate*alterTime=(__bridge NSDate*)(ABRecordCopyValue(people, kABPersonModificationDateProperty));
        //获取地址
        ABMultiValueRef address = ABRecordCopyValue(people, kABPersonAddressProperty);
        NSString *adress;
        for (int j=0; j<ABMultiValueGetCount(address); j++) {
            //地址类型
            NSString * type = (__bridge NSString *)(ABMultiValueCopyLabelAtIndex(address, j));
            NSDictionary * temDic = (__bridge NSDictionary *)(ABMultiValueCopyValueAtIndex(address, j));
            //            //地址字符串，可以按需求格式化
            adress = [NSString stringWithFormat:@"%@%@%@%@",[temDic valueForKey:(NSString*)kABPersonAddressCountryKey],[temDic valueForKey:(NSString*)kABPersonAddressStateKey],[temDic valueForKey:(NSString*)kABPersonAddressCityKey],[temDic valueForKey:(NSString*)kABPersonAddressStreetKey]];
            
            if (adress.length==0) {
                
                [allDic setObject:@"" forKey:@"address"];
                
            }else{
                
                [allDic setObject:adress forKey:@"address"];
                
            }
            
            
        }
        if (adress.length!=0) {
            
        }else{
            adress=@"";
        }
        //获取当前联系人头像图片
        NSData *userImage=(__bridge NSData*)(ABPersonCopyImageData(people));
        // NSLog(@"userImage=%@",userImage);
        // UIImage *image=[UIImage imageWithData:userImage];
        
        //        //获取当前联系人纪念日
        //        NSMutableArray * dateArr = [[NSMutableArray alloc]init];
        //        ABMultiValueRef dates= ABRecordCopyValue(people, kABPersonDateProperty);
        //        for (NSInteger j=0; j<ABMultiValueGetCount(dates); j++) {
        //            //获取纪念日日期
        //            NSDate * data =(__bridge NSDate*)(ABMultiValueCopyValueAtIndex(dates, j));
        //            //获取纪念日名称
        //            NSString * str =(__bridge NSString*)(ABMultiValueCopyLabelAtIndex(dates, j));
        //            NSDictionary * temDic = [NSDictionary dictionaryWithObject:data forKey:str];
        //            [dateArr addObject:temDic];
        //        }
        
        //json
        NSString *strJson1 = [[NSString alloc] initWithFormat:@"{\"fname\":\"%@\",\"nickName\":\"%@\",\"phone1\":\"%@\",\"phone2\":\"%@\",\"phone3\":\"%@\",\"phone4\":\"%@\",\"phone5\":\"%@\",\"gender\":\"\",\"email\":\"%@\",\"address\":\"%@\"}",name,nickName,phone1,phone2,phone3,phone4,phone5,email,adress];
        
        if (i!=(number-1)) {
            strTemp = [strTemp stringByAppendingFormat:@"%@,",strJson1];
        }
        else if(i==(number-1)){
            strTemp = [strTemp stringByAppendingFormat:@"%@",strJson1];
        }

        [allArr addObject:allDic];
    
        
        
    }
    
     NSLog(@"array=%@",allArr);
    
    
    
    //联系人总数
   // countLable.text=[[NSString alloc] initWithFormat:@"%lu位联系人",(unsigned long)allArr.count];
    
    _theSearchBar.placeholder=[[NSString alloc] initWithFormat:@"%lu位联系人",(unsigned long)allArr.count];
    
    // 联系人分组26个字母
    _theSectionDic = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < 26; i++)
    {
        [_theSectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
    }
    
    //  把联系人加入26个字母
    for (NSDictionary *dict in allArr) {
        
        NSString *nameStr=[dict objectForKey:@"fname"];
        if ([self IsChinese:nameStr]==YES) {
            NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([nameStr characterAtIndex:0])]uppercaseString];
            arry = [_theSectionDic objectForKey:singlePinyinLetter];
            [arry addObject:dict];
            
        }else{
            NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",[nameStr characterAtIndex:0]]uppercaseString];
            arry = [_theSectionDic objectForKey:singlePinyinLetter];
            [arry addObject:dict];
        }
    }
    
    //    把A~Z key中空的值，去掉
    for (NSString *key in [_theSectionDic allKeys]) {
        NSArray *arry1 = [_theSectionDic objectForKey:key];
        if ([arry1 count]==0) {
            [_theSectionDic removeObjectForKey:key];
        }
    }
    
    //   A~Z 排序
    _SortArry = [[_theSectionDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    _theSortArry  = [[NSMutableArray alloc] initWithArray:_SortArry];
    
   // NSLog(@"_theSectionDic=%@",_theSectionDic);
}

//判断通讯录是否有中文
-(BOOL)IsChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;//有
        }
    }
    return NO;//没有
}

//ios9.0导入提示
-(void)requestAction:(NSString *)str
{
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertControllerStyleAlert];
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _theView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, theHeight)];
        _theView.backgroundColor=[UIColor blackColor];
        _theView.tag=101;
        _theView.alpha=0.2;
        [self.view addSubview:_theView];

        
      [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(theTimeAction:) userInfo:nil repeats:YES];
        
        //创建多线程的方法
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(methodThread) object:nil];
        //开启线程
        [thread start];
        [self.view.window showHUDWithText:@"正在导入..." Type:ShowLoading Enabled:YES];
    }];
    //    把事件添加到控制器
    [alertViewCtr addAction:cancelAction];
    [alertViewCtr addAction:sureAction];
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^{
        
    }];
}
//使用多线程请求数据
-(void)methodThread
{
   
    //请求数据
    NSString *strJson2 = [[NSString alloc] initWithFormat:@"{\"packmd5\":\"MD5MD5MDMD5MD5MDMD5MD5MDMD5MD5MD\",\"ver\":\"1.0\",\"command\":\"1049\",\"errcode\":\"000\",\"errmsg\":\"\",\"timestamp\":\"137889283\",\"uid\":\"%@\",\"apptype\":\"2\",\"count\":\"%ld\",\"type\":\"1\",\"result\":[%@]}",[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],(unsigned long)allArr.count,strTemp];

    httpRequest=[[HttpRequestCalss alloc] init];
    
     NSString *url1=[NSString stringWithFormat:THE_POSTURL];
    
    httpRequest.delegate=self;
    
    [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [httpRequest postJSONWithUrl:url1 parameters:strJson2 success:^(id responseObject) {
        
    } fail:^{
        
    }];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
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
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
        imageView.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:imageView];
        
        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(55, 7, 150, 30)];
        nameLable.backgroundColor=[UIColor clearColor];
        nameLable.alpha=0.7;
        nameLable.font=[UIFont systemFontOfSize:theFont-2];
        [cell.contentView addSubview:nameLable];
        
        // NSLog(@"myArr=%@",myArr);
        
        NSDictionary *dict=[myArr objectAtIndex:indexPath.row];
        
        NSString *strName=[dict objectForKey:@"fname"];
        imageView.image=[UIImage imageNamed:@"theHead"];
        nameLable.text = strName;
        
        
    }else{
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
        imageView.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:imageView];
        
        nameLable=[[UILabel alloc] initWithFrame:CGRectMake(55, 7, 150, 30)];
        nameLable.backgroundColor=[UIColor clearColor];
        nameLable.font=[UIFont systemFontOfSize:theFont];
        [cell.contentView addSubview:nameLable];
        
        NSString *key = [_theSortArry objectAtIndex:indexPath.section];
        NSArray *arry1 = [_theSectionDic objectForKey:key];
        
        NSDictionary *dict=[arry1 objectAtIndex:indexPath.row];
        
        NSString *nameStr=[dict objectForKey:@"fname"];
        imageView.image=[UIImage imageNamed:@"theHead"];
        nameLable.text = nameStr;
        
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 1;
    }else
    {
        return _theSortArry.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView)
    {
        return 1;
    }
    return 25;
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theWidth, 25)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, theWidth-20, 21)];
    label.font=[UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    label.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    NSString *key = [_theSortArry objectAtIndex:section];
    label.text  =  [[NSString alloc] initWithFormat:@" %@",key];
    [view addSubview:label];
    return view;

}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 0;
    }
    _theTableView.sectionIndexColor = [UIColor grayColor];
    
    return _SortArry;
    
}// return list of section titles to display in section index view (e.g. "ABCD...Z#")

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    if (tableView == _theSearchDisplayCtr.searchResultsTableView) {
        return 0;
    }
    return index;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

    
    if ([self.title isEqualToString:@"选择号码"]) {
        
        NSString *key = [_theSortArry objectAtIndex:indexPath.section];
        NSArray *arry1 = [_theSectionDic objectForKey:key];
        NSDictionary *dict1=[arry1 objectAtIndex:indexPath.row];
        
        //添加 字典，将label的值通过key值设置传递
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:[dict1 objectForKey:@"phone1"],@"phoneNumber", nil];
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"notificationPhone" object:nil userInfo:dict];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
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
    for (NSString *Str in _theSortArry) {
        
        NSArray *arr=[_theSectionDic objectForKey:Str];
        
        for (NSDictionary *dict in arr)  {
            NSString *theCityName =[dict objectForKey:@"fname"];
            NSRange theSearchRange = NSMakeRange(0, theCityName.length);
            NSRange foundRange = [theCityName rangeOfString:searchText options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch range:theSearchRange];
            if (foundRange.length) {
                
                [myArr addObject:dict];
                
            }
            
        }
        
    }
    NSLog(@"myarr=%@",myArr);
}

#pragma mark HttpRequestClassDelegate
//请求成功的方法
- (void)theSuccess:(id)json andHttpRequest:(HttpRequestCalss *)httpClass;
{
    dic=[[NSDictionary alloc] initWithDictionary:json];
    //判断请求成功后
    if (COMMANDINT==COMMAND1050) {
        
        //本地数据设为空
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:nil forKey:@"myFriarray"];
        
        [defaults synchronize];


        [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
        
        UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:@"导入成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self performSelector:@selector(sueccAction) withObject:self afterDelay:0.5];
            
        }];
        //    把事件添加到控制器
        [alertViewCtr addAction:sureAction];
        //    模态视图
        [self presentViewController:alertViewCtr animated:YES completion:^{
            
        }];
    }
   
}
//延时调用
-(void)sueccAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//请求失败
- (void)theFail:(NSError *)error andHttpRequest:(HttpRequestCalss *)httpClass;
{
   //  NSLog(@"error = %@",error);
    
}

-(void)theTimeAction:(NSTimer *)timer{
    
    idex++;
    
    NSLog(@"idex=%d",idex);
    
    if (dic==nil && dic.count==0) {
        
        if (idex==10 ) {
            
            [self.view.window showHUDWithText:@"连接超时" Type:ShowPhotoNo Enabled:YES];
            
        }
        if (idex==11){
            
            [timer invalidate];
            
            [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }else{

            [self.view.window showHUDWithText:nil Type:ShowDismiss Enabled:YES];
  
        [timer invalidate];
        idex=0;
    }
    
}


@end
