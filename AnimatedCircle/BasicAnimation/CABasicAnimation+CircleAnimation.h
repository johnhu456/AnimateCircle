//
//  CABasicAnimation+CircleAnimation.h
//  AnimatedCircle
//
//  Created by MADAO on 15/11/12.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CABasicAnimation (CircleAnimation)
/**快速生成BasciAnimation*/
+ (instancetype)animationWithKeyPath:(NSString *)path
                            duration:(CGFloat)duration
                           fromValue:(NSValue *)fromValue
                             toValue:(NSValue *)toValue;
@end
