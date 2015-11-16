//
//  AnimatedCircleView.h
//  AnimatedCircle
//
//  Created by MADAO on 15/11/4.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleHeadLayer.h"
@interface AnimatedCircleView : UIView
/**线宽*/
@property (nonatomic,assign) CGFloat circleWidth;
/**根据当前累计收益和预期收益初始化*/
- (instancetype)initWithFrame:(CGRect)frame
                         rate:(CGFloat)rate
                CurrentProfit:(CGFloat)curentProfit
               ExpectedPorfit:(CGFloat)expectedProfit
                   investDays:(CGFloat)investDays;
- (void)firstAnimationPart;
@end
