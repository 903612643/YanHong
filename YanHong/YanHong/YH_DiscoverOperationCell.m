//
//  YH_DiscoverOperationCell.m
//  YanHong
//
//  Created by anbaoxing on 16/2/26.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_DiscoverOperationCell.h"

@interface YH_DiscoverOperationCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YH_DiscoverOperationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图标
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(25, 10, 31, 30);
        [self addSubview:_iconImageView];
        
        //标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.alpha=0.7;
        _titleLabel.frame = CGRectMake(70, 10, 100, 30);
        [self addSubview:_titleLabel];
        
        
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (IS_IPHONE_4_OR_LESS) {
            _iconImageView.frame = CGRectMake(20, 8, 23, 22);
            
            _titleLabel.frame = CGRectMake(50, 8, 100, 22);
            _titleLabel.font = [UIFont systemFontOfSize:13];
        }else if (IS_IPHONE_5) {
            _iconImageView.frame = CGRectMake(20, 9, 23, 22);
            
            _titleLabel.frame = CGRectMake(55, 8, 100, 24);
            _titleLabel.font = [UIFont systemFontOfSize:14];
        }
    }
    
    return self;
}

- (void)setData:(YH_DiscoverOperationData *)data {
    _iconImageView.image = data.iconImage;
    _titleLabel.text = data.title;
}

@end
