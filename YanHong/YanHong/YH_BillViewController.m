//
//  YH_BillViewController.m
//  YanHong
//
//  Created by anbaoxing on 16/2/27.
//  Copyright © 2016年 anbaoxing. All rights reserved.
//

#import "YH_BillViewController.h"
#import "YH_BillOperationData.h"
#import "YH_BillOperationCell.h"

@interface YH_BillViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YH_BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"dict=%@",_dict);
    
    self.navigationItem.title = @"账单详情";
    [self buildInterface];
}

- (void)buildInterface {
    self.view.backgroundColor = [UIColor colorWithRed:47/255.0 green:53/255.0 blue:61/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //操作列表
    CGRect tableViewRect = CGRectMake(0, 0, theWidth, theHeight);
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[YH_BillOperationCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    
    //让分割线左对齐
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self inputFirstGroupData];
    [self inputTheSecondGroupData];
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

- (void)inputFirstGroupData {
    
    NSMutableArray *firstGroup = [[NSMutableArray alloc] init];
    
    YH_BillOperationData *data11 = [[YH_BillOperationData alloc] init];
    data11.iconImage = [[UIImage alloc] init];//图标
    
    
    int k=[[_dict objectForKey:@"state"] intValue];
    
    int j=[[_dict objectForKey:@"type"] intValue];
    
    

    if (k==0) {
        
        data11.title = @"交易失败";
        if (j==1) {
            
            data11.details = [[NSString alloc] initWithFormat:@"+%@",[_dict objectForKey:@"price"]];
            
        }else{
            data11.details = [[NSString alloc] initWithFormat:@"-%@",[_dict objectForKey:@"price"]];
        }

        

    }else if (k==1){
        
        data11.title = @"交易成功";
        if (j==1) {
            
            data11.details = [[NSString alloc] initWithFormat:@"+%@",[_dict objectForKey:@"price"]];
            
        }else{
            data11.details = [[NSString alloc] initWithFormat:@"-%@",[_dict objectForKey:@"price"]];
        }

        
    }else if (k==2){

        data11.title = @"正在审核";
        if (j==1) {
            
            data11.details = [[NSString alloc] initWithFormat:@"+%@",[_dict objectForKey:@"price"]];
            
        }else{
            data11.details = [[NSString alloc] initWithFormat:@"-%@",[_dict objectForKey:@"price"]];
        }

        
    }
    
    [firstGroup addObject:data11];
    
    YH_BillOperationData *data12 = [[YH_BillOperationData alloc] init];
    data12.iconImage = [[UIImage alloc] init];      //图标
    data12.title = nil;
    data12.details = [_dict objectForKey:@"detail"];
    [firstGroup addObject:data12];
    
    [self.dataSource addObject:firstGroup];
}

- (void)inputTheSecondGroupData {
    
    NSMutableArray *theSecondGroup = [[NSMutableArray alloc] init];
    
    YH_BillOperationData *data21 = [[YH_BillOperationData alloc] init];
    data21.iconImage = [[UIImage alloc] init];      //图标
    data21.title = @"说明";
    data21.details = [_dict objectForKey:@"detail"];
    [theSecondGroup addObject:data21];
    
    YH_BillOperationData *data22 = [[YH_BillOperationData alloc] init];
    data22.iconImage = [[UIImage alloc] init];      //图标
    data22.title = @"时间";
    data22.details = [_dict objectForKey:@"createtime"];
    [theSecondGroup addObject:data22];
    
    YH_BillOperationData *data23 = [[YH_BillOperationData alloc] init];
    data23.iconImage = [[UIImage alloc] init];      //图标
    data23.title = @"订单号";
    data23.details = [_dict objectForKey:@"zdxqno"];
    [theSecondGroup addObject:data23];
    
    [self.dataSource addObject:theSecondGroup];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _dataSource[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //适配
                    if (IS_IPHONE_4_OR_LESS) {
                        return 70;
                    }else if (IS_IPHONE_5) {
                        return 80;
                    }
                    
                    return 100;
                }
                    break;
                    
                case 1:
                {
                    //适配
                    if (IS_IPHONE_4_OR_LESS) {
                        return 50;
                    }else if (IS_IPHONE_5) {
                        return 56;
                    }
                    
                    return 80;
                }
                    break;
                    
                default:
                {
                    //适配
                    if (IS_IPHONE_4_OR_LESS) {
                        return 38;
                    }else if (IS_IPHONE_5) {
                        return 44;
                    }
                    
                    return 58;
                }
                    break;
            }
        }
            break;
            
        default:
        {
            //适配
            if (IS_IPHONE_4_OR_LESS) {
                return 38;
            }else if (IS_IPHONE_5) {
                return 44;
            }
            
            return 58;
        }
            break;
    }
}

- (YH_BillOperationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YH_BillOperationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *group = _dataSource[indexPath.section];
    YH_BillOperationData *data = group[indexPath.row];
    cell.data = data;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //让分割线左对齐
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
