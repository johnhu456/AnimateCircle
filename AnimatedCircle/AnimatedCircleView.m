//
//  AnimatedCircleView.m
//  AnimatedCircle
//
//  Created by MADAO on 15/11/4.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import "AnimatedCircleView.h"
#import "AnimatedCircleShapeLayer.h"
#import "CABasicAnimation+CircleAnimation.h"
#import "CircleHeadLayer.h"
#import "CenterView.h"
#import "MoneyView.h"
#import "HeadLabel.h"

#define INSETS_WIDTH 5    //外环距边框差
#define INSIDE 20   //内外圆环半径差
#define MAX_SCALE M_PI/2 //最大弧度
#define DURATION 1.5f

#define LINE_COLOR [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:0.5]
@interface AnimatedCircleView ()
/**中心点*/
@property (nonatomic,assign) CGPoint                  circleCenter;
/**半径*/
@property (nonatomic,assign) CGFloat                  circleRadius;
/**收益天数*/
@property (nonatomic,assign) CGFloat                  investDays;
/**当前收益所占圆弧比*/
@property (nonatomic,assign) CGFloat                  curentProfitPrecent;
/**预期收益所占圆弧比*/
@property (nonatomic,assign) CGFloat                  expectedProfitPrecent;
/**圆弧曲线*/
@property (nonatomic,strong) UIBezierPath             *circlePath;
/**内圆弧曲线*/
@property (nonatomic,strong) UIBezierPath             *insideCirclePath;
/**当前收益曲线*/
@property (nonatomic,strong) UIBezierPath             *currentProfitPath;
/**预期收益曲线*/
@property (nonatomic,strong) UIBezierPath             *expectedProfitPath;
/**投资天数曲线*/
@property (nonatomic,strong) UIBezierPath             *investDaysPath;
/**上白线*/
@property (nonatomic,strong) UIBezierPath             *upsideLinePath;
/**下白线*/
@property (nonatomic,strong) UIBezierPath             *downsideLinePath;
/**当前收益图层*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *currentProfitLayer;
/**预期收益图层*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *expectedProfitLayer;
/**投资天数图层*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *investDaysLayer;
/**背景图层*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *backgroundLayer;
/**内背景图层*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *insideBackgroundLayer;
/**上白线图层*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *upsideLineLayer;
/**下白线图层*/
@property (nonatomic,strong) AnimatedCircleShapeLayer *downsideLineLayer;
/**内圈头*/
@property (nonatomic,strong) CircleHeadLayer          *circleHead;
/**中央视图*/
@property (nonatomic,strong) CenterView               *centerView;
/**上收益视图*/
@property (nonatomic,strong) MoneyView                *upsideMoneyView;
/**下收益视图*/
@property (nonatomic,strong) MoneyView                *downsideMoneyView;
@end

static NSString *KeyPath=@"strokeStart";
static NSString *Key=@"strokeStartAnimation";
@implementation AnimatedCircleView
#pragma mark - LazyInit
- (AnimatedCircleShapeLayer *)backgroundLayer{
    if (!_backgroundLayer) {
        self.circlePath=[UIBezierPath bezierPathWithArcCenter:self.circleCenter
                                                       radius:self.circleRadius
                                                   startAngle:0
                                                     endAngle:2*M_PI
                                                    clockwise:YES];
        _backgroundLayer=[AnimatedCircleShapeLayer layerWithPath:self.circlePath
                                                  andStrokeColor:[UIColor lightGrayColor]
                                                    andLineWidth:self.circleWidth];
    }
    return _backgroundLayer;
}
- (AnimatedCircleShapeLayer *)insideBackgroundLayer{
    if (!_insideBackgroundLayer) {
        self.insideCirclePath=[UIBezierPath bezierPathWithArcCenter:self.circleCenter
                                                         radius:self.circleRadius-INSIDE
                                                     startAngle:0
                                                       endAngle:2*M_PI
                                                      clockwise:NO];
        _insideBackgroundLayer=[AnimatedCircleShapeLayer layerWithPath:self.insideCirclePath
                                                        andStrokeColor:[UIColor colorWithRed:238/255.0 green:240/255.0 blue:241/255.0 alpha:1]
                                                          andLineWidth:1];
    }
    return _insideBackgroundLayer;
}
- (AnimatedCircleShapeLayer *)currentProfitLayer{
    if (!_currentProfitLayer) {
        if (self.curentProfitPrecent==1) {
            self.currentProfitPath=[UIBezierPath bezierPathWithArcCenter:self.circleCenter
                                                                  radius:self.circleRadius
                                                              startAngle:0
                                                                endAngle:2*M_PI
                                                               clockwise:YES];
        }
        else{
        self.currentProfitPath=[UIBezierPath bezierPathWithArcCenter:self.circleCenter
                                                          radius:self.circleRadius
                                                      startAngle:2*M_PI*(1-self.curentProfitPrecent)
                                                        endAngle:0
                                                       clockwise:YES];
        }
        _currentProfitLayer=[AnimatedCircleShapeLayer layerWithPath:self.currentProfitPath
                                                      andStrokeColor:[UIColor colorWithRed:236/255.0 green:132/255.0 blue:40/255.0 alpha:1]
                                                        andLineWidth:self.circleWidth];
    }
    return _currentProfitLayer;
}
- (AnimatedCircleShapeLayer *)expectedProfitLayer{
    if (!_expectedProfitLayer) {
        self.expectedProfitPath=[UIBezierPath bezierPathWithArcCenter:self.circleCenter
                                                           radius:self.circleRadius
                                                       startAngle:2*M_PI*self.expectedProfitPrecent
                                                         endAngle:0
                                                        clockwise:NO];
        _expectedProfitLayer=[AnimatedCircleShapeLayer layerWithPath:self.expectedProfitPath
                                                      andStrokeColor:[UIColor colorWithRed:248/255.0 green:200/255.0 blue:41/255.0 alpha:1]
                                                        andLineWidth:self.circleWidth];
    }
    return _expectedProfitLayer;
}
- (AnimatedCircleShapeLayer *)investDaysLayer{
    if (!_investDaysLayer) {
        self.investDaysPath=[UIBezierPath bezierPathWithArcCenter:self.circleCenter
                                                       radius:self.circleRadius-INSIDE
                                                   startAngle:3*M_PI/2+(2*M_PI)*(self.investDays/360)
                                                     endAngle:3*M_PI/2
                                                    clockwise:NO];
        _investDaysLayer=[AnimatedCircleShapeLayer layerWithPath:self.investDaysPath
                                                  andStrokeColor:[UIColor colorWithRed:36/255.0 green:120/255.0 blue:231/255.0 alpha:1]
                                                    andLineWidth:2];
    }
    return _investDaysLayer;
    
}
- (AnimatedCircleShapeLayer *)upsideLineLayer{
    if (!_upsideLineLayer) {
        CGFloat width=0;
        CGFloat height=0;
        if (self.curentProfitPrecent*2*M_PI>=MAX_SCALE) {
            /**取最大为起点*/
            width=(self.circleRadius)*sin(MAX_SCALE/2);
            height=width;
        }
        else{
            /**取比例中间*/
            width=(self.circleRadius)*cos(self.curentProfitPrecent*M_PI);
            height=(self.circleRadius)*sin(self.curentProfitPrecent*M_PI);
        }
        CGPoint startPoint=CGPointMake(self.circleCenter.x+width, self.circleCenter.y-height);
        CGPoint secondPoint=CGPointMake(self.circleCenter.x+self.circleRadius+1.5*self.circleWidth, self.circleCenter.y-self.circleRadius*0.90);
        CGPoint endPoint=CGPointMake(secondPoint.x+12*self.circleWidth, secondPoint.y);
        self.upsideLinePath=[UIBezierPath bezierPathWithArcCenter:startPoint
                                                           radius:1
                                                       startAngle:0
                                                         endAngle:2*M_PI
                                                        clockwise:YES];
        [self.upsideLinePath moveToPoint:startPoint];
        [self.upsideLinePath addLineToPoint:secondPoint];
        [self.upsideLinePath addLineToPoint:endPoint];
        [self.upsideLinePath moveToPoint:CGPointMake(secondPoint.x, self.circleCenter.y)];
        [self.upsideLinePath addLineToPoint:CGPointMake(endPoint.x, self.circleCenter.y)];
        _upsideLineLayer=[AnimatedCircleShapeLayer layerWithPath:self.upsideLinePath
                                                  andStrokeColor:LINE_COLOR
                                                    andLineWidth:1];
    }
    return _upsideLineLayer;
}
- (CAShapeLayer *)downsideLineLayer{
    if (!_downsideLineLayer) {
        CGFloat width=0;
        CGFloat height=0;
        if (self.expectedProfitPrecent*2*M_PI>=MAX_SCALE) {
            width=(self.circleRadius)*sin(MAX_SCALE/2);
            height=width;
        }
        else{
            width=self.circleRadius*cos(self.expectedProfitPrecent*M_PI);
            height=self.circleRadius*sin(self.expectedProfitPrecent*M_PI);
        }
        CGPoint startPoint=CGPointMake(self.circleCenter.x+width, self.circleCenter.y+height);
        CGPoint secondPoint=CGPointMake(self.circleCenter.x+self.circleRadius+1.5*self.circleWidth, self.circleCenter.y+self.circleRadius*0.90);
        CGPoint endPoint=CGPointMake(secondPoint.x+12*self.circleWidth, secondPoint.y);
        self.downsideLinePath=[UIBezierPath bezierPathWithArcCenter:startPoint
                                                             radius:1
                                                         startAngle:0
                                                           endAngle:2*M_PI
                                                          clockwise:YES];
        [self.downsideLinePath moveToPoint:startPoint];
        [self.downsideLinePath addLineToPoint:secondPoint];
        [self.downsideLinePath addLineToPoint:endPoint];
        _downsideLineLayer=[AnimatedCircleShapeLayer layerWithPath:self.downsideLinePath
                                                    andStrokeColor:LINE_COLOR
                                                      andLineWidth:1];
    }
    return _downsideLineLayer;
}
- (CircleHeadLayer *)circleHead{
    if (!_circleHead) {
        CGPoint center=CGPointMake(self.circleCenter.x, self.circleCenter.y-(self.circleRadius-INSIDE));
        _circleHead=[CircleHeadLayer headWithCGPoint:center];
    }
    return _circleHead;
}
#pragma mark - InitWithFrame
- (instancetype)initWithFrame:(CGRect)frame
                         rate:(CGFloat)rate
                CurrentProfit:(CGFloat)curentProfit
               ExpectedPorfit:(CGFloat)expectedProfit
                   investDays:(CGFloat)investDays{
    if (self = [super initWithFrame:frame])
    {
        CGPoint center=CGPointMake(self.bounds.origin.x+self.bounds.size.width/4+INSIDE,self.bounds.origin.y+self.bounds.size.height/2);
        self.curentProfitPrecent=curentProfit/(curentProfit+expectedProfit);
        self.expectedProfitPrecent=expectedProfit/(curentProfit+expectedProfit);
        self.investDays=investDays;
        self.circleWidth=10;
        self.circleRadius=self.bounds.size.height/2-INSETS_WIDTH*2;
        self.circleCenter=center;
        self.backgroundColor=[UIColor whiteColor];
        [self.layer addSublayer:self.backgroundLayer];
        [self.layer addSublayer:self.insideBackgroundLayer];
        [self.backgroundLayer addSublayer:self.currentProfitLayer];
        [self.backgroundLayer addSublayer:self.expectedProfitLayer];

        /**配置subview*/
        {
            CGFloat width=(self.circleRadius-INSIDE)*2/1.414;
            CGPoint centerViewOrigin=CGPointMake(center.x-width/2,center.y-width/2);
            self.centerView=[[CenterView alloc]initWithFrame:CGRectMake(centerViewOrigin.x, centerViewOrigin.y, width, width)
                                                 andRate:rate];
            self.centerView.alpha=0;
            [self addSubview:self.centerView];
        }
        
        /**upsideMoneyView*/
        {
            CGPoint upsideOrigin=CGPointMake(self.circleCenter.x+self.circleRadius+2*self.circleWidth, self.circleCenter.y-self.circleRadius*0.8);
            CGFloat height =self.circleRadius*sin(M_PI/4);
            self.upsideMoneyView=[[MoneyView alloc]initWithFrame:(CGRect){upsideOrigin,{height*2,height}}
                                                       withMoney:curentProfit
                                                    andIsCurrent:YES];
            self.upsideMoneyView.alpha=0;
           
            CGPoint downsideOrigin=CGPointMake(self.upsideMoneyView.frame.origin.x,self.circleCenter.y+self.circleRadius*0.1);
            self.downsideMoneyView=[[MoneyView alloc]initWithFrame:(CGRect){downsideOrigin,{height*2,height}}
                                                         withMoney:expectedProfit
                                                      andIsCurrent:NO];
            self.downsideMoneyView.alpha=0;
            [self addSubview:self.downsideMoneyView];
            [self addSubview:self.upsideMoneyView];

        }
        /**开始动画*/
        [self firstAnimationPart];
    }
    return self;
}
- (void)firstAnimationPart{

    CABasicAnimation *currentProfitAnimation = nil;
    currentProfitAnimation=[CABasicAnimation animationWithKeyPath:KeyPath
                                                                     duration:DURATION
                                                                    fromValue:@(self.currentProfitLayer.strokeEnd)
                                                                      toValue:@(self.currentProfitLayer.strokeStart)];
    [self.currentProfitLayer addAnimation:currentProfitAnimation forKey:Key];

    CABasicAnimation *expectedProfitAnimation = nil;
    expectedProfitAnimation = [CABasicAnimation animationWithKeyPath:KeyPath
                                                                        duration:DURATION
                                                                       fromValue:@(self.expectedProfitLayer.strokeEnd)
                                                                         toValue:@(self.expectedProfitLayer.strokeStart)];
    [self.expectedProfitLayer addAnimation:expectedProfitAnimation forKey:Key];
    
    [UIView animateWithDuration:DURATION delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.centerView.alpha=1;
    } completion:^(BOOL finished) {
        [self.backgroundLayer addSublayer:self.circleHead];
        [self.insideBackgroundLayer addSublayer:self.investDaysLayer];
        /**考虑某一方比例过大图层遮盖问题*/
        if(self.curentProfitPrecent<(1/25.0)){
            [self.expectedProfitLayer addSublayer:self.upsideLineLayer];
        }
        else{
        [self.currentProfitLayer addSublayer:self.upsideLineLayer];
        }
        [self.expectedProfitLayer addSublayer:self.downsideLineLayer];
        [self secondAnimationPart];
    }];
}
- (void)secondAnimationPart{
    CABasicAnimation *investDaysAnimation=nil;
    investDaysAnimation=[CABasicAnimation animationWithKeyPath:KeyPath
                                                                  duration:DURATION
                                                                 fromValue:@(self.investDaysLayer.strokeEnd)
                                                                   toValue:@(self.investDaysLayer.strokeStart)];
    [self.investDaysLayer addAnimation:investDaysAnimation forKey:Key];

    CAKeyframeAnimation *headAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    headAnimation.calculationMode     = kCAAnimationPaced;
    headAnimation.fillMode            = kCAFillModeForwards;
    headAnimation.removedOnCompletion = NO;
    headAnimation.duration            = DURATION;
    headAnimation.repeatCount         = 0;
    headAnimation.delegate            = self;
    CGPoint point                     = CGPointMake(self.bounds.origin.x, self.bounds.origin.y+self.circleRadius-INSIDE);
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:point
                                        radius:self.circleRadius-INSIDE
                                    startAngle:3*M_PI/2
                                      endAngle:3*M_PI/2+(2*M_PI)*(self.investDays/360)
                                     clockwise:YES];
    headAnimation.path=path.CGPath;
    
    CGPoint headCenter=CGPointMake(self.circleCenter.x, self.circleCenter.y-(self.circleRadius-INSIDE));
    self.circleHead.center=headCenter;
    
    [self.circleHead addAnimation:headAnimation
                            forKey:@"rotate"];
    
    /**右边动画部分*/
    CABasicAnimation *upsideLineAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd" duration:DURATION fromValue:@(self.upsideLineLayer.strokeStart) toValue:@(self.upsideLineLayer.strokeEnd)];
    [self.upsideLineLayer addAnimation:upsideLineAnimation forKey:@"showUpside"];
    
    CABasicAnimation *downsideLineAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd" duration:DURATION fromValue:@(self.downsideLineLayer.strokeStart) toValue:@(self.downsideLineLayer.strokeEnd)];
    [self.downsideLineLayer addAnimation:downsideLineAnimation forKey:@"showDownSide"];
    [UIView animateWithDuration:1.f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.upsideMoneyView.alpha=1;
        self.downsideMoneyView.alpha=1;
    } completion:nil];
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    /**设置天数Label部分*/
    CALayer *headLayer=(CALayer *)[self.circleHead presentationLayer];
    CGPoint headPoint=[[headLayer valueForKey:@"position"]CGPointValue];
    CGFloat height   = self.circleWidth*1.5;
    CGFloat width    = height*3;
    CGPoint newPoint = CGPointMake(headPoint.x-width/2.0+self.circleCenter.x,headPoint.y);
    HeadLabel *headLabel=[[HeadLabel alloc]initWithFrame:(CGRect){newPoint,{width,height}} andDays:self.investDays];
    [self addSubview:headLabel];

}
@end
