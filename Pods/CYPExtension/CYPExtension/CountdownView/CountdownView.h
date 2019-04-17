//
//  CountdownView.h
//  Regist
//
//  Created by  on 15/8/10.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 文字显示 1.获取短信验证码 2.倒计时中：%dS后重新获取  3.倒计时结束：重新获取
 * 文字大小： 14.f
 */
@interface CountdownView : UIView

/**
 *  点击事件回调
 */
@property (nonatomic,copy) void (^ClickBlock)(void);

/**
 *  倒计时背景颜色 ，默认颜色 0xff6600
 */
@property (nonatomic, strong) UIColor * countDownColor;

/**
 *  正在倒计时的背景颜色， 默认颜色 0xeaeaea
 */
@property (nonatomic, strong) UIColor * countingColor;

/**
 *  是否可点击倒计时
 */
@property (nonatomic, assign) BOOL isClickEnable;


/**
 *  GCD_Source 倒计时功能
 *
 */
- (void)start_SMS_CountDown;




@end
