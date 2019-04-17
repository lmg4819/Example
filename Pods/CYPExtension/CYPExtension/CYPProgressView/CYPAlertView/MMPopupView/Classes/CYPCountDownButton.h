//
//  CYPCountDownButton.h
//  CarEasyBuy
//
//  Created by cheyipai.com on 2018/8/9.
//  Copyright © 2018年 北京巅峰科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYPCountDownButton;
typedef NSString* (^CountDownChanging)(CYPCountDownButton *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(CYPCountDownButton *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(CYPCountDownButton *countDownButton,NSInteger tag);

@interface CYPCountDownButton : UIButton
@property(nonatomic,strong) id userInfo;
///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;
@end
