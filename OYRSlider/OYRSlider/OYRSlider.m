//
//  OYRSlider.m
//  OYRSlider
//
//  Created by 欧阳荣 on 17/4/5.
//  Copyright © 2017年 HengTaiXin. All rights reserved.
//

#import "OYRSlider.h"


#define dealocInfo NSLog(@"%@ 释放了",[self class])
#define baseColor [UIColor colorWithRed:0.389 green:0.670 blue:0.265 alpha:1.000]

@implementation OYRSliderItem

-(void)dealloc{
    dealocInfo;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"btn_slide_pk"];
        //添加手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}


-(void)pan:(UIPanGestureRecognizer *)pan
{
    if (self.pan)
    {
        typeof(self) __weak weak_self = self;
        self.pan(pan,_itemStyle,weak_self);
    }
}


@end

@interface OYRSlider ()
{
    //data
    NSMutableArray * _titleLabelArray;
    NSMutableArray * _buttomLineArray;

    int _mixValue;
    int _maxValue;
    
    //View
    //    IFRangeSliderItem * _leftItem;
    //    IFRangeSliderItem * _rightItem;
    
    UIImageView * _bottomView;
    UIImageView * _upView;
    
}

//@property(nonatomic,strong)IFRangeSliderItem * leftItem;
//@property(nonatomic,strong)IFRangeSliderItem * rightItem;
@property(nonatomic,strong)UIImageView * upView;

@end


@implementation OYRSlider

@synthesize rightItem = _rightItem;
@synthesize upView = _upView;


-(void)dealloc
{
    dealocInfo;
}

#pragma mark
#pragma mark           porperty
#pragma mark


-(void)setTitleHeight:(CGFloat )titleHeight
{
    _titleHeight = titleHeight;
    [self refreshView];
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    if(_maxValue == 0)
        _maxValue = 1;//(int)titleArray.count - 1;
    [self refreshView];
}
-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self refreshView];
}
-(void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [self refreshView];
}



//滑块
-(void)setBottomColor:(UIColor *)bottomColor
{
    _bottomColor = bottomColor;
    [self refreshView];
}

-(void)setUpColor:(UIColor *)upColor
{
    _upColor = upColor;
    [self refreshView];
}

-(void)setSliderItemSize:(CGFloat)sliderItemSize
{
    _sliderItemSize = sliderItemSize;
    [self refreshView];
}

-(void)setBottomViewHeight:(CGFloat)bottomViewHeight
{
    _bottomViewHeight = bottomViewHeight;
    [self refreshView];
}

-(void)setUpViewHeight:(CGFloat)upViewHeight
{
    _upViewHeight = upViewHeight;
    [self refreshView];
}

#pragma mark
#pragma mark           init view
#pragma mark
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        
        //init data
        _titleLabelArray = [[NSMutableArray alloc] initWithCapacity:0];
        _buttomLineArray = [[NSMutableArray alloc] initWithCapacity:0];
        //init config 设置默认的
        _titleHeight = 0;
        _titleColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];//[UIColor grayColor];
        _titleFont = [UIFont systemFontOfSize:10.0f];
        _titleSelectColor = [UIColor colorWithRed:0/255.0 green:143/255.0 blue:226/255.0 alpha:1];
        _upViewHeight = 5;
        _bottomViewHeight = 5;
        _bottomColor = [UIColor colorWithRed:174/255.0 green:195/255.0 blue:208/255.0 alpha:1];//[UIColor colorWithWhite:0.788 alpha:1.000];
        _upColor = [UIColor colorWithRed:0/255.0 green:143/255.0 blue:226/255.0 alpha:1];//baseColor;
        _sliderItemSize = 20;
        _maxValue = 0;
        _mixValue = 0;
        
        [self refreshView];
    }
    return self;
}



#pragma mark
#pragma mark           help
#pragma mark
-(void)refreshView
{
    //清空之前的title
    while (_titleLabelArray.count > 0)
    {
        [_titleLabelArray.lastObject removeFromSuperview];
        [_titleLabelArray removeLastObject];
    }
    
    //重新加载新标题
    CGFloat width = _titleArray == nil ? 0 : self.frame.size.width/_titleArray.count;//标题长度
    for (int i = 0; i < _titleArray.count; i++)
    {
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:(CGRect){{i*width,0},{width,_titleHeight}}];
        titleLabel.textColor = _titleColor;
        titleLabel.font = _titleFont;
        titleLabel.tag = i;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        if (0 == i)
        {
            titleLabel.textAlignment = NSTextAlignmentLeft;
        }else if (_titleArray.count - 1 == i)
        {
            titleLabel.textAlignment = NSTextAlignmentRight;
        }
        if (i == _maxValue) {
            titleLabel.textColor =  _titleSelectColor;
        }else{
            titleLabel.textColor = _titleColor;
        }
        [self addSubview:titleLabel];
        titleLabel.text = [_titleArray objectAtIndex:i];
        [_titleLabelArray addObject:titleLabel];
    }
    
    //加载滑块
    //加底部线
    [_bottomView removeFromSuperview];
    if (_bottomView == nil)
    {
        _bottomView = [[UIImageView alloc] init];
    }
    _bottomView.frame = CGRectMake(0,_titleHeight + 10 + _sliderItemSize/2 - _bottomViewHeight/2, self.frame.size.width, _bottomViewHeight);
    _bottomView.layer.cornerRadius = _bottomViewHeight/2;
    _bottomView.backgroundColor = _bottomColor;
    [self addSubview:_bottomView];
    //加上分割线
    while (_buttomLineArray.count > 0)
    {
        [_buttomLineArray.lastObject removeFromSuperview];
        [_buttomLineArray removeLastObject];
    }
    for (NSInteger i = 1; i < 8; i ++) {
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(i * width + width/2,0, 1, _bottomView.frame.size.height)];
        line.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [_buttomLineArray addObject:line];
        [_bottomView addSubview:line];
    }
    
    //加上部线
    [_upView removeFromSuperview];
    if (_upView == nil)
    {
        _upView = [[UIImageView alloc] init];
    }
    CGFloat mixX = 0;//_mixValue == 0 ? _sliderItemSize/2 :(_mixValue*width + width/2);
    CGFloat maxX = _maxValue == 0 || _maxValue == _titleArray.count - 1 ? (self.frame.size.width - _sliderItemSize/2) : _maxValue*width + width/2;
    _upView.frame = CGRectMake(mixX,_titleHeight + 10 + _sliderItemSize/2 - _upViewHeight/2,maxX - mixX, _upViewHeight);
    _upView.backgroundColor = _upColor;
    _upView.layer.cornerRadius = _bottomViewHeight/2;
    [self addSubview:_upView];
   
    //加滑块
    
    [_rightItem removeFromSuperview];
    if (_rightItem == nil)
    {
        _rightItem = [[OYRSliderItem alloc] init];
    }
    _rightItem.frame = CGRectMake(0, 0, _sliderItemSize + 5, _sliderItemSize + 5);
    //_rightItem.layer.cornerRadius = _sliderItemSize/2;
    //[_rightItem.layer masksToBounds];
    _rightItem.backgroundColor = [UIColor clearColor];//_upColor;
    _rightItem.itemStyle = 1;
    _rightItem.range = 1;//(int)_titleArray.count - 1;
    _rightItem.center = CGPointMake(maxX, _upView.center.y);
    [self addSubview:_rightItem];//最大值的滑块
    
    //滑块的滑动block
    typeof(self)__weak weak_self = self;
    void (^pan)(UIPanGestureRecognizer * pan,int itemStyle ,OYRSliderItem * item) = ^(UIPanGestureRecognizer * pan,int itemStyle,OYRSliderItem * item)
    {
        typeof(weak_self) __strong strong_self = weak_self;
        if (strong_self)
        {
            
            if (pan.state == UIGestureRecognizerStateBegan)
            {
                NSLog(@"UIGestureRecognizerStateBegan");
            }
            
            if (pan.state == UIGestureRecognizerStateChanged)
            {
                NSLog(@"UIGestureRecognizerStateChanged");
                
                CGPoint point = [pan locationInView:strong_self];
                CGFloat x = point.x;//获取滑块的起始坐标
                if (1 == itemStyle)//右滑块
                {
                    if (x > (strong_self.frame.size.width - strong_self.sliderItemSize/2))
                    {
                        x = strong_self.frame.size.width - strong_self.sliderItemSize/2 + 2;
                    }
                    
                    if(x < strong_self.sliderItemSize/2)
                    {
                        x = strong_self.sliderItemSize/2;
                    }
                    item.center = CGPointMake(x, item.center.y);
                }
                
                //跳整上面的浮动宽度
                CGFloat width = self.rightItem.center.x - 0;
                strong_self.upView.frame = CGRectMake(0, strong_self.upView.frame.origin.y,width,strong_self.upViewHeight);//调整选中的坐标
            }
            
            if (pan.state == UIGestureRecognizerStateEnded)
            {
                NSLog(@"UIGestureRecognizerStateEnded");
                
                [strong_self adjustSliderItem];
            }
            
        }
    };
    //设置block
    _rightItem.pan = pan;
    
}


//调整滑块到正确的结点
-(void)adjustSliderItem
{
    CGFloat width = _titleArray == nil ? 0 : self.frame.size.width/_titleArray.count;//一个刻度的宽
    CGPoint center;

    //右边
    int range = _rightItem.center.x/width;//右边滑到的位置
    NSLog(@"  range 1 :%d",range);
    
    if (range == _titleArray.count - 1)
    {
        if (_rightItem.center.x < self.frame.size.width - width/2)
        {
            range --;
            center =  CGPointMake(range * width + width/2, _rightItem.center.y);
        }else{
            center =  CGPointMake((range + 1) * width - self.sliderItemSize/2 + 2, _rightItem.center.y);
        }
    }else if(range == 0){
        center =  CGPointMake(self.sliderItemSize/2 - 2, _rightItem.center.y);
    }else{
        center =  CGPointMake(range * width + width/2, _rightItem.center.y);
    }
    NSLog(@"  range 2 :%d",range);

    //__weak __typeof(&*self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _rightItem.center = center;
        _upView.frame = CGRectMake(_upView.frame.origin.x, _upView.frame.origin.y, _rightItem.center.x, _upView.frame.size.height);
        
    } completion:^(BOOL finished){
        _rightItem.range = range;
        _maxValue = range;
        //改变title的颜色
        for (UILabel * lab in _titleLabelArray) {
            if (lab.tag == _maxValue) {
                lab.textColor = _titleSelectColor;
            }else{
                lab.textColor = _titleColor;
            }
        }
        //此处加值变化通知
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }];
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
