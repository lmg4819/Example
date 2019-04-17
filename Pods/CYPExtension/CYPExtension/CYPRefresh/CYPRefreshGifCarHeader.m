//
//  CYPRefreshGifCarHeader.m
//  车易拍
//
//  Created by songhh on 16/2/18.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYPRefreshGifCarHeader.h"
#import "UIView+ViewAddtions.h"

@interface CYPRefreshGifCarHeader ()
{
    CGFloat _angle;
    BOOL _isRefresh;
}
@property (weak, nonatomic) UILabel *label;

@property (weak, nonatomic) UIImageView *logo;

@end

@implementation CYPRefreshGifCarHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    _angle = 0;
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_image.png"]];
    [self addSubview:logo];
    self.logo = logo;
    
    self.backgroundColor = [UIColor clearColor];
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1.];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.label = label;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.logo.bounds = CGRectMake(0, 0, 16, 16);
    self.logo.center = CGPointMake((self.mj_w * 0.5) - 30, self.mj_h * 0.5);
    self.label.frame =CGRectMake(self.width_v*0.5 - 10, 0, self.width_v ,self.height_v);
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            _isRefresh = NO;
            self.label.text = @"下拉刷新";
            break;
        case MJRefreshStatePulling:
            _isRefresh = YES;
            self.label.text = @"松开立即刷新";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"加载中…";
            _isRefresh = YES;
            [self refreshStartAnimation];
            break;
        default:
            break;
    }
}
- (void)refreshStartAnimation
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(_angle * (M_PI /180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.logo.transform = endAngle;
    } completion:^(BOOL finished) {
        if (_isRefresh) {
            _angle += 15;
            [self refreshStartAnimation];
        }
    }];
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    //    CGFloat red = 1.0 - pullingPercent * 0.5;
    //    CGFloat green = 0.5 - 0.5 * pullingPercent;
    //    CGFloat blue = 0.5 * pullingPercent;
    //    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
- (void)dealloc{
    _isRefresh = NO;
}

@end
