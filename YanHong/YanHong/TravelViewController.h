//
//  TravelViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/1/21.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequestCalss.h"
#import "ZYQAssetPickerController.h"
#import "YH_CustomProgress.h"

@interface TravelViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate,UITextViewDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,ZYQAssetPickerControllerDelegate,UIImagePickerControllerDelegate,CustomProgressDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIImageView *imageViewTheButton;
    
    NSDictionary *dic;
    
    NSMutableArray *_imageArrQian;//压缩前的Arr,供PicBrowserViewController保持原有的分辨率
    
    NSMutableArray *_imageArr;//压缩后的Arr，上传前需要压缩
    
    UIView *PicView;
    
    NSArray *_titleArr;
    
    HttpRequestCalss *httpRequest;
    
    //保存输入的值供下次使用
    NSUserDefaults *userDef;
    
    UITextField *_houseNameTextFiled;//楼盘名称
    
    UITextField *_textField;//平米
    
    UITextField *_textField2;
    
    UITextField *_houseAddess;// ＝地址
    
    UITextField *_textField4;//室
    UITextField *_textField5;//厅
    UITextField *_textField6;//卫
    
    UITextField *_textField7;
    
    UITextField *_payTypeTextField;//付款方式
    
    UITextField *_deviceTextField;//配套设施
    
    UITextField *_userNameTextField;//姓名
    
    
    UITextField *_userPhoneTextField;//手机号码
    
    UILabel *_payTypeLable;
    
    UILabel *_deviceLable;
    
    UILabel *_userNameLable;
    
    UITextField *_ditextField;//第几层
    UILabel *allf;//共
    UILabel *dijic;//第
    UILabel *ceng;//层
    
    UILabel *liftLable;//电梯
    UILabel *decorationtype;//装修类型
    UILabel *propertytype;//物业类型
    UITextField *bulidingYear;//建筑年份
    UITextField *tiptextf;//标题

    
    UILabel *_userPhoneLable;
    
    
    UILabel *_lable4;
    
    UILabel *_lable5;
    
    UILabel *_lable6;
    
    UILabel *_orientationLable;
    
    UILabel *addressLable;
    
    UILabel *zuJin;
    
    UIView *theView;
    
    UITextView *_textView;
    
    UILabel *theTishiLable;
    
    UIButton *getTextButton;//性别
    
    NSString *getSexStr;
    
    UIView *_theView;
    
    UILabel *thepLable;
    
    UIImageView *_trackView;
    UIImageView *_progressView;
    int imageCount;

    NSString *hid;
    
    NSArray *_shiArry;
    NSArray *_tiArry;
    NSArray *_weiArry;
    
    UIPickerView *thepickerView;
    
    NSString *value1;
    NSString *value2;
    NSString *value3;
    
    UILabel *houestypeLable;
    
}

@property (weak, nonatomic) IBOutlet UITableView *theTableView;


@end
