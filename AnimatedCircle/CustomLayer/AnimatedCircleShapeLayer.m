//
//  AnimatedCircleShapeLayer.m
//  AnimatedCircle
//
//  Created by MADAO on 15/11/5.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import "AnimatedCircleShapeLayer.h"

@implementation AnimatedCircleShapeLayer
+ (instancetype)layerWithPath:(UIBezierPath *)path
               andStrokeColor:(UIColor *)color
                 andLineWidth:(CGFloat)lineWidth{
    AnimatedCircleShapeLayer *layer = [AnimatedCircleShapeLayer layer];
    layer.path                      = path.CGPath;
    layer.strokeColor               = [color CGColor];
    layer.fillColor                 = [[UIColor clearColor]CGColor];
    layer.lineWidth                 = lineWidth;
    return layer;
}
@end
