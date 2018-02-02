//
//  YH_WalletFunctionCell.m
//  YanHong
//
//  Created by anbaoxing on 16/2/27.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_WalletFunctionCell.h"

@interface YH_WalletFunctionCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YH_WalletFunctionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //图标
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(0, 0, 30, 30);
        [self addSubview:_iconImageView];
        
        //标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.alpha=0.8;
        [self addSubview:_titleLabel];
        
        if (IS_IPHONE_4_OR_LESS) {
            _iconImageView.frame = CGRectMake(0, 0, 25, 25);
            _titleLabel.alpha=0.8;
            _titleLabel.font = [UIFont systemFontOfSize:12];
        }else if (IS_IPHONE_5) {
            _iconImageView.frame = CGRectMake(0, 0, 25, 25);
            _titleLabel.alpha=0.8;
            _titleLabel.font = [UIFont systemFontOfSize:12];
        }
    }
    
    return self;
}

- (void)setData:(YH_WalletFunctioinData *)data {
    
    if (data.title == nil) {
        self.backgroundColor = [UIColor whiteColor];
        _iconImageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        _iconImageView.image = data.iconImage;
    }else{
        self.backgroundColor = [UIColor whiteColor];
        _iconImageView.image = data.iconImage;
        _iconImageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 3);
        
        _titleLabel.text = data.title;
        [_titleLabel sizeToFit];
        _titleLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height * 2 / 3);
    }
}

@end
