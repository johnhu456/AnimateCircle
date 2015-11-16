//
//  HeadLabel.m
//  AnimatedCircle
//
//  Created by MADAO on 15/11/12.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import "HeadLabel.h"

@implementation HeadLabel
- (instancetype)initWithFrame:(CGRect)frame andDays:(CGFloat)days{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor     = [UIColor colorWithRed:99/255.0 green:177/255.0 blue:251/255.0 alpha:0.5];
        self.layer.cornerRadius  = frame.size.height/2.0;
        self.text                = [NSString stringWithFormat:@"%.f天",days];
        self.textAlignment       = NSTextAlignmentCenter;
        self.textColor           = [UIColor whiteColor];
        self.font                = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        self.layer.masksToBounds = YES;
    }
    return self;
}
@end
