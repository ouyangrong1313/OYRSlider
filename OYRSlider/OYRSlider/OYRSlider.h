//
//  OYRSlider.h
//  OYRSlider
//
//  Created by 欧阳荣 on 17/4/5.
//  Copyright © 2017年 HengTaiXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OYRSliderItem : UIImageView

@property(nonatomic,strong)void (^pan)(UIPanGestureRecognizer * pan ,int itemStyle,OYRSliderItem * item);
@property(nonatomic,assign)int itemStyle;//0为左边，1为右边

@property(nonatomic,assign)int range;


@end

@interface OYRSlider : UIControl

@property(nonatomic,assign)CGFloat  titleHeight;//文字高度
@property(nonatomic,strong)NSArray * titleArray;//文字数组
@property(nonatomic,strong)UIColor * titleColor;//文字颜色
@property(nonatomic,strong)UIColor * titleSelectColor;//文字颜色
@property(nonatomic,strong)UIFont  * titleFont;//文字大小

//滑动块
@property(nonatomic,readonly)OYRSliderItem * rightItem;

//滑动条
@property(nonatomic,strong)UIColor * bottomColor;//底部颜色
@property(nonatomic,strong)UIColor * upColor;//滑动区域颜色
@property(nonatomic,assign)CGFloat sliderItemSize;//滑块的大小
@property(nonatomic,assign)CGFloat bottomViewHeight;//底部view的高
@property(nonatomic,assign)CGFloat upViewHeight;//上面的高


@end
