//
//  YH_CustomProgress.m
//  YanHong
//
//  Created by Mr.yang on 16/4/13.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_CustomProgress.h"

@implementation YH_CustomProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        // 背景图像
        _trackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_trackView setImage:[UIImage imageNamed:@"wait_progress_back"]];
        _trackView.clipsToBounds = YES;//当前view的主要作用是将出界了的_progressView剪切掉，所以需将clipsToBounds设置为YES
        [self addSubview:_trackView];
        // 填充图像
        _progressView = [[UIImageView alloc] initWithFrame:CGRectMake(0-frame.size.width, 0, frame.size.width, frame.size.height)];
        [_progressView setImage:[UIImage imageNamed:@"wait_progress"]];
        [_trackView addSubview:_progressView];
        
        _currentProgress = 5.0;
        
    }
    return self;
}

- (void)setProgress:(CGFloat)progress withInt:(int)count{
    
    if (0 == progress) {
        
        self.currentProgress = 0;
        [self changeProgressViewFrame];
        
        return;
        
    }
    
    _targetProgress = progress;
    
    if (count==1) {
        
        _progressView.frame = CGRectMake(0 , 0, 46, 40);

    }else if (count==2){
        
        _progressView.frame = CGRectMake(0 , 0, 92, 40);
        
        
    }else if (count==3){
        
        _progressView.frame = CGRectMake(0 , 0, 132, 40);
        
    }else if (count==4){
        
        _progressView.frame = CGRectMake(0 , 0, 184, 40);
        
    }else if (count==5){
        
        _progressView.frame = CGRectMake(0 , 0, 230, 40);
        
        [_delegate endTime];
    }
    
    if (_progressTimer == nil)
    {
        //创建定时器
       // _progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(moveProgress) userInfo:nil repeats:YES];
    }
    
}

//////////////////////////////////////////////////////
//修改进度
- (void) moveProgress
{
    //判断当前进度是否大于进度值
    if (self.currentProgress < _targetProgress)
    {
        self.currentProgress = MIN(self.currentProgress + 0.1*_targetProgress, _targetProgress);
        
        if (_targetProgress >=10) {
            
            [_delegate changeTextProgress:[NSString stringWithFormat:@"%d %%",(int)self.currentProgress]];
            
        }else{
            
            [_delegate changeTextProgress:[NSString stringWithFormat:@"%.1f %%",self.currentProgress]];
            
        }
        
        //改变界面内容
        [self changeProgressViewFrame];
        
    } else {
        //当超过进度时就结束定时器，并处理代理方法
        [_progressTimer invalidate];
        _progressTimer = nil;
        [_delegate endTime];  
    }  
}

//修改显示内容  
- (void)changeProgressViewFrame{  
    //只要改变frame的x的坐标就能看到进度一样的效果  
    _progressView.frame = CGRectMake(self.frame.size.width * (_currentProgress/_targetProgress) - self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);  
}  


@end
