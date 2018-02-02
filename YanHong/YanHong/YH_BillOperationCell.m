//
//  YH_BillOperationCell.m
//  YanHong
//
//  Created by anbaoxing on 16/2/27.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_BillOperationCell.h"

@interface YH_BillOperationCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailsLabel;

@end

@implementation YH_BillOperationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图标
        _iconImageView = [[UIImageView alloc] init];
        [self addSubview:_iconImageView];
        
        //标题
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        //详情
        _detailsLabel = [[UILabel alloc] init];
        [self addSubview:_detailsLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setData:(YH_BillOperationData *)data {
        
    if ([data.title isEqualToString:@"交易成功"]) {
        
        _iconImageView.image = data.iconImage;
        
        _titleLabel.frame = CGRectMake(20, 20, 100, 20);
        _titleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        _titleLabel.text = data.title;
        
        _detailsLabel.frame = CGRectMake(20, 40, 200, 60);
//        _detailsLabel.textColor = [UIColor redColor];
        _detailsLabel.font = [UIFont boldSystemFontOfSize:36];
        _detailsLabel.text = data.details;
        
        if (IS_IPHONE_4_OR_LESS) {
            _titleLabel.frame = CGRectMake(20, 10, 100, 10);
            _titleLabel.font = [UIFont systemFontOfSize:15];
        
            _detailsLabel.frame = CGRectMake(20, 20, 200, 50);
            _detailsLabel.font = [UIFont boldSystemFontOfSize:30];
        }else if (IS_IPHONE_5) {
            _titleLabel.frame = CGRectMake(20, 10, 100, 10);
            _titleLabel.font = [UIFont systemFontOfSize:16];
            
            _detailsLabel.frame = CGRectMake(20, 20, 200, 60);
            _detailsLabel.font = [UIFont boldSystemFontOfSize:34];
        }
    }else if (data.title == nil) {
        
        _iconImageView.frame = CGRectMake(33, 17, 46, 46);
        _iconImageView.layer.cornerRadius = 23;
        _iconImageView.backgroundColor = [UIColor lightGrayColor];
        
        _titleLabel.frame = CGRectMake(20, 20, 100, 20);
        _titleLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _titleLabel.text = data.title;
        
        _detailsLabel.frame = CGRectMake(100, 30, 200, 20);
        _detailsLabel.textColor = [UIColor grayColor];
        _detailsLabel.text = data.details;
        
        if (IS_IPHONE_4_OR_LESS) {
            
            _iconImageView.frame = CGRectMake(20, 8, 34, 34);
            _iconImageView.layer.cornerRadius = 17;
            
            _detailsLabel.frame = CGRectMake(65, 15, 200, 20);
            _detailsLabel.font = [UIFont systemFontOfSize:14];
        }else if (IS_IPHONE_5) {
            _iconImageView.frame = CGRectMake(20, 9, 38, 38);
            _iconImageView.layer.cornerRadius = 19;
            
            _detailsLabel.frame = CGRectMake(70, 18, 200, 20);
            _detailsLabel.font = [UIFont systemFontOfSize:15];
        }
    }else if ([data.title isEqualToString:@"说明"] ||
              [data.title isEqualToString:@"时间"] ||
              [data.title isEqualToString:@"订单号"]) {
        
        _iconImageView.image = data.iconImage;
        
        _titleLabel.frame = CGRectMake(0, 0, 70, self.frame.size.height);
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.text = data.title;
        
        _detailsLabel.frame = CGRectMake(90, 0, 200, self.frame.size.height);
        _detailsLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        _detailsLabel.text = data.details;
        
        if (IS_IPHONE_4_OR_LESS) {
            _titleLabel.frame = CGRectMake(0, 0, 50, self.frame.size.height);
            _titleLabel.font = [UIFont systemFontOfSize:13];
            
            _detailsLabel.frame = CGRectMake(65, 0, 200, self.frame.size.height);
            _detailsLabel.font = [UIFont systemFontOfSize:13];
        }else if (IS_IPHONE_5) {
            _titleLabel.frame = CGRectMake(0, 0, 60, self.frame.size.height);
            _titleLabel.font = [UIFont systemFontOfSize:14];
            
            _detailsLabel.frame = CGRectMake(80, 0, 200, self.frame.size.height);
            _detailsLabel.font = [UIFont systemFontOfSize:14];
        }
    }
}

@end
