//
//  RefreshFooter.m
//  MoreDataOrNewData
//
//  Created by songgp on 2017/2/27.
//  Copyright © 2017年 songgppengpengpeng. All rights reserved.
//

#import "CYPAutoRefreshFooter.h"

@interface CYPAutoRefreshFooter ()

@property (nonatomic , strong) UIImageView *loadingView;

@end

@implementation CYPAutoRefreshFooter{
    CGFloat _angle;
    MJRefreshState Refreshstate;
}

- (UIImageView *)loadingView
{
    if (!_loadingView) {
        UIImageView *loadingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_image.png"]];
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)prepare{
    [super prepare];
    
    _angle = 0;
    
    self.stateLabel.textColor = [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1.];
    self.stateLabel.font = [UIFont systemFontOfSize:14];
    [self setTitle:@"上拉或点击加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"没有更多内容啦～" forState:MJRefreshStateNoMoreData];
    [self setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
    
    // 圈圈
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.isRefreshingTitleHidden) {
        arrowCenterX -= 20;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    self.loadingView.bounds = CGRectMake(0, 0, 16, 16);
    self.loadingView.center = CGPointMake(arrowCenterX, arrowCenterY);
}

- (void)setState:(MJRefreshState)state
{
    Refreshstate = state;
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        self.loadingView.hidden = YES;
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.hidden = NO;
        [self refreshStartAnimation];
    }
}

- (void)refreshStartAnimation{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(_angle * (M_PI /180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.loadingView.transform = endAngle;
    } completion:^(BOOL finished) {
        if (Refreshstate == MJRefreshStateRefreshing) {
            _angle += 15;
            [self refreshStartAnimation];
        }
    }];
}

@end
