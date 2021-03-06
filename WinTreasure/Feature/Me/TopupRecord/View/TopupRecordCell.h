//
//  TopupCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/17.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopupRecordModel.h"

@interface TopupRecordCell : UITableViewCell

@property (nonatomic, strong) TopupRecordModel *model;

@property (weak, nonatomic) IBOutlet UILabel *topupWayLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *ifTopupLabel;

@property (weak, nonatomic) IBOutlet UILabel *amoutLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
