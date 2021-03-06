//
//  RecieverInformation.h
//  WinTreasure
//
//  Created by Apple on 16/6/28.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRecieverInformationPadding 30.0
#define kRecieverInformationMargin 20.0

@class AddressModel;

typedef void(^RecieverInformationBlock)(NSString *location);

@interface RecieverInformation : UIView

@property (nonatomic, copy) AddressModel *model;

@property (nonatomic, copy) RecieverInformationBlock locationBlock;

@end
