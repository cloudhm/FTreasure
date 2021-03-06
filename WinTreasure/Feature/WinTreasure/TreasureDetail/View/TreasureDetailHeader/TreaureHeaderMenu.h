//
//  TreaureMenu.h
//  WinTreasure
//
//  Created by Apple on 16/6/13.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMenuButtonHeight 40.0
#define kTreaureHeaderMenuMargin 10.0

typedef void(^MenuViewBlock)(NSInteger index);

@interface MenuView : UIView

@property (nonatomic, strong) YYLabel *titleLabel;

@property (nonatomic, strong) YYLabel *detailLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIButton *eventButton;

@property (nonatomic, copy) MenuViewBlock menuClickBlock;

@end

@interface RecordView : UIView

@property (nonatomic, strong) YYLabel *titleLabel;

@property (nonatomic, strong) YYLabel *detailLabel;

@end

typedef void(^TreaureHeaderMenuBlock)(NSInteger index);
//
@interface TreaureHeaderMenu : UIView

@property (nonatomic, copy) NSArray *data;

@property (nonatomic, copy) TreaureHeaderMenuBlock block;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data;

@end
