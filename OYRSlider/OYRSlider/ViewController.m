//
//  ViewController.m
//  OYRSlider
//
//  Created by 欧阳荣 on 17/4/5.
//  Copyright © 2017年 HengTaiXin. All rights reserved.
//

#import "ViewController.h"

#import "OYRSlider.h"

@interface ViewController ()
{
    OYRSlider * _rangeSlider;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addSliderBackView];

}

//添加滚动视图背景
-(void)addSliderBackView
{
    UIImageView * sliderBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 150)];
    //    _sliderBackView.backgroundColor = [UIColor colorWithRed:0.733 green:0.920 blue:0.756 alpha:1.000];
    sliderBackView.userInteractionEnabled = YES;
    sliderBackView.backgroundColor = [UIColor yellowColor];//clearColor
    [self.view addSubview:sliderBackView];
    
    UILabel * signLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20,200, 20)];
    signLabel.backgroundColor = [UIColor clearColor];
    signLabel.textColor = [UIColor colorWithWhite:0.560 alpha:1.000];
    signLabel.font = [UIFont systemFontOfSize:18];
    signLabel.text = @"持续时间";
    [sliderBackView addSubview:signLabel];
    
    /* tpl 使用方法 */
    _rangeSlider = [[OYRSlider alloc] initWithFrame:CGRectMake(10,signLabel.frame.size.height + signLabel.frame.origin.y + 10, sliderBackView.frame.size.width - 10*2, sliderBackView.frame.size.height - signLabel.frame.size.height - 10)];
    //    _rangeSlider.backgroundColor = [UIColor colorWithRed:0.676 green:1.000 blue:0.366 alpha:1.000];
    _rangeSlider.backgroundColor = [UIColor clearColor];
    [sliderBackView addSubview:_rangeSlider];
    
    _rangeSlider.titleArray = @[@"30分钟",@"1小时",@"2小时",@"4小时",@"8小时",@"16小时",@"1天",@"2天",@"4天"];
    _rangeSlider.titleHeight = 20;
    _rangeSlider.titleFont = [UIFont systemFontOfSize:13];
    _rangeSlider.sliderItemSize = 28;
    
    
    //因为Slider是继承的UIControl,所以可以注册信息
    [_rangeSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    
    /* tpl 使用方法 */
    
}

-(void)valueChange:(id)sender
{
    OYRSlider * slider = (OYRSlider *)sender;
    
    NSLog(@" -- valueChange -- %ld",(long)slider.rightItem.range);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
