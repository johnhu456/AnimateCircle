//
//  CircleHeadView.m
//  AnimatedCircle
//
//  Created by MADAO on 15/11/5.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import "CircleHeadLayer.h"
@interface CircleHeadLayer ()
/**最外圈路径*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *firstLayer;
/**中圈路径*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *secondLayer;
/**最内路径*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *thirdLayer;
@end
#define INSET 3
#define LINE_WIDTH 3
@implementation CircleHeadLayer
+ (instancetype)headWithCGPoint:(CGPoint)center{
    CircleHeadLayer *head=[[CircleHeadLayer alloc]init];
    head.center=center;
    [head addSublayer:head.firstLayer];
    [head addSublayer:head.secondLayer];
    [head addSublayer:head.thirdLayer];
    return head;
}
- (AnimatedCircleShapeLayer *)firstLayer{
    if (!_firstLayer) {
        UIBezierPath *firstPath=[UIBezierPath bezierPathWithArcCenter:self.center
                                                               radius:8
                                                           startAngle:0
                                                             endAngle:2*M_PI
                                                            clockwise:YES];
        firstPath.lineWidth=LINE_WIDTH;
        _firstLayer=[AnimatedCircleShapeLayer layerWithPath:firstPath
                                             andStrokeColor:[UIColor colorWithRed:36/255.0 green:120/255.0 blue:231/255.0 alpha:0.2]
                                               andLineWidth:1];
        _firstLayer.fillColor=_firstLayer.strokeColor;
    }
    return _firstLayer;
}
- (AnimatedCircleShapeLayer *)secondLayer{
    if (!_secondLayer) {
        UIBezierPath *secondPath=[UIBezierPath bezierPathWithArcCenter:self.center
                                                               radius:8-INSET
                                                           startAngle:0
                                                             endAngle:2*M_PI
                                                            clockwise:YES];
        secondPath.lineWidth=LINE_WIDTH;
        _secondLayer=[AnimatedCircleShapeLayer layerWithPath:secondPath
                                            andStrokeColor:[UIColor colorWithRed:36/255.0 green:120/255.0 blue:231/255.0 alpha:0.5]
                                                andLineWidth:1];
        _secondLayer.fillColor=_secondLayer.strokeColor;
    }
    return _secondLayer;
}
- (AnimatedCircleShapeLayer *)thirdPath{
    if (!_thirdLayer) {
        UIBezierPath *thirdPath=[UIBezierPath bezierPathWithArcCenter:self.center
                                                               radius:8-INSET*2
                                                           startAngle:0
                                                             endAngle:2*M_PI
                                                            clockwise:YES];
        thirdPath.lineWidth=LINE_WIDTH;
        _thirdLayer=[AnimatedCircleShapeLayer layerWithPath:thirdPath
                                             andStrokeColor:[UIColor colorWithRed:36/255.0 green:120/255.0 blue:231/255.0 alpha:1] andLineWidth:1];
        _thirdLayer.fillColor=_thirdLayer.strokeColor;
    }
    return _thirdLayer;
}
@end
