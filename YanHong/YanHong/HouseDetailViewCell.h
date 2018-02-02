//
//  HouseDetailViewCell.h
//  YanHong
//
//  Created by anbaoxing on 16/3/23.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseDetailViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *dict;

@property (nonatomic, strong) UIScrollView *scrollView;

- (void)setData:(NSArray *)data byIndexPath:(NSIndexPath *)indexPath;

@end
