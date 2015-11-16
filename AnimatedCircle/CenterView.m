//
//  CenterView.m
//  AnimatedCircle
//
//  Created by MADAO on 15/11/12.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import "CenterView.h"
@interface CenterView ()
@property (nonatomic,assign) CGFloat rate;
@property (nonatomic,strong) UILabel *rateLabel;
@property (nonatomic,strong) UILabel *textLabel;
@end
@implementation CenterView
/**调整距离*/
#define ADJUST_DISTANCE 10
#define FONT_NAME @"HelveticaNeue-Light"
- (UILabel *)rateLabel{
    if (!_rateLabel) {
        _rateLabel=[[UILabel alloc]init];
        _rateLabel.text=[NSString stringWithFormat:@"%.1f%%",self.rate];
        _rateLabel.font=[UIFont fontWithName:FONT_NAME size:30];
        _rateLabel.textAlignment = NSTextAlignmentCenter;
        _rateLabel.adjustsFontSizeToFitWidth = YES;
        [_rateLabel setTextColor:[UIColor colorWithRed:236/255.0 green:132/255.0 blue:40/255.0 alpha:1]];
    }
    return _rateLabel;
}
- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel=[[UILabel alloc]init];
        _textLabel.text=@"当前年化";
        _textLabel.font=[UIFont fontWithName:FONT_NAME size:15];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [_textLabel setTextColor:[UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1]];
    }
    return _textLabel;
}
- (instancetype)initWithFrame:(CGRect)frame andRate:(CGFloat)rate{
    if (self=[super initWithFrame:frame]) {
        self.rate=rate;
        [self addSubview:self.rateLabel];
        self.rateLabel.frame=(CGRect){CGPointMake(0, ADJUST_DISTANCE), {self.frame.size.width, self.frame.size.height*0.618}};
        [self addSubview:self.textLabel];
        CGPoint origin=CGPointMake(0, CGRectGetMaxY(self.rateLabel.frame)-ADJUST_DISTANCE);
        self.textLabel.frame=(CGRect){origin,{self.frame.size.width,self.frame.size.height*(1-0.618)}};
    }
    return self;
}
@end
