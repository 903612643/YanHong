//
//  HouseSaleViewController.h
//  YanHong
//
//  Created by Mr.yang on 16/1/6.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HttpRequestCalss.h"

#import "ZYQAssetPickerController.h"


@interface HouseSaleViewController : UIViewController<UITextFieldDelegate,HttpRequestClassDelegate,UITextViewDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,ZYQAssetPickerControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    //保存输入的值供下次使用
    NSUserDefaults *userDef;
    
    UITextField *_houseNameTextFiled;//楼盘名称
    
    UITextField *_textField2;//建筑面积
    UITextField *_houseAddess;//地址
    
    UILabel *liftLable;//电梯
    UILabel *decorationtype;//装修类型
    UILabel *propertytype;//物业类型
    UITextField *bulidingYear;//建筑年份
    UITextField *tiptextf;//标题
    

    
    UITextField *_textField;//共几层
    UITextField *_ditextField;//第几层
    UILabel *allf;//共
    UILabel *dijic;//第
    UILabel *ceng;//层
    
    UILabel *addressLable;
    
    UITextView *_textView;
    
    UIImageView *imageViewTheButton;
    
    UIButton *_houesButton;//楼盘地方
    
    UILabel *theTishiLable;
    
    UILabel *_projectId;

    NSDictionary *dic;
    
    NSMutableArray *_titleArr;
    
    NSMutableArray *_titleArr2;
    
    UITableViewCell *tabCell;

    UILabel *stopTime;
    //截止时间
    UIView *_timePickerView;
    
    UILabel *saleLable;
    
    UIView *PicView;
    
    UIDatePicker *datePicker;
    

    NSMutableArray *_imageArrQian;//压缩前的Arr,供PicBrowserViewController保持原有的分辨率
    
    NSMutableArray *_imageArr;//压缩后的Arr，上传前需要压缩
    
    HttpRequestCalss *httpRequest;
    

    UILabel *_orientationLable;
    
    NSArray *_shiArry;
    NSArray *_tiArry;
    NSArray *_weiArry;
    
    UIPickerView *thepickerView;
    
    NSString *value1;
    NSString *value2;
    NSString *value3;
    
    UILabel *houestypeLable;

    
}



@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
