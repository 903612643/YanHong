//
//  YH_MyOperationCell.m
//  YanHong
//
//  Created by anbaoxing on 16/2/26.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_MyOperationCell.h"

@interface YH_MyOperationCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YH_MyOperationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图标
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = CGRectMake(15, 3, 27, 30);
        [self addSubview:_iconImageView];
        //标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.alpha=0.7;
        _titleLabel.frame = CGRectMake(55, 3, 100, 30);
        [self addSubview:_titleLabel];
        
       if(IS_IPHONE_6P){
           
            _iconImageView.frame = CGRectMake(10, 6, 27, 30);
            _titleLabel.frame = CGRectMake(50, 6, 100, 30);
            _titleLabel.font = [UIFont systemFontOfSize:18];

       }else if (IS_IPHONE_6){
           
           _titleLabel.font = [UIFont systemFontOfSize:16];
           
       }else{
           _titleLabel.font = [UIFont systemFontOfSize:14];
       }
        
    }
    
    return self;
}

- (void)setData:(YH_MyOperationData *)data {
    
    if ([data.title isEqualToString:@"退出登录"]) {
        
        _iconImageView.image = data.iconImage;
        _titleLabel.text = data.title;
        self.accessoryType = UITableViewCellAccessoryNone;
    }else{
        _iconImageView.image = data.iconImage;
        _titleLabel.text = data.title;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

@end
