//
//  ViewController.m
//  AnimatedCircle
//
//  Created by MADAO on 15/11/4.
//  Copyright © 2015年 MADAO. All rights reserved.
//

#import "ViewController.h"
#import "AnimatedCircleView.h"
@interface ViewController ()
@property (nonatomic,strong) AnimatedCircleView *animatedView;
@property (weak, nonatomic) IBOutlet UITextField *currentProfitTF;
@property (weak, nonatomic) IBOutlet UITextField *expectedProfit;
@property (weak, nonatomic) IBOutlet UITextField *investDaysTF;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame=CGRectMake(0, self.view.center.y-self.view.frame.size.width/4, self.view.frame.size.width, self.view.frame.size.width/2);
    self.animatedView=[[AnimatedCircleView alloc]initWithFrame:frame rate:13.5 CurrentProfit:356.00 ExpectedPorfit:0.00 investDays:200];
    [self.view addSubview:self.animatedView];
    
}
- (IBAction)triger:(UITextField *)sender {
    [self.animatedView removeFromSuperview];
    CGRect frame=CGRectMake(0, self.view.center.y-self.view.frame.size.width/4, self.view.frame.size.width, self.view.frame.size.width/2);
    self.animatedView=[[AnimatedCircleView alloc]initWithFrame:frame
                                                          rate:13.5
                                                 CurrentProfit:[self.currentProfitTF.text floatValue]
                                                ExpectedPorfit:[self.expectedProfit.text floatValue]
                                                    investDays:[self.investDaysTF.text floatValue]];
    [self.view addSubview:self.animatedView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
