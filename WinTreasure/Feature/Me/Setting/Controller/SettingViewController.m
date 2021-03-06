//
//  SettingViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "SettingViewController.h"
#import "QuestionViewController.h"
#import "NoticeSetViewController.h"
#import "SettingCell.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) CGFloat fileSize;

@property (strong, nonatomic) NSArray *titles;

@end

@implementation SettingViewController

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@[@"揭晓通知设置"],@[@"常见问题",@"版本信息"],@[@"清楚缓存"],@[@"退出帐号"]];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getCacheImage];
}

- (void)getCacheImage {
    _fileSize = round([YYImageCache sharedCache].diskCache.totalCost/(1024.0*1024.0)*100)/100;
    [_tableView reloadData];
}

#pragma mark - datasouce delegate 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = _titles[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    NSArray *rows = _titles[indexPath.section];
    cell.textLabel.text = rows[indexPath.row];
    cell.indexpath = indexPath;
    if (indexPath.section==2) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f M", _fileSize];
    }
    @weakify(self);
    cell.logout = ^{
        @strongify(self);
        NSLog(@"退出");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kTreasureIsLogined];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popViewControllerAnimated:YES];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        NoticeSetViewController *vc = [[NoticeSetViewController alloc]init];
        [self hideBottomBarPush:vc];
    } else if (indexPath.section==1&&indexPath.row==0) {
        QuestionViewController *vc = [[QuestionViewController alloc]init];
        [self hideBottomBarPush:vc];
    } else if (indexPath.section==2) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认删除所有缓存么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                [[YYImageCache sharedCache].diskCache removeAllObjectsWithBlock:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self getCacheImage];
                        [_tableView reloadData];
                    });
                }];
                [[YYImageCache sharedCache].memoryCache removeAllObjects];
                [[YYImageCache sharedCache].diskCache removeAllObjects];
            }
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
