//
//  MyViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/1.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "YzdHUDBackgroundView.h"
#import <QuartzCore/QuartzCore.h>

static YzdHUDBackgroundView *_shareHUDView = nil;
@implementation YzdHUDBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
  
    }
    return self;
}

+(YzdHUDBackgroundView *)shareHUDView{
    if (!_shareHUDView) {
        _shareHUDView = [[YzdHUDBackgroundView alloc] init];
        _shareHUDView.alpha = 0;
        _shareHUDView.layer.masksToBounds = YES;
        _shareHUDView.layer.cornerRadius = 5;
        _shareHUDView.barStyle = UIBarStyleBlackTranslucent;
    }
    return _shareHUDView;
}



@end
