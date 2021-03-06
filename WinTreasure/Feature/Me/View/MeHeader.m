//
//  MeHeader.m
//  WinTreasure
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "MeHeader.h"

CGFloat bgImageViewY = -20.0;
CGFloat bgImageViewHeight = 150.0;
CGFloat headImageViewWidth = 90.0;
CGFloat headImageViewLeftMargin = 15.0;
CGFloat headImageViewRightMargin = 15.0;
CGFloat balanceViewHeight = 44.0;
CGFloat menuViewHeight = 90.0;

@interface MeHeader ()



/**头像
 */
@property (nonatomic, strong) UIImageView *headImageView;

/**宝石图片
 */
@property (nonatomic, strong) UIImageView *diamondImgView;

/**昵称
 */
@property (nonatomic, strong) YYLabel *nameLabel;

/**宝石
 */
@property (nonatomic, strong) UIButton *diamondButton;

/**记录
 */
@property (nonatomic, strong) RecordMenuView *menuView;

/**资产
 */
@property (nonatomic, strong) BalanceView *balanceView;

/**宝石数量
 */
@property (nonatomic, copy) NSNumber *diamondCount;

@end


@implementation MeHeader

- (void)setDiamondCount:(NSNumber *)diamondCount {
    _diamondCount = diamondCount;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorHex(@"EAE5E1");
        [self _init];
    }
    return self;
}

- (void)_init {
    @weakify(self);

    _bgImageView = [UIImageView new];
    _bgImageView.origin = CGPointMake(0, bgImageViewY);
    _bgImageView.size = CGSizeMake(kScreenWidth, bgImageViewHeight);
    _bgImageView.image = [UIImage imageNamed:@"personal_background"];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.clipsToBounds = YES;
    [self addSubview:_bgImageView];
    
    _headImageView = [UIImageView new];
    _headImageView.origin = CGPointMake(headImageViewLeftMargin, _bgImageView.bottom-headImageViewWidth*0.8);
    _headImageView.size = CGSizeMake(headImageViewWidth, headImageViewWidth);
    _headImageView.layer.cornerRadius = _headImageView.width/2.0;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.shouldRasterize = YES;
    _headImageView.layer.rasterizationScale = kScreenScale;
    _headImageView.userInteractionEnabled = YES;
    _headImageView.image = [UIImage imageNamed:@"curry"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        if (self.headImgBlock) {
            self.headImgBlock();
        }
    }];
    [_headImageView addGestureRecognizer:tap];
    
    
    _nameLabel = [YYLabel new];
    _nameLabel.text = @"王大锤";
    _nameLabel.origin = CGPointMake(_headImageView.right+headImageViewRightMargin, _headImageView.top+10);
    _nameLabel.size = CGSizeMake(kScreenWidth-_headImageView.right-20*2, 17);
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = SYSTEM_FONT(18);
    [self addSubview:_nameLabel];
    
    _diamondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _diamondButton.origin = CGPointMake(_nameLabel.left, _nameLabel.bottom+5);
    _diamondButton.size = CGSizeMake(_nameLabel.width, 13);
    _diamondButton.titleLabel.font = SYSTEM_FONT(11);
    _diamondButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _diamondButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 20);
    _diamondButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _diamondButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_diamondButton setImage:IMAGE_NAMED(@"personal_baoshi_35x35_") forState:UIControlStateNormal];
    [_diamondButton setTitle:@"宝石:10" forState:UIControlStateNormal];
    [_diamondButton addTarget:self action:@selector(checkMyDiamond) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_diamondButton];
    
    _balanceView = [[BalanceView alloc] initWithFrame:({
        CGRect rect = {
            0,
            _headImageView.bottom-headImageViewWidth*0.2,
            kScreenWidth,
            balanceViewHeight};
        rect;
    })];
    _balanceView.balanceAmount = @0;
    _balanceView.topupBlock = ^(){
        @strongify(self);
        if (self.topupBlock) {
            self.topupBlock();
        }
    };
    
    [self addSubview:_balanceView];
    [self addSubview:_headImageView];

    _menuView = [[RecordMenuView alloc]initWithFrame:({
        CGRect rect = {
            0,
            _balanceView.bottom+8,
            kScreenWidth,
            menuViewHeight};
        rect;
    })];
    
    _menuView.clickMenu = ^(NSInteger index){
        @strongify(self);
        if (self.menuBlock) {
            self.menuBlock(index);
        }
    };

    
    [self addSubview:_menuView];
}

- (void)checkMyDiamond {
    if (_diamondBlock) {
        _diamondBlock();
    }
}

- (void)makeScaleForScrollView:(UIScrollView *)scrollView {
    CGFloat scale = fabs(scrollView.contentOffset.y/bgImageViewHeight);
    _bgImageView.layer.position = CGPointMake(kScreenWidth/2.0, (scrollView.contentOffset.y+ (bgImageViewY+0.5*bgImageViewHeight)*2)/2);
    _bgImageView.transform = CGAffineTransformMakeScale(1+scale, 1+scale);

}

- (void)setRemainSum:(NSNumber *)remainSum {
    _remainSum = remainSum;
    _balanceView.balanceAmount = _remainSum;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.height = _menuView.bottom + 10;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end


#pragma mark - RecordMenuView
@interface RecordMenuView ()

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *images;

@end


@implementation RecordMenuView

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"正在进行",
                    @"已经揭晓",
                    @"多期参与"];
    }
    return _titles;
}

- (NSArray *)images {
    if (!_images) {
        _images = @[@"personal_duobao_ing_35x35_",
                    @"personal_duobao_already_35x35_",
                    @"personal_duobao_more_35x35_"];
    }
    return _images;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupMenuButtons];
    }
    return self;
}

- (void)setupMenuButtons {
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                              NSUInteger idx,
                                              BOOL * _Nonnull stop) {
        VerticalButton *menuBtn = [VerticalButton buttonWithType:UIButtonTypeCustom];
        menuBtn.origin = CGPointMake(idx*kScreenWidth/3.0, 0);
        menuBtn.size = CGSizeMake(kScreenWidth/3.0, self.height);
        menuBtn.titleLabel.font = SYSTEM_FONT(13);
        [menuBtn setImage:IMAGE_NAMED(self.images[idx])
                    title:_titles[idx]
                 forState:UIControlStateNormal];
        menuBtn.tag = idx;
        [menuBtn setTitleColor:UIColorHex(333333) forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:menuBtn];
    }];
}

- (void)clickMenu:(UIButton *)sender {
    if (_clickMenu) {
        _clickMenu(sender.tag);
    }
}

@end

#pragma mark - VerticalButton

@implementation VerticalButton

- (void)setImage:(UIImage *)image
           title:(NSString *)title
        forState:(UIControlState)state {
    [self setImage:image forState:state];
    [self setTitle:title forState:state];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //调整图片(imageView)的位置和尺寸
    CGPoint center = self.imageView.center;
    center.x = self.width/2;
    center.y = self.imageView.height/2+15;
    self.imageView.center = center;
    
    //调整文字(titleLable)的位置和尺寸
    CGRect newFrame = self.titleLabel.frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.height;
    
    newFrame.size.width = self.width;
    newFrame.size.height = self.height - self.imageView.height;
    
    self.titleLabel.frame = newFrame;
    
    //让文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end

@interface BalanceView ()

/**充值
 */
@property (nonatomic, strong) UIButton *topupButton;

@end


CGFloat balanceLabelHeight = 14.0;
CGFloat topupButtonHeight = 25.0;

@implementation BalanceView

- (void)setBalanceAmount:(NSNumber *)balanceAmount {
    _balanceAmount = balanceAmount;
    NSString *aString = [NSString stringWithFormat:@"余额：%@元",_balanceAmount];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:aString];
    [attString addAttributes:@{NSForegroundColorAttributeName:UIColorHex(999999),NSFontAttributeName:SYSTEM_FONT(13)} range:NSMakeRange(0, 3)];
    [attString addAttributes:@{NSForegroundColorAttributeName:kDefaultColor,NSFontAttributeName:SYSTEM_FONT(13)} range:NSMakeRange(3, _balanceAmount.stringValue.length)];
    [attString addAttributes:@{NSForegroundColorAttributeName:UIColorHex(999999),NSFontAttributeName:SYSTEM_FONT(13)} range:NSMakeRange(attString.length-1, 1)];
    _balanceLabel.attributedText = attString;
    _balanceLabel.size = [attString size];
    _topupButton.left = _balanceLabel.right + 8;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupBalance];
    }
    return self;
}

- (void)setupBalance {
    _balanceLabel = [YYLabel new];
    _balanceLabel.origin = CGPointMake(headImageViewLeftMargin+headImageViewWidth+headImageViewRightMargin, (self.height-balanceLabelHeight)/2.0);
    _balanceLabel.size = CGSizeMake(80, balanceLabelHeight);
    _balanceLabel.font = SYSTEM_FONT(13);
    [self addSubview:_balanceLabel];
    
    _topupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _topupButton.origin = CGPointMake(_balanceLabel.right+8, (self.height-topupButtonHeight)/2.0);
    _topupButton.size = CGSizeMake(60, topupButtonHeight);
    _topupButton.titleLabel.font = SYSTEM_FONT(15);
    _topupButton.backgroundColor = kDefaultColor;
    _topupButton.layer.cornerRadius = 4.0;
    _topupButton.layer.masksToBounds = YES;
    _topupButton.layer.rasterizationScale = kScreenScale;
    [_topupButton setTitle:@"充值" forState:UIControlStateNormal];
    [_topupButton addTarget:self action:@selector(topup) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_topupButton];
}

- (void)topup {
    if (_topupBlock) {
        _topupBlock();
    }
}

@end
