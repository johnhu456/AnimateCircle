//
//  CircleHeadView.h
//  AnimatedCircle
//
//  Created by MADAO on 15/11/5.
//  Copyright © 2015年 MADAO. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AnimatedCircleShapeLayer.h"

@interface CircleHeadLayer : AnimatedCircleShapeLayer
@property (nonatomic,strong) AnimatedCircleShapeLayer *headLayer;

/**中心*/
@property (nonatomic,assign) CGPoint center;
+ (instancetype)headWithCGPoint:(CGPoint)center;
@end
