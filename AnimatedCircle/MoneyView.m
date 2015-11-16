//
//  MoneyView.m
//  AnimatedCircle
//
//  Created by MADAO on 15/11/12.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import "MoneyView.h"
#import "AnimatedCircleShapeLayer.h"
#define TEXT_COLOR [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1]
#define INSIDE 20
#define FONT_NAME @"HelveticaNeue-Light"
@interface MoneyView ()
@property (nonatomic,assign) BOOL    isCurrent;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@end
@implementation MoneyView
- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel=[[UILabel alloc]initWithFrame:CGRectMake(INSIDE+5,0, self.frame.size.width, self.frame.size.height*0.3)];
        if (self.isCurrent) {
            _textLabel.text=@"当前累积收益";
        }
        else{
            _textLabel.text=@"预期收益";
        }
        [_textLabel setTextColor:TEXT_COLOR];
        _textLabel.font=[UIFont fontWithName:FONT_NAME size:15];
        _textLabel.backgroundColor=[UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        
        /**Layer部分*/
        UIBezierPath *bigCircle=[UIBezierPath bezierPathWithArcCenter:CGPointMake(INSIDE/2.0, INSIDE/2.0)
                                                               radius:_textLabel.frame.size.height/2.0
                                                           startAngle:0
                                                             endAngle:M_PI*2 clockwise:YES];
        UIBezierPath *smallCircle=[UIBezierPath bezierPathWithArcCenter:CGPointMake(INSIDE/2.0, INSIDE/2.0)
                                                                 radius:_textLabel.frame.size.height/4.0
                                                            startAngle:0
                                                               endAngle:M_PI*2 clockwise:YES];
        AnimatedCircleShapeLayer *bigLayer=[AnimatedCircleShapeLayer layerWithPath:bigCircle
                                                                    andStrokeColor:[UIColor colorWithRed:236/255.0 green:132/255.0 blue:40/255.0 alpha:0.4]
                                                                      andLineWidth:1];

        AnimatedCircleShapeLayer *smallLayer=[AnimatedCircleShapeLayer layerWithPath:smallCircle
                                                                      andStrokeColor:[UIColor colorWithRed:236/255.0 green:132/255.0 blue:40/255.0 alpha:1]
                                                                    andLineWidth:1];
        if(!self.isCurrent) {
            smallLayer.strokeColor=[UIColor colorWithRed:248/255.0 green:200/255.0 blue:41/255.0 alpha:1].CGColor;
            bigLayer.strokeColor=[UIColor colorWithRed:248/255.0 green:200/255.0 blue:41/255.0 alpha:0.4].CGColor;
            
        }
        smallLayer.fillColor = smallLayer.strokeColor;
        bigLayer.fillColor   = bigLayer.strokeColor;
        [bigLayer addSublayer:smallLayer];
        [self.layer addSublayer:bigLayer];
        
    }
    return _textLabel;
}
- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel=[[UILabel alloc]initWithFrame:CGRectMake(INSIDE+5,self.frame.size.height*0.5, self.frame.size.width, self.frame.size.height*0.4)];
        [_moneyLabel setTextColor:TEXT_COLOR];
        _moneyLabel.font                      = [UIFont fontWithName:FONT_NAME size:25];
        _moneyLabel.adjustsFontSizeToFitWidth = YES;
        _moneyLabel.textAlignment             = NSTextAlignmentLeft;
        _moneyLabel.backgroundColor           = [UIColor clearColor];
        
        /**layer部分*/
        CGPoint circleCenter=CGPointMake(INSIDE/2.0, _moneyLabel.center.y);
        UIBezierPath *circlePath=[UIBezierPath bezierPathWithArcCenter:circleCenter
                                                                radius:_textLabel.frame.size.height/2.0
                                                            startAngle:0 endAngle:2*M_PI clockwise:YES];
        AnimatedCircleShapeLayer *layer=[AnimatedCircleShapeLayer layerWithPath:circlePath
                                                                 andStrokeColor:TEXT_COLOR andLineWidth:1];
        [self.layer addSublayer:layer];
    
        /**￥Label*/
        CGRect labelFrame=(CGRect){circleCenter,{_textLabel.frame.size.height,_textLabel.frame.size.height}};
        UILabel *symbolLabel=[[UILabel alloc]initWithFrame:labelFrame];
        symbolLabel.center        = circleCenter;
        symbolLabel.text          =@"￥";
        symbolLabel.textColor     = TEXT_COLOR;
        symbolLabel.textAlignment = NSTextAlignmentCenter;
        symbolLabel.font=[UIFont fontWithName:FONT_NAME size:14];
        [self addSubview:symbolLabel];
    }
    return _moneyLabel;
}
-(instancetype)initWithFrame:(CGRect)frame withMoney:(CGFloat)money andIsCurrent:(BOOL)is
{
    if (self=[super initWithFrame:frame]) {
        self.isCurrent=is;
        [self addSubview:self.textLabel];
        [self addSubview:self.moneyLabel];
        self.moneyLabel.text=[NSString stringWithFormat:@"%.2f元",money];
    }
    return self;
}
@end
