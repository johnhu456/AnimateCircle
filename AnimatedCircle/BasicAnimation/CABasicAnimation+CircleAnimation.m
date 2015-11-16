//
//  CABasicAnimation+CircleAnimation.m
//  AnimatedCircle
//
//  Created by MADAO on 15/11/12.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import "CABasicAnimation+CircleAnimation.h"

@implementation CABasicAnimation (CircleAnimation)
+ (instancetype)animationWithKeyPath:(NSString *)path
                            duration:(CGFloat)duration
                           fromValue:(NSValue *)fromValue
                             toValue:(NSValue *)toValue{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:path];
    animation.duration     = duration;
    animation.fromValue    = fromValue;
    animation.toValue      = toValue;
    animation.autoreverses = NO;
    animation.fillMode     = kCAFillModeForwards;
    animation.repeatCount  = 0.f;
    return animation;
}
@end
