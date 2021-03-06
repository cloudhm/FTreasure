//
//  ShareListLayout.h
//  WinTreasure
//
//  Created by Apple on 16/6/23.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingListModel.h"

#define kTextDefaultMargin 12.0 //产品名与参与人次间距
#define kProductImageDefaultHeight 80.0
#define kProductImageDefaultMargin 15.0 //图片上间距
#define kProductImagePadding 12.0 //图片右间距
#define kCountViewDefaultHeight 36.0 //人次选择视图高度
#define kCountViewDefaultWidth (80.0+36*2) //人次选择视图宽度
#define kProductNameWidth kScreenWidth-kProductImagePadding*3-kProductImageDefaultHeight //产品名宽度

@interface ShoppingListLayout : NSObject

@property (nonatomic, assign) CGFloat marginTop; //顶部灰色留白

@property (nonatomic, assign) CGFloat marginBottom; //下边留白

@property (nonatomic, assign) CGFloat nameHeight; //产品名高度

@property (nonatomic, strong) YYTextLayout *nameLayout;

@property (nonatomic, strong) YYTextLayout *paticipateLayout;

@property (nonatomic, assign) CGFloat partInAmountHeight; //参与人次高度

@property (nonatomic, assign) CGFloat imageHeight; //图片高度

@property (nonatomic, assign) CGFloat counViewtHeight; //人次选择视图高度

// 总高度
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) ShoppingListModel *model;

- (instancetype)initWithModel:(ShoppingListModel *)model;

@end
