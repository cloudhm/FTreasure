//
//  TSAnimation.h
//  WinTreasure
//
//  Created by Apple on 16/6/7.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@protocol TSAnimationDelegate;

@interface TSAnimation : NSObject

@property (nonatomic, strong) UIView *showingView;

@property (nonatomic, assign) BOOL isShowing;

@property (nonatomic, weak) id<TSAnimationDelegate>delegate;

+ (TSAnimation *)sharedAnimation;

- (void)throwTheView:(UIView *)view
                path:(UIBezierPath *)path
          isRotated:(BOOL)isRotated
            endScale:(CGFloat)endScale;

@end


@protocol TSAnimationDelegate <NSObject>

@optional
- (void)animationFinished;

@end
