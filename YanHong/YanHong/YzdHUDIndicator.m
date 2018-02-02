//
//  MyViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/1.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//
#import "YzdHUDIndicator.h"

static YzdHUDIndicator *_shareHUDView = nil;
@implementation YzdHUDIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(YzdHUDIndicator *)shareHUDView{
    if (!_shareHUDView) {
        _shareHUDView = [[YzdHUDIndicator alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _shareHUDView;
}

@end
