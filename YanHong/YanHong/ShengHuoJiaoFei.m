//
//  ShengHuoJiaoFei.m
//  YanHong
//
//  Created by anbaoxing on 15/12/29.
//  Copyright © 2015年 anbaoxing. All rights reserved.
//

#import "ShengHuoJiaoFei.h"

@interface ShengHuoJiaoFei () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ShengHuoJiaoFei

static int theFont;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IS_IPHONE_4_OR_LESS) {  // 4S
        
        theFont=14;
        
    }else if (IS_IPHONE_5) {  // 5, 5S
        
        theFont=16;
        
    }else if (IS_IPHONE_6) {  // 6
    
        theFont=18;
        
    }else if (IS_IPHONE_6P){
  
        theFont=18;
    }

    //隐藏导航栏
   // [self.navigationController.navigationBar setHidden:YES];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    CGRect collectionViewRect = CGRectMake(0, 0, theWidth, theHeight - 64);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewRect collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
    UILabel *reminderLabel = [[UILabel alloc] init];
    reminderLabel.textColor = [UIColor lightGrayColor];
    reminderLabel.font = [UIFont systemFontOfSize:13];
    reminderLabel.text = @"灰色项目暂不支持，我们将尽快开通";
    [reminderLabel sizeToFit];
    CGFloat labelCenterX = theWidth / 2;
    CGFloat labelCenterY = theWidth * 2 / 3 + reminderLabel.frame.size.height;
    reminderLabel.center = CGPointMake(labelCenterX, labelCenterY);
    [self.collectionView addSubview:reminderLabel];
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(theWidth / 3 - 1, theWidth / 3 - 1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    switch (indexPath.row) {
        case 0:
        {
            //图标
            UIImageView *iconImageView = [[UIImageView alloc] init];
            iconImageView.frame = CGRectMake(0, 0, 30, 30);
            iconImageView.image = [UIImage imageNamed:@"phone_fee1"];
            iconImageView.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height / 3);
            [cell addSubview:iconImageView];
            
            //标题
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
            titleLabel.text = @"手机费";
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height * 2 / 3);
            [cell addSubview:titleLabel];
        }
            break;
            
        case 1:
        {
            //图标
            UIImageView *iconImageView = [[UIImageView alloc] init];
            iconImageView.frame = CGRectMake(0, 0, 30, 30);
            iconImageView.image = [UIImage imageNamed:@"water_rate"];
            iconImageView.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height / 3);
            [cell addSubview:iconImageView];
            
            //标题
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
            titleLabel.text = @"水费";
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height * 2 / 3);
            [cell addSubview:titleLabel];
        }
            break;
            
        case 2:
        {
            //图标
            UIImageView *iconImageView = [[UIImageView alloc] init];
            iconImageView.frame = CGRectMake(0, 0, 30, 30);
            iconImageView.image = [UIImage imageNamed:@"electric_charge"];
            iconImageView.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height / 3);
            [cell addSubview:iconImageView];
            
            //标题
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
            titleLabel.text = @"电费";
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height * 2 / 3);
            [cell addSubview:titleLabel];
        }
            break;
            
        case 3:
        {
            //图标
            UIImageView *iconImageView = [[UIImageView alloc] init];
            iconImageView.frame = CGRectMake(0, 0, 30, 30);
            iconImageView.image = [UIImage imageNamed:@"gas_charge"];
            iconImageView.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height / 3);
            [cell addSubview:iconImageView];
            
            //标题
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
            titleLabel.text = @"燃气费";
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height * 2 / 3);
            [cell addSubview:titleLabel];
        }
            break;
            
        case 4:
        {
            //图标
            UIImageView *iconImageView = [[UIImageView alloc] init];
            iconImageView.frame = CGRectMake(0, 0, 30, 30);
            iconImageView.image = [UIImage imageNamed:@"property_fee"];
            iconImageView.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height / 3);
            [cell addSubview:iconImageView];
            
            //标题
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1.0];
            titleLabel.text = @"物业费";
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height * 2 / 3);
            [cell addSubview:titleLabel];
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            HuaFeiChongZhi *topUpVC = [[HuaFeiChongZhi alloc] init];
            [self.navigationController pushViewController:topUpVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
