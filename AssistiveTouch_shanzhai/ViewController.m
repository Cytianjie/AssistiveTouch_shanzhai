//
//  ViewController.m
//  AssistiveTouch_shanzhai
//
//  Created by 和颂传媒 on 15/3/25.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "ViewController.h"

#import "HSmoverLable.h"

#define HSMOVERLABLE_X 0
#define HSMOVERLABLE_Y 100
@interface ViewController ()
@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)HSmoverLable *helloWorldLabel;


@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  买一送一
     *
     *  @return 哈哈
     */
    //    //初始化一个View，用来显示动画
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(0, 400, 20, 20)];
    redView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:redView];
    
    CAKeyframeAnimation *ani=[CAKeyframeAnimation animation];
    //初始化路径
    CGMutablePathRef aPath=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(aPath, nil, 0, 400);
    CGPathAddCurveToPoint(aPath, nil,
                          0, 400,//控制点
                          160, 200,//控制点
                          320, 400);//控制点
    
    ani.path=aPath;
    ani.duration=3;
    //设置为渐出
    ani.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    ani.rotationMode=@"auto";
    
    [redView.layer addAnimation:ani forKey:@"position"];
    
    
    /**
     *  下面才是正文
     *
     *  @return <#return value description#>
     */
    
    CGRect labelFrame = CGRectMake(HSMOVERLABLE_X, HSMOVERLABLE_Y, 100.0f, 100.0f);
    self.helloWorldLabel = [[HSmoverLable alloc] initWithFrame:labelFrame WhithView:self.view];
    self.helloWorldLabel.moboleView = SlidingYes;
    self.helloWorldLabel.SlidingTime= 0.1;
    self.helloWorldLabel.Amplification = 2.0f;
    [self.view addSubview:self.helloWorldLabel];

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
