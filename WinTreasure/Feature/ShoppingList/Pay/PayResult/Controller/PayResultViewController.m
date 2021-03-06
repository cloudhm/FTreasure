//
//  PayResultViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PayResultViewController.h"
#import "TreasureRecordViewController.h"
#import "PayResultCell.h"
#import "PayResultHeader.h"

@interface PayResultViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *datasource;

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@end

@implementation PayResultViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付结果";
    [self configureTableview];
    [self getData];
}

- (void)configureTableview {
    _tableView.estimatedRowHeight = 96.0;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    PayResultHeader *header = [[PayResultHeader alloc]initWithFrame:({
        CGRect rect = {0,0,kScreenWidth,100};
        rect;
    })];
    @weakify(self);
    header.clickButton = ^(NSInteger index){
        @strongify(self);
        switch (index) {
            case 1:
                NSLog(@"确认支付");
                [self.navigationController popToRootViewControllerAnimated:YES];
                break;
            case 2: {
                NSLog(@"夺宝记录");
                TreasureRecordViewController *vc = [[TreasureRecordViewController alloc]init];
                vc.recordType = TreasureRecordTypePaticipated;
                [self hideBottomBarPush:vc];
            }
                break;
            default:
                break;
        }
    };
    _tableView.tableHeaderView = header;
}

- (void)getData {
    PayResultModel *model = [[PayResultModel alloc]init];
    [self.datasource addObject:model];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayResultCell *cell = [PayResultCell cellWithTableView:tableView];
    cell.model = _datasource[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
