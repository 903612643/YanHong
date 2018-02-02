//
//  HouseDetailViewCell.m
//  YanHong
//
//  Created by anbaoxing on 16/3/23.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "HouseDetailViewCell.h"
#import "HouseDetailViewController.h"

@interface HouseDetailViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong) HouseDetailViewController *houseDetailVC;

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *fenxBtn;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *imageCountLabel;
@property (nonatomic, strong) NSTimer *scrollTimer;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UILabel *ownerLabel;
@property (nonatomic, strong) UIImageView *directionView;

@property (nonatomic, strong) UILabel *averageLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *trendImageView;
@property (nonatomic, strong) UILabel *awardLabel;
@property (nonatomic, strong) UIImageView *jangImageView;

@property (nonatomic, strong) UIView *describeView;

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIButton *functionBtn1;
@property (nonatomic, strong) UIButton *functionBtn2;
@property (nonatomic, strong) UIButton *functionBtn3;
@property (nonatomic, strong) UIButton *functionBtn4;

@property (nonatomic, strong) UILabel *moreLabel;

@end

@implementation HouseDetailViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //获取热门楼盘详情界面
        UIView *view = self.superview;
        UITableView *tableView = (UITableView *)view.superview;
        _houseDetailVC = (HouseDetailViewController *)tableView.delegate;
        
        //图片滑动界面
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, theWidth, theWidth / 2);
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
//        [tapGesture addTarget:self action:@selector()];
        [_scrollView addGestureRecognizer:tapGesture];
        
        //自动移动图片
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
        [_scrollTimer setFireDate:[NSDate distantFuture]];
        
        //返回按钮
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(14, 4, 36, 36);
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBtn addTarget:_houseDetailVC action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backBtn];
        
        //分享按钮
        _fenxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fenxBtn.frame = CGRectMake(theWidth-46, 8, 25, 25);
        [_fenxBtn setImage:[UIImage imageNamed:@"share2"] forState:UIControlStateNormal];
        [_fenxBtn addTarget:_houseDetailVC action:@selector(shareContent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_fenxBtn];
        
        //图片页码
        _pageControl = [[UIPageControl alloc] init];
        [self addSubview:_pageControl];
        
        //显示图片数量
        _imageCountLabel = [[UILabel alloc] init];
        _imageCountLabel.clipsToBounds = YES;
        _imageCountLabel.layer.cornerRadius = 6;
        _imageCountLabel.backgroundColor = [UIColor blackColor];
        _imageCountLabel.textColor = [UIColor whiteColor];
        _imageCountLabel.textAlignment = NSTextAlignmentCenter;
        _imageCountLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_imageCountLabel];
        
        //楼盘名称
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:21];
        [self addSubview:_nameLabel];
        
        //楼盘状态
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.layer.borderWidth = 1;
        _stateLabel.layer.borderColor = [UIColor colorWithRed:53/255.0 green:163/255.0 blue:46/255.0 alpha:1].CGColor;
        _stateLabel.font = [UIFont systemFontOfSize:13];
        _stateLabel.textColor = [UIColor colorWithRed:53/255.0 green:163/255.0 blue:46/255.0 alpha:1];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_stateLabel];
        
        //播放按钮
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_playBtn];
        
        //业主圈
        _ownerLabel = [[UILabel alloc] init];
        _ownerLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_ownerLabel];
        
        //向右箭头
        _directionView = [[UIImageView alloc] init];
        [self addSubview:_directionView];
        
        //均价
        _averageLabel = [[UILabel alloc] init];
        _averageLabel.font = [UIFont systemFontOfSize:18];
        _averageLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_averageLabel];
        
        //价格
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:18];
        _priceLabel.textColor = [UIColor redColor];
        [self addSubview:_priceLabel];
        
        //价格图标
        _trendImageView = [[UIImageView alloc] init];
        [self addSubview:_trendImageView];
        
        //奖励内容
        _awardLabel = [[UILabel alloc] init];
        _awardLabel.font = [UIFont systemFontOfSize:15];
        _awardLabel.textColor = [UIColor redColor];
        [self addSubview:_awardLabel];
        
        //奖励图标
        _jangImageView = [[UIImageView alloc] init];
        [self addSubview:_jangImageView];
        
        //楼盘描述
        _describeView = [[UIView alloc] init];
        [self addSubview:_describeView];
        
        //详情图标
        _iconView = [[UIImageView alloc] init];
        [self addSubview:_iconView];
        
        //详情
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_detailLabel];
        
        //功能按钮
        _functionBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_functionBtn1 addTarget:_houseDetailVC action:@selector(showLinkContent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_functionBtn1];
        
        _functionBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_functionBtn2 addTarget:_houseDetailVC action:@selector(showLinkContent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_functionBtn2];
        
        _functionBtn3 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_functionBtn3 addTarget:_houseDetailVC action:@selector(showLinkContent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_functionBtn3];
        
        _functionBtn4 = [UIButton buttonWithType:UIButtonTypeSystem];
        [_functionBtn4 addTarget:_houseDetailVC action:@selector(showLinkContent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_functionBtn4];
        
        //更多
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.font = [UIFont systemFontOfSize:16];
        _moreLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_moreLabel];
        
        if (IS_IPHONE_5) {
            _nameLabel.font = [UIFont systemFontOfSize:18];
            _stateLabel.font = [UIFont systemFontOfSize:12];
            _ownerLabel.font = [UIFont systemFontOfSize:15];
            _averageLabel.font = [UIFont systemFontOfSize:13];
            _priceLabel.font = [UIFont systemFontOfSize:13];
            _awardLabel.font = [UIFont systemFontOfSize:13];
            _detailLabel.font = [UIFont systemFontOfSize:14];
        }else if (IS_IPHONE_4_OR_LESS) {
            _nameLabel.font = [UIFont systemFontOfSize:18];
            _stateLabel.font = [UIFont systemFontOfSize:12];
            _ownerLabel.font = [UIFont systemFontOfSize:15];
            _averageLabel.font = [UIFont systemFontOfSize:13];
            _priceLabel.font = [UIFont systemFontOfSize:13];
            _awardLabel.font = [UIFont systemFontOfSize:13];
            _detailLabel.font = [UIFont systemFontOfSize:14];
        }
        
        //点击样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //清空数据
        [self clearContent];
    }
    return self;
}

- (void)setData:(NSArray *)data byIndexPath:(NSIndexPath *)indexPath {
    
    [self clearContent];
    
    NSDictionary *dict;
    if (indexPath.section != 0 ||
        (indexPath.section == 0 && indexPath.row != 0)) {
        dict = [data firstObject];
    }
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    switch (indexPath.section) {
        case 0: //第一组
        {
            switch (indexPath.row) {
                case 0:
                {
                    _scrollView.hidden = NO;
                    _backBtn.hidden = NO;
                    _pageControl.hidden = NO;
                    _imageCountLabel.hidden = NO;
                    
                    //添加图片
                    NSMutableArray *imageData = [[NSMutableArray alloc] init];
                    [imageData addObject:[data lastObject]];
                    [imageData addObjectsFromArray:data];
                    [imageData addObject:[data firstObject]];
                    
                    //图片浏览
                    if (_scrollView.subviews.count != imageData.count) {
                        for (int i = 0; i < imageData.count; i++) {
                            UIImageView *imageView = [[UIImageView alloc] init];
                            imageView.frame = CGRectMake(width * i, 0, width, height);
                            imageView.backgroundColor = [UIColor blueColor];
                            imageView.tag = i + 60;
                            [_scrollView addSubview:imageView];
                            
                            NSDictionary *dict = imageData[i];
                            if ([dict[@"pic"] isKindOfClass:[UIImage class]]) {
                                imageView.image = dict[@"pic"];
                            }else{
                                imageView.image = [UIImage imageNamed:@"NoPic.jpg"];
                            }
                        }
                    }
                    
                    _scrollView.pagingEnabled = YES;
                    _scrollView.contentSize =CGSizeMake(width * imageData.count, height);
                    _scrollView.contentOffset = CGPointMake(width, 0);
                    
                    //图片页码
                    _pageControl.numberOfPages = data.count;
                    _pageControl.frame = CGRectMake(0, height - 30, width, 20);
                    _pageControl.currentPage = 0;
                    
                    //自动移动图片
                    [_scrollTimer setFireDate:[NSDate distantPast]];
                    
                    //图片数量
                    _imageCountLabel.text = [NSString stringWithFormat:@"共%zi张",data.count];
                    [_imageCountLabel sizeToFit];
                    CGFloat imageWidth = _imageCountLabel.frame.size.width + 10;
                    CGFloat imageHeight = _imageCountLabel.frame.size.height + 10;
                    _imageCountLabel.frame = CGRectMake(width - 10 - imageWidth, height - 10 - imageHeight, imageWidth, imageHeight);
                }
                    break;
                    
                case 1:
                {
                    _nameLabel.hidden = NO;
                    _stateLabel.hidden = NO;
                    _playBtn.hidden = NO;
                    _ownerLabel.hidden = NO;
                    _directionView.hidden = NO;
                    
                    //楼盘名称
                    _nameLabel.text = dict[@"projectName"];
                    [_nameLabel sizeToFit];
                    CGFloat nameWidth = _nameLabel.frame.size.width;
                    _nameLabel.frame = CGRectMake(10, 0, nameWidth, height);
                    
                    //楼盘状态
                    _stateLabel.text = @"在售";
                    [_stateLabel sizeToFit];
                    CGFloat stateWidth = _stateLabel.frame.size.width + 6;
                    CGFloat stateHeight = _stateLabel.frame.size.height + 2;
                    CGFloat stateOriginX = _nameLabel.frame.origin.x + nameWidth + 10;
                    CGFloat stateOriginY = (height - stateHeight) / 2;
                    _stateLabel.frame = CGRectMake(stateOriginX, stateOriginY, stateWidth, stateHeight);
                    
                    //播放按钮
                    CGFloat playOriginX = _stateLabel.frame.origin.x + stateWidth + 10;
                    CGFloat playWidth = height - 24;
                    _playBtn.frame = CGRectMake(playOriginX, 12, playWidth, playWidth);
                    [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                    
                    //业主圈
                    _ownerLabel.text = @"业主圈";
                    [_ownerLabel sizeToFit];
                    CGFloat ownerWidth = _ownerLabel.frame.size.width;
                    CGFloat ownerOriginX = width - ownerWidth - 30;
                    _ownerLabel.frame = CGRectMake(ownerOriginX, 0, ownerWidth, height);
                    
                    //向右箭头
                    CGFloat directionHeight = height - 30;
                    CGFloat directionWidth = directionHeight * 26 / 50;
                    CGFloat directionOriginX = ownerOriginX + ownerWidth + 3;
                    _directionView.frame = CGRectMake(directionOriginX, 15, directionWidth, directionHeight);
                    _directionView.image = [UIImage imageNamed:@"4"];
                }
                    break;
                    
                case 2:
                {
                    _averageLabel.hidden = NO;
                    _priceLabel.hidden = NO;
                    _trendImageView.hidden = NO;
                    _awardLabel.hidden = NO;
                    _jangImageView.hidden = NO;
                    
                     //均价
                    _averageLabel.text = @"均价: ";
                    [_averageLabel sizeToFit];
                    CGFloat averageWidth = _averageLabel.frame.size.width;
                    _averageLabel.frame = CGRectMake(10, 0, averageWidth, height);
                    
                    //价格
                    _priceLabel.text = [NSString stringWithFormat:@"%@元/㎡",dict[@"avePrice"]];
                    [_priceLabel sizeToFit];
                    CGFloat priceWidth = _priceLabel.frame.size.width;
                    CGFloat priceOriginX = _averageLabel.frame.origin.x + averageWidth;
                    _priceLabel.frame = CGRectMake(priceOriginX, 0, priceWidth, height);
                    
                    //价格图标
                    CGFloat trendOriginX = _priceLabel.frame.origin.x + priceWidth + 5;
                    CGFloat trendWidth = height - 26;
                    _trendImageView.frame = CGRectMake(trendOriginX, 13, trendWidth, trendWidth);
                    _trendImageView.image = [UIImage imageNamed:@"trend"];
                    
                    //奖励内容
                    _awardLabel.text = @"推荐客户赚1%佣金";
                    [_awardLabel sizeToFit];
                    CGFloat awardWidth = _awardLabel.frame.size.width;
                    CGFloat awardOriginX = width - awardWidth - 10;
                    _awardLabel.frame = CGRectMake(awardOriginX, 0, awardWidth, height);
                    
                    //奖励图标
                    CGFloat jangWidth = height - 20;
                    CGFloat jangOriginX = awardOriginX - jangWidth - 5;
                    _jangImageView.frame = CGRectMake(jangOriginX, 10, jangWidth, jangWidth);
                    _jangImageView.image = [UIImage imageNamed:@"jang"];
                    
                }
                    break;
                    
                case 3:
                {
                    _describeView.hidden = NO;
                    
                    //楼盘描述
                    
                    if (_describeView.subviews.count != 5) {
                        {
                            CGFloat originX = 10;
                            
                            for (int i = 0; i < 5; i++) {
                                NSString *keyStr = [NSString stringWithFormat:@"test%d",i];
                                NSString *text = dict[keyStr];
                                if (text.length != 0) {
                                    UILabel *testLabel = [[UILabel alloc] init];
                                    testLabel.layer.cornerRadius = 4;
                                    testLabel.clipsToBounds = YES;
                                    testLabel.backgroundColor = [UIColor colorWithRed:245/255.0 green:230/255.0 blue:226/255.0 alpha:1.0];
                                    if (IS_IPHONE_4_OR_LESS) {
                                        testLabel.font = [UIFont systemFontOfSize:13];
                                    }else if (IS_IPHONE_5) {
                                        testLabel.font = [UIFont systemFontOfSize:14];
                                    }else if (IS_IPHONE_6) {
                                        testLabel.font = [UIFont systemFontOfSize:15];
                                    }else if (IS_IPHONE_6P) {
                                        testLabel.font = [UIFont systemFontOfSize:15];
                                    }
                                    testLabel.textAlignment = NSTextAlignmentCenter;
                                    testLabel.textColor = [UIColor colorWithRed:215/255.0 green:116/255.0 blue:90/255.0 alpha:1.0];
                                    testLabel.text = text;
                                    [testLabel sizeToFit];
                                    testLabel.frame = CGRectMake(originX, (height - 20) / 2, testLabel.frame.size.width + 5, 20);
                                    [_describeView addSubview:testLabel];
                                    originX += (testLabel.frame.size.width + 10);
                                }
                            }
                        }
                    }
                    
//                    NSMutableString *describleStr = [[NSMutableString alloc] init];
//                    [describleStr appendFormat:@"%@",dict[@"test0"]];
//                    [describleStr appendFormat:@" %@",dict[@"test1"]];
//                    [describleStr appendFormat:@" %@",dict[@"test2"]];
//                    [describleStr appendFormat:@" %@",dict[@"test3"]];
//                    [describleStr appendFormat:@" %@",dict[@"test4"]];
//                    _describeLabel.text = describleStr;
//                    [_describeLabel sizeToFit];
//                    CGFloat describleWidth = _describeLabel.frame.size.width;
//                    _describeLabel.frame = CGRectMake(10, 0, describleWidth, height);
                }
                    break;
                    
                case 4:
                {
                    _iconView.hidden = NO;
                    _detailLabel.hidden = NO;
                    
                    //详情图标
                    CGFloat iconWidth = height - 24;
                    _iconView.frame = CGRectMake(10, 12, iconWidth, iconWidth);
                    _iconView.image = [UIImage imageNamed:@"tip"];
                    
                    //详情
                    CGFloat detailOriginX = _iconView.frame.size.width + 15;
                    _detailLabel.frame = CGRectMake(detailOriginX, 0, width - detailOriginX, height);
                    _detailLabel.text = [NSString stringWithFormat:@"有%@位意向客户, %@人已关注",dict[@"clientNum"], dict[@"attentionNum"]];
                }
                    break;
                    
                case 5:
                {
                    _iconView.hidden = NO;
                    _detailLabel.hidden = NO;
                    
                    //详情图标
                    CGFloat iconWidth = height - 24;
                    CGFloat iconHeight = iconWidth * 120 / 88;
                    CGFloat iconOriginY = (height - iconHeight) / 2;
                    _iconView.frame = CGRectMake(10, iconOriginY, iconWidth, iconHeight);
                    _iconView.image = [UIImage imageNamed:@"position"];
                    
                    //详情
                    CGFloat detailOriginX = _iconView.frame.size.width + 15;
                    _detailLabel.frame = CGRectMake(detailOriginX, 0, width - detailOriginX, height);
                    _detailLabel.text = dict[@"address"];
                    
                    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                    break;
                    
                case 6:
                {
                    _iconView.hidden = NO;
                    _detailLabel.hidden = NO;
                    
                    //详情图标
                    CGFloat iconWidth = height - 24;
                    _iconView.frame = CGRectMake(10, 12, iconWidth, iconWidth);
                    _iconView.image = [UIImage imageNamed:@"discount"];
                    
                    //详情
                    CGFloat detailOriginX = _iconView.frame.size.width + 15;
                    _detailLabel.frame = CGRectMake(detailOriginX, 0, width - detailOriginX, height);
                    _detailLabel.text = dict[@"privilege"];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1: //第二组
        {
            _functionBtn1.hidden = NO;
            _functionBtn2.hidden = NO;
            _functionBtn3.hidden = NO;
            _functionBtn4.hidden = NO;
            
            CGFloat btnWidth = width / 4;
            CGFloat imageHorizontal = (btnWidth - 60) / 2;
            
            switch (indexPath.row) {
                case 0:
                {
                    _functionBtn1.frame = CGRectMake(0, 0, btnWidth, height);
                    UIImage *btnImage1 = [[UIImage imageNamed:@"detail2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    [_functionBtn1 setImage:btnImage1 forState:UIControlStateNormal];
                    _functionBtn1.imageEdgeInsets = UIEdgeInsetsMake(10, imageHorizontal, 30, imageHorizontal);
                    _functionBtn1.tintColor = [UIColor blackColor];
                    [_functionBtn1 setTitle:@"项目概况" forState:UIControlStateNormal];
                    _functionBtn1.titleEdgeInsets = UIEdgeInsetsMake(70, -175, 0, 0);
                    
                    _functionBtn2.frame = CGRectMake(btnWidth, 0, btnWidth, height);
                    UIImage *btnImage2 = [[UIImage imageNamed:@"advantage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    [_functionBtn2 setImage:btnImage2 forState:UIControlStateNormal];
                    _functionBtn2.imageEdgeInsets = UIEdgeInsetsMake(10, imageHorizontal, 30, imageHorizontal);
                    _functionBtn2.tintColor = [UIColor blackColor];
                    [_functionBtn2 setTitle:@"项目优势" forState:UIControlStateNormal];
                    _functionBtn2.titleEdgeInsets = UIEdgeInsetsMake(70, -175, 0, 0);
                    
                    _functionBtn3.frame = CGRectMake(btnWidth * 2, 0, btnWidth, height);
                    UIImage *btnImage3 = [[UIImage imageNamed:@"book"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    [_functionBtn3 setImage:btnImage3 forState:UIControlStateNormal];
                    _functionBtn3.imageEdgeInsets = UIEdgeInsetsMake(10, imageHorizontal, 30, imageHorizontal);
                    _functionBtn3.tintColor = [UIColor blackColor];
                    [_functionBtn3 setTitle:@"电子楼书" forState:UIControlStateNormal];
                    _functionBtn3.titleEdgeInsets = UIEdgeInsetsMake(70, -175, 0, 0);
                    
                    _functionBtn4.frame = CGRectMake(btnWidth * 3, 0, btnWidth, height);
                    UIImage *btnImage4 = [[UIImage imageNamed:@"choose"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    [_functionBtn4 setImage:btnImage4 forState:UIControlStateNormal];
                    _functionBtn4.imageEdgeInsets = UIEdgeInsetsMake(10, imageHorizontal, 30, imageHorizontal);
                    _functionBtn4.tintColor = [UIColor blackColor];
                    [_functionBtn4 setTitle:@"我要选房" forState:UIControlStateNormal];
                    _functionBtn4.titleEdgeInsets = UIEdgeInsetsMake(70, -175, 0, 0);
                }
                    break;
                    
                case 1:
                {
                    _functionBtn1.frame = CGRectMake(0, 0, btnWidth, height);
                    UIImage *btnImage1 = [[UIImage imageNamed:@"detail2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    [_functionBtn1 setImage:btnImage1 forState:UIControlStateNormal];
                    _functionBtn1.imageEdgeInsets = UIEdgeInsetsMake(10, imageHorizontal, 30, imageHorizontal);
                    _functionBtn1.tintColor = [UIColor blackColor];
                    [_functionBtn1 setTitle:@"项目动态" forState:UIControlStateNormal];
                    _functionBtn1.titleEdgeInsets = UIEdgeInsetsMake(70, -175, 0, 0);
                    
                    _functionBtn2.frame = CGRectMake(btnWidth, 0, btnWidth, height);
                    UIImage *btnImage2 = [[UIImage imageNamed:@"detail2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    [_functionBtn2 setImage:btnImage2 forState:UIControlStateNormal];
                    _functionBtn2.imageEdgeInsets = UIEdgeInsetsMake(10, imageHorizontal, 30, imageHorizontal);
                    _functionBtn2.tintColor = [UIColor blackColor];
                    [_functionBtn2 setTitle:@"项目动态" forState:UIControlStateNormal];
                    _functionBtn2.titleEdgeInsets = UIEdgeInsetsMake(70, -175, 0, 0);
                    
                    _functionBtn3.frame = CGRectMake(btnWidth * 2, 0, btnWidth, height);
                    UIImage *btnImage3 = [[UIImage imageNamed:@"detail2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    [_functionBtn3 setImage:btnImage3 forState:UIControlStateNormal];
                    _functionBtn3.imageEdgeInsets = UIEdgeInsetsMake(10, imageHorizontal, 30, imageHorizontal);
                    _functionBtn3.tintColor = [UIColor blackColor];
                    [_functionBtn3 setTitle:@"户型图" forState:UIControlStateNormal];
                    _functionBtn3.titleEdgeInsets = UIEdgeInsetsMake(70, -175, 0, 0);
                    
                    _functionBtn4.frame = CGRectMake(btnWidth * 3, 0, btnWidth, height);
                    UIImage *btnImage4 = [[UIImage imageNamed:@"detail2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    [_functionBtn4 setImage:btnImage4 forState:UIControlStateNormal];
                    _functionBtn4.imageEdgeInsets = UIEdgeInsetsMake(10, imageHorizontal, 30, imageHorizontal);
                    _functionBtn4.tintColor = [UIColor blackColor];
                    [_functionBtn4 setTitle:@"置业顾问" forState:UIControlStateNormal];
                    _functionBtn4.titleEdgeInsets = UIEdgeInsetsMake(70, -175, 0, 0);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 2: //第三组
        {
            switch (indexPath.row) {
                case 0:
                {
                    _nameLabel.hidden = NO;
                    _moreLabel.hidden = NO;
                    
                    //楼盘信息
                    _nameLabel.text = @"楼盘信息";
                    [_nameLabel sizeToFit];
                    CGFloat nameWidth = _nameLabel.frame.size.width;
                    _nameLabel.frame = CGRectMake(10, 0, nameWidth, height);
                    
                    //更多
                    _moreLabel.text = @"更多";
                    [_moreLabel sizeToFit];
                    CGFloat moreWidth = _moreLabel.frame.size.width;
                    CGFloat moreOriginX = width - moreWidth - 30;
                    _moreLabel.frame = CGRectMake(moreOriginX, 0, moreWidth, height);
                    
                    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                    break;
                    
                case 1:
                {
                    _averageLabel.hidden = NO;
                    _detailLabel.hidden = NO;
                    
                    _averageLabel.text = @"开盘时间   ";
                    [_averageLabel sizeToFit];
                    CGFloat averageWidth = _averageLabel.frame.size.width;
                    _averageLabel.frame = CGRectMake(10, 0, averageWidth, height);
                    
                    _detailLabel.text = dict[@"kpsj"];
                    [_detailLabel sizeToFit];
                    CGFloat priceWidth = _detailLabel.frame.size.width;
                    CGFloat priceOriginX = _averageLabel.frame.origin.x + averageWidth;
                    _detailLabel.frame = CGRectMake(priceOriginX, 0, priceWidth, height);
                }
                    break;
                    
                case 2:
                {
                    _averageLabel.hidden = NO;
                    _detailLabel.hidden = NO;
                    
                    _averageLabel.text = @"入住时间   ";
                    [_averageLabel sizeToFit];
                    CGFloat averageWidth = _averageLabel.frame.size.width;
                    _averageLabel.frame = CGRectMake(10, 0, averageWidth, height);
                    
                    _detailLabel.text = dict[@"rzsj"];
                    [_detailLabel sizeToFit];
                    CGFloat priceWidth = _detailLabel.frame.size.width;
                    CGFloat priceOriginX = _averageLabel.frame.origin.x + averageWidth;
                    _detailLabel.frame = CGRectMake(priceOriginX, 0, priceWidth, height);
                }
                    break;
                    
                case 3:
                {
                    _averageLabel.hidden = NO;
                    _detailLabel.hidden = NO;
                    
                    _averageLabel.text = @"开  发  商   ";
                    [_averageLabel sizeToFit];
                    CGFloat averageWidth = _averageLabel.frame.size.width;
                    _averageLabel.frame = CGRectMake(10, 0, averageWidth, height);
                    
                    _detailLabel.text = dict[@"kfs"];
                    [_detailLabel sizeToFit];
                    CGFloat priceWidth = _detailLabel.frame.size.width;
                    CGFloat priceOriginX = _averageLabel.frame.origin.x + averageWidth;
                    _detailLabel.frame = CGRectMake(priceOriginX, 0, priceWidth, height);
                }
                    break;
                    
                case 4:
                {
                    _averageLabel.hidden = NO;
                    _detailLabel.hidden = NO;
                    
                    _averageLabel.text = @"年权年限   ";
                    [_averageLabel sizeToFit];
                    CGFloat averageWidth = _averageLabel.frame.size.width;
                    _averageLabel.frame = CGRectMake(10, 0, averageWidth, height);
                    
                    _detailLabel.text = dict[@"cqnx"];
                    [_detailLabel sizeToFit];
                    CGFloat priceWidth = _detailLabel.frame.size.width;
                    CGFloat priceOriginX = _averageLabel.frame.origin.x + averageWidth;
                    _detailLabel.frame = CGRectMake(priceOriginX, 0, priceWidth, height);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 3: //第四组
        {
            switch (indexPath.row) {
                case 0:
                {
                    _nameLabel.hidden = NO;
                    
                    _nameLabel.text = @"位置及周边";
                    [_nameLabel sizeToFit];
                    CGFloat nameWidth = _nameLabel.frame.size.width;
                    _nameLabel.frame = CGRectMake(10, 0, nameWidth, height);
                    
                    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                    break;
                
                case 1:
                {
                    _iconView.hidden = NO;
                    
                    _iconView.frame = CGRectMake(0, 0, width, height);
                    _iconView.image = [UIImage imageNamed:@"houseBgm.jpg"];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)tapScrollView {
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    int pageNum = offset.x / bounds.size.width;
    if (pageNum == 0) {
        [_pageControl setCurrentPage:[_pageControl numberOfPages]];
        [_scrollView setContentOffset:CGPointMake(theWidth * [_pageControl numberOfPages], 0) animated:NO];
    }else if (pageNum == [_pageControl numberOfPages] + 1) {
        [_pageControl setCurrentPage:0];
        [_scrollView setContentOffset:CGPointMake(theWidth, 0) animated:NO];
    }else {
        [_pageControl setCurrentPage:pageNum - 1];
    }
}

- (void)scrollImage {
    CGPoint offset = _scrollView.contentOffset;
    int haveScrollPage = (int)offset.x / (int)theWidth;
    [_scrollView setContentOffset:CGPointMake(theWidth * (haveScrollPage + 1), 0) animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    int pageNum = offset.x / bounds.size.width;
    if (pageNum == 0) {
        [_pageControl setCurrentPage:[_pageControl numberOfPages]];
        [_scrollView setContentOffset:CGPointMake(theWidth * [_pageControl numberOfPages], 0) animated:NO];
    }else if (pageNum == [_pageControl numberOfPages] + 1) {
        [_pageControl setCurrentPage:0];
        [_scrollView setContentOffset:CGPointMake(theWidth, 0) animated:NO];
    }else {
        [_pageControl setCurrentPage:pageNum - 1];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_scrollTimer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.5]];
}

- (void)clearContent {
    _scrollView.hidden = YES;
    _backBtn.hidden = YES;
    _pageControl.hidden = YES;
    _imageCountLabel.hidden = YES;
    
    _nameLabel.hidden = YES;
    _stateLabel.hidden = YES;
    _playBtn.hidden = YES;
    _ownerLabel.hidden = YES;
    _directionView.hidden = YES;
    
    _averageLabel.hidden = YES;
    _priceLabel.hidden = YES;
    _trendImageView.hidden = YES;
    _awardLabel.hidden = YES;
    _jangImageView.hidden = YES;
    
    _describeView.hidden = YES;
    
    _iconView.hidden = YES;
    _detailLabel.hidden = YES;
    
    _functionBtn1.hidden = YES;
    _functionBtn2.hidden = YES;
    _functionBtn3.hidden = YES;
    _functionBtn4.hidden = YES;
    
    _moreLabel.hidden = YES;
    
    self.accessoryType = UITableViewCellAccessoryNone;
}

@end
