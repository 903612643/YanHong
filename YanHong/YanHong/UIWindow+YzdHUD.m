//
//  MyViewController.h
//  YanHong
//
//  Created by Mr.yang on 15/12/1.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//
#import "UIWindow+YzdHUD.h"
#import "YzdHUDBackgroundView.h"
#import "YzdHUDImageView.h"
#import "YzdHUDIndicator.h"
#import "YzdHUDLabel.h"


#define YzdHUDCenter CGPointMake(theWidth/2, theHeight/2+20)

#define YzdHUDBackgroundAlpha 1
#define YzdHUDComeTime 0.15
#define YzdHUDStayTime 1.5
#define YzdHUDGoTime 0.35


static int YzdHUDFont;

@implementation UIWindow (YzdHUD)

-(void)showHUDWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled{
    
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        YzdHUDFont=12;
        
        [self showHUDWithText:text Type:type Enabled:(BOOL)enabled Bounds:CGRectMake(0, 0, 80, 80) Center:YzdHUDCenter BackgroundAlpha:YzdHUDBackgroundAlpha ComeTime:YzdHUDComeTime StayTime:YzdHUDStayTime GoTime:YzdHUDGoTime];
        
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        YzdHUDFont=12;
        
        [self showHUDWithText:text Type:type Enabled:(BOOL)enabled Bounds: CGRectMake(0, 0,80, 80) Center:YzdHUDCenter BackgroundAlpha:YzdHUDBackgroundAlpha ComeTime:YzdHUDComeTime StayTime:YzdHUDStayTime GoTime:YzdHUDGoTime];
        
    }else if (IS_IPHONE_6) {  // 6
        
        YzdHUDFont=15;
        
        [self showHUDWithText:text Type:type Enabled:(BOOL)enabled Bounds: CGRectMake(0, 0, 100, 100) Center:YzdHUDCenter BackgroundAlpha:YzdHUDBackgroundAlpha ComeTime:YzdHUDComeTime StayTime:YzdHUDStayTime GoTime:YzdHUDGoTime];
        
        
    }else if (IS_IPHONE_6P){
        
        YzdHUDFont=15;
        
        [self showHUDWithText:text Type:type Enabled:(BOOL)enabled Bounds:CGRectMake(0, 0, 100, 100) Center:YzdHUDCenter BackgroundAlpha:YzdHUDBackgroundAlpha ComeTime:YzdHUDComeTime StayTime:YzdHUDStayTime GoTime:YzdHUDGoTime];
        
    }

    
    
}

-(void)showHUDWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    
    static BOOL isShow = YES;
    
    if (isShow) {
        
        isShow = NO;
        
        [self addSubview:[YzdHUDBackgroundView shareHUDView]];
        [self addSubview:[YzdHUDImageView shareHUDView]];
        [self addSubview:[YzdHUDLabel shareHUDView]];
        [self addSubview:[YzdHUDIndicator shareHUDView]];
        
        [YzdHUDBackgroundView shareHUDView].center = center;
        [YzdHUDLabel shareHUDView].center = CGPointMake(center.x, center.y + bounds.size.height/3.5);
        [YzdHUDImageView shareHUDView].center = CGPointMake(center.x, center.y - bounds.size.height/6);
        [YzdHUDIndicator shareHUDView].center = CGPointMake(center.x, center.y - bounds.size.height/6);
        [self goTimeBounds:bounds];
        
    }
    [YzdHUDLabel shareHUDView].bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height/2 - 10);
    if ([self textLength:text] * YzdHUDFont + 10 >= bounds.size.width) {
        [YzdHUDLabel shareHUDView].font = [UIFont systemFontOfSize:YzdHUDFont];
    }
    self.userInteractionEnabled = enabled;
    
    switch (type) {
        case ShowLoading:
            [self showLoadingWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime];
            break;
        case ShowPhotoYes:
            [self showPhotoYesWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime];
            break;
        case ShowPhotoNo:
            [self showPhotoNoWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime];
            break;
        case ShowDismiss:
            [self showDismissWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime];
            break;
        default:
            break;
    }
}
-(void)showLoadingWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    if ([YzdHUDBackgroundView shareHUDView].alpha != 0) {
        return;
    }
    [YzdHUDLabel shareHUDView].text = text;
    [[YzdHUDIndicator shareHUDView] stopAnimating];
    [YzdHUDImageView shareHUDView].alpha = 0;

    [UIView animateWithDuration:comeTime animations:^{
        [self comeTimeBounds:bounds];
        [self comeTimeAlpha:backgroundAlpha withImage:NO];
        [[YzdHUDIndicator shareHUDView] startAnimating];
    } completion:^(BOOL finished) {

    }];
}
-(void)showPhotoYesWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    if ([[YzdHUDIndicator shareHUDView] isAnimating]) {
        [[YzdHUDIndicator shareHUDView] stopAnimating];
        
        [YzdHUDImageView shareHUDView].bounds =
        CGRectMake(0, 0, (bounds.size.width/2.5 - 5) * 2, (bounds.size.height/2.5 - 5) * 2);
    }else{
        if ([YzdHUDBackgroundView shareHUDView].alpha != 0) {
            return;
        }
        [self goTimeBounds:bounds];
        [self goTimeInit];
    }
    
    [YzdHUDLabel shareHUDView].text = text;
    [YzdHUDImageView shareHUDView].image = [UIImage imageNamed:@"HUD_YES"];
    
    [UIView animateWithDuration:comeTime animations:^{
        [self comeTimeBounds:bounds];
        [self comeTimeAlpha:backgroundAlpha withImage:YES];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:stayTime animations:^{
            [self stayTimeAlpha:backgroundAlpha];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:goTime animations:^{
                [self goTimeBounds:bounds];
                [self goTimeInit];;
            } completion:^(BOOL finished) {
                //Nothing
            }];
        }];
    }];
}
-(void)showPhotoNoWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    if ([[YzdHUDIndicator shareHUDView] isAnimating]) {
        [[YzdHUDIndicator shareHUDView] stopAnimating];
        
        [YzdHUDImageView shareHUDView].bounds =
        CGRectMake(0, 0, (bounds.size.width/2.5 - 5) * 2, (bounds.size.height/2.5 - 5) * 2);
    }else{
        if ([YzdHUDBackgroundView shareHUDView].alpha != 0) {
            return;
        }
        [self goTimeBounds:bounds];
        [self goTimeInit];
    }
    
    [YzdHUDLabel shareHUDView].text = text;
    [YzdHUDImageView shareHUDView].image = [UIImage imageNamed:@"HUD_NO"];
    [UIView animateWithDuration:comeTime animations:^{
        [self comeTimeBounds:bounds];
        [self comeTimeAlpha:backgroundAlpha withImage:YES];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:stayTime animations:^{
            [self stayTimeAlpha:backgroundAlpha];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:goTime animations:^{
                [self goTimeBounds:bounds];
                [self goTimeInit];;
            } completion:^(BOOL finished) {
                //Nothing
            }];
        }];
    }];
}
-(void)showDismissWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    if ([[YzdHUDIndicator shareHUDView] isAnimating]) {
        [[YzdHUDIndicator shareHUDView] stopAnimating];
    }
    [YzdHUDLabel shareHUDView].text = nil;
    [YzdHUDImageView shareHUDView].image = nil;
    [UIView animateWithDuration:goTime animations:^{
        [YzdHUDImageView shareHUDView].bounds =
        CGRectMake(0, 0, (bounds.size.width/2.5 - 5) * 2, (bounds.size.height/2.5 - 5) * 2);
        [self goTimeBounds:bounds];
        [self goTimeInit];
    } completion:^(BOOL finished) {
        //Nothing
    }];
}

#pragma mark 状态

-(void)goTimeBounds:(CGRect)bounds{
    [YzdHUDBackgroundView shareHUDView].bounds =
    CGRectMake(0, 0, bounds.size.width , bounds.size.height);
    [YzdHUDImageView shareHUDView].bounds =
    CGRectMake(0, 0, (bounds.size.width/2.5 - 5) * 2, (bounds.size.height/2.5 - 5) * 2);
}
-(void)goTimeInit{
    [YzdHUDBackgroundView shareHUDView].alpha = 0;
    [YzdHUDImageView shareHUDView].alpha = 0;
    [YzdHUDLabel shareHUDView].alpha = 0;
    [[YzdHUDIndicator shareHUDView] stopAnimating];
}
-(void)stayTimeAlpha:(CGFloat)alpha{
    //改变透明头
    [YzdHUDBackgroundView shareHUDView].alpha = alpha - 0.05;
}
-(void)comeTimeBounds:(CGRect)bounds{
    [YzdHUDBackgroundView shareHUDView].bounds =
    CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    [YzdHUDImageView shareHUDView].bounds =
    CGRectMake(0, 0, bounds.size.width/2.5 - 5, bounds.size.height/2.5 - 5);
}
-(void)comeTimeAlpha:(CGFloat)alpha withImage:(BOOL)isImage{
    [YzdHUDBackgroundView shareHUDView].alpha = alpha;
    [YzdHUDLabel shareHUDView].alpha = 1;
    if (isImage) {
        [YzdHUDImageView shareHUDView].alpha = 1;
    }
}

#pragma mark - 计算字符串长度
- (int)textLength:(NSString *)text{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            number = number + 0.5;
        }
    }
    return ceil(number);
}


@end
