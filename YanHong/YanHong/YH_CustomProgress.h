//
//  YH_CustomProgress.h
//  YanHong
//
//  Created by Mr.yang on 16/4/13.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  CustomProgressDelegate<NSObject>

//修改进度标签内容
- (void)changeTextProgress:(NSString*)string;
//进度条结束时
- (void)endTime;

@end

@interface YH_CustomProgress : UIView


// 背景图像
@property (retain, nonatomic) UIImageView *trackView;
// 填充图像
@property (retain, nonatomic) UIImageView *progressView;

@property (retain, nonatomic) NSTimer *progressTimer; //时间定时器

@property (nonatomic) CGFloat targetProgress; //进度
@property (nonatomic) CGFloat currentProgress; //当前进度

@property (nonatomic, strong)id<CustomProgressDelegate> delegate;

- (void)setProgress:(CGFloat)progress withInt:(int)count;//设置进度

@end
