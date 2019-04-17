//
//  CYPCountDownButton.m
//  CarEasyBuy
//
//  Created by cheyipai.com on 2018/8/9.
//  Copyright © 2018年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYPCountDownButton.h"
@interface CYPCountDownButton(){
    NSInteger _second;
    NSUInteger _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    CountDownChanging _countDownChanging;
    CountDownFinished _countDownFinished;
    TouchedCountDownButtonHandler _touchedCountDownButtonHandler;
}
@end
@implementation CYPCountDownButton
#pragma -mark touche action
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler{
    _touchedCountDownButtonHandler = [touchedCountDownButtonHandler copy];
    [self touched:self];
}

- (void)touched:(CYPCountDownButton*)sender{
    if (_touchedCountDownButtonHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _touchedCountDownButtonHandler(sender,sender.tag);
        });
    }
}

#pragma -mark count down method
- (void)startCountDownWithSecond:(NSUInteger)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerStart:(NSTimer *)theTimer {
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
    _second = _totalSecond - (NSInteger)(deltaTime+0.5) ;
    
    
    if (_second< 0.0)
    {
        [self stopCountDown];
    }
    else
    {
        if (_countDownChanging)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = _countDownChanging(self,_second);
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            });
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%zd秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
            
        }
    }
}

- (void)stopCountDown{
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_countDownFinished)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *title = _countDownFinished(self,_totalSecond);
                        [self setTitle:title forState:UIControlStateNormal];
                        [self setTitle:title forState:UIControlStateDisabled];
                    });
                }
                else
                {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                    
                }
            }
        }
    }
}
#pragma -mark block
- (void)countDownChanging:(CountDownChanging)countDownChanging{
    _countDownChanging = [countDownChanging copy];
}
- (void)countDownFinished:(CountDownFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}
- (void)dealloc {
    NSLog(@"释放");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
