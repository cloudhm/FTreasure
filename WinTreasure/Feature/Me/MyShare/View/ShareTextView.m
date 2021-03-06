//
//  ShareTextView.m
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ShareTextView.h"

@interface ShareTextView ()

@property (nonatomic, strong) IQTextView *textView;

@end

@implementation ShareTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIColor *lineColor = UIColorHex(0xe5e5e5);
        CAShapeLayer *topLine = [CAShapeLayer layer];
        topLine.frame = ({
            CGRect rect = {0,0,kScreenWidth,CGFloatFromPixel(1.0)};
            rect;
        });
        topLine.backgroundColor = lineColor.CGColor;
        [self.layer addSublayer:topLine];
        
        CAShapeLayer *bottomLine = [CAShapeLayer layer];
        bottomLine.frame = ({
            CGRect rect = {0,self.height-CGFloatFromPixel(1.0),kScreenWidth,CGFloatFromPixel(1.0)};
            rect;
        });
        bottomLine.backgroundColor = lineColor.CGColor;
        [self.layer addSublayer:bottomLine];

        _textView = [[IQTextView alloc]initWithFrame:({
            CGRect rect = {5,0,kScreenWidth-5*2,self.height};
            rect;
        })];
        _textView.placeholder = @"请输入内容，5~500个字";
        [self addSubview:_textView];
    }
    return self;
}

@end
