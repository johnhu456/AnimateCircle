//
//  AnimatedCircleShapeLayer.h
//  AnimatedCircle
//
//  Created by MADAO on 15/11/5.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface AnimatedCircleShapeLayer : CAShapeLayer
/**快速生成ShapeLayer*/
+ (instancetype)layerWithPath:(UIBezierPath *)path
               andStrokeColor:(UIColor *)color
                 andLineWidth:(CGFloat )lineWidth;
@end
