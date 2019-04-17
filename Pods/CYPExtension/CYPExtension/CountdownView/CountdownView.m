//
//  CountdownView.m
//  Regist
//
//  Created by 贾 on 15/8/10.
//  Copyright (c) 2015年 车易拍. All rights reserved.
//

#import "CountdownView.h"

#define CountingBgColor [UIColor colorWithRed:250/255. green:250/255. blue:250/255. alpha:1.]
#define CountBgColor    [UIColor colorWithRed:255/255. green:102/255. blue:0/255. alpha:1.]

@interface CountdownView ()

@property (strong, nonatomic)  UIButton *countDownBtn;

@end

@implementation CountdownView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.countDownColor = CountBgColor;
        self.countingColor = CountingBgColor;
        
        self.countDownBtn = [[UIButton alloc] initWithFrame:self.bounds];
        self.countDownBtn.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        [self.countDownBtn setTitle:@"获取短信验证码" forState:UIControlStateNormal];
        [self.countDownBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.countDownBtn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        self.countDownBtn.titleLabel.minimumScaleFactor = 10;
        [self.countDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.countDownBtn.layer.cornerRadius = 1;
        
        [self.countDownBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.countDownBtn setBackgroundColor:_countDownColor];
        [self addSubview:self.countDownBtn];
        
    }
    return self;
    
}

- (void)clickAction:(id)sender {
    
    if (_ClickBlock) {
        self.ClickBlock();
    }
}


- (void)start_SMS_CountDown {
    
    //通过检验发现，方法调用后，timeout会先自动-1，所以如果从15秒开始倒计时timeout应该写16
    __block int timeout = 60;
    
    //获取全局队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    // 设置触发的间隔时间, 0 * NSEC_PER_SEC    代表时间允许的误差是 0s
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    //block内部 如果对当前对象的强引用属性修改 应该使用__weak typeof(self)weakSelf 修饰  避免循环调用
    __block typeof(self)weakSelf = self;
    //设置定时器的触发事件
    dispatch_source_set_event_handler(timer, ^{
        
        timeout --;
        
        if (timeout <= 0) {
            
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.isClickEnable = YES;
                [weakSelf.countDownBtn setTitle:@"重新获取" forState:UIControlStateNormal];
            });
        }else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString * title = [NSString stringWithFormat:@"%dS后重新获取",timeout];
                [weakSelf.countDownBtn setTitle:title forState:UIControlStateNormal];
                weakSelf.isClickEnable = NO;
            });
        }
    });
    
    dispatch_resume(timer);
}

- (void)setIsClickEnable:(BOOL)isClickEnable
{
    _isClickEnable = isClickEnable;
    if (isClickEnable) {
        self.countDownBtn.userInteractionEnabled = YES;
        self.countDownBtn.backgroundColor =  _countDownColor;
        [self.countDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    } else {
        self.countDownBtn.userInteractionEnabled = NO;
        [self.countDownBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.countDownBtn.backgroundColor = _countingColor;
    }
}












@end
