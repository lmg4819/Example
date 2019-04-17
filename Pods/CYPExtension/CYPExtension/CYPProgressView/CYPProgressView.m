//
//  CYPProgressView.m
//  HudDemo
//
//  Created by cheyipai.com on 16/7/11.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#import "CYPProgressView.h"
//#import "MBProgressHUD.h"
#define delay 3
#define balpha 0.8

@interface CYPProgressView ()
@property (nonatomic ,strong) CYPMBProgressHUD *hud;
@end

@implementation CYPProgressView
#pragma - public
+ (instancetype)showPVAddedTo:(UIView *)view
                      message:(NSString *)message {
    
    CYPProgressView *pView = [[CYPProgressView alloc] progressViewWithView:view];
    CYPMBProgressHUD *HUD = [pView creatMBProgressHUDAddto:pView];;
    HUD.label.text = message;
    return pView;
}

+ (instancetype)showPVAddedTo:(UIView *)view
                      message:(NSString *)message
                     duration:(NSTimeInterval)duration {
    
    CYPProgressView *pView = [[CYPProgressView alloc] progressViewWithView:view];
    CYPMBProgressHUD *HUD = [pView creatMBProgressHUDAddto:pView];
    [HUD hideAnimated:YES afterDelay:duration];
    HUD.label.text = message;
    return pView;
}
+ (instancetype)showSuccessPVKeyWindowWithmessage:(NSString *)message
                                         duration:(NSTimeInterval)duration {

    UIWindow *keyw = [UIApplication sharedApplication].keyWindow;
     return [CYPProgressView showPVAddedTo:keyw status:message image:[[UIImage imageNamed:@"success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] delays:duration];


}
+ (instancetype)showSuccessPVAddedTo:(UIView *)view message:(NSString *)message {

    return [CYPProgressView showPVAddedTo:view status:message image:[[UIImage imageNamed:@"success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] delays:delay];

}
+ (instancetype)showSuccessPVAddedTo:(UIView *)view
                             message:(NSString *)message
                            duration:(NSTimeInterval)duration {

    return [CYPProgressView showPVAddedTo:view status:message image:[[UIImage imageNamed:@"success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]delays:duration];
}
+ (instancetype)showErrorPVAddedTo:(UIView *)view message:(NSString *)message  {

    return [CYPProgressView showPVAddedTo:view status:message image:[[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] delays:delay];
}
+ (instancetype)showPVAddedTo:(UIView *)view
                        image:(UIImage *)image
                      message:(NSString *)message
                     duration:(NSTimeInterval)duration {

  return [CYPProgressView showPVAddedTo:view status:message image:image delays:duration];

}
#pragma mark - Private
+ (instancetype)showPVAddedTo:(UIView *)view status:(NSString *)status  image:(UIImage *)image  delays:(NSTimeInterval)dela{

    CYPProgressView *pView = [[CYPProgressView alloc] progressViewWithView:view];
    CYPMBProgressHUD *HUD = [pView creatMBProgressHUDAddto:pView];
    
    if (image != nil) {
        HUD.mode = CYPMBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:image];
        HUD.square = YES;
    }else {
        HUD.mode = CYPMBProgressHUDModeText;
        HUD.margin = 16;
        HUD.marginTop = 12;
//        HUD.offset = CGPointMake(0.f, 0.f);

    }
    
    HUD.label.text = status;
    [HUD hideAnimated:YES afterDelay:dela];
    return pView;

}
- (CYPMBProgressHUD *)creatMBProgressHUDAddto:(UIView *)pView {
    
    self.hud = [CYPMBProgressHUD showHUDAddedTo:pView animated:YES];
    _hud.label.numberOfLines = 0;
    
    [self backView:self.hud];
    self.hud.userInteractionEnabled = NO;
    __weak CYPProgressView* weakPView = self;
    self.hud.completionBlock = ^{
        [weakPView hideProgressView];
        
    };
    return self.hud;
}
- (void)backView:(CYPMBProgressHUD *)hud {
    
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:balpha];
    hud.contentColor = [UIColor whiteColor];
    self.backColor = [UIColor clearColor];

}
- (CYPProgressView *)progressViewWithView:(UIView*)view {
    
    CYPProgressView *pView = [[CYPProgressView alloc] initWithFrame:view.bounds];
    pView.backgroundColor = [UIColor clearColor];
    pView.userInteractionEnabled = NO;
    [view addSubview:pView];
    return pView;
}
- (void)hideProgressView {
    if (self.completionBlock) {
        self.completionBlock();
    }
    [CYPMBProgressHUD hideHUDForView:self animated:NO];
    [self removeFromSuperview];
}
#pragma mark - set
- (void)setBackColor:(UIColor *)backColor {

    _backColor = backColor;
    self.backgroundColor = self.backColor;

}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
     _hud.contentColor = self.textColor;
}
- (void)setPopViewColor:(UIColor *)popViewColor {
    _popViewColor = popViewColor;
    _hud.bezelView.backgroundColor = popViewColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
