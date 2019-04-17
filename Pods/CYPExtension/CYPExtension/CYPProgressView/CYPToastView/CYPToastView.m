//
//  CYPToastView.m
//  CarEasyBuy
//
//  Created by cheyipai.com on 2018/8/3.
//  Copyright © 2018年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYPToastView.h"
#import "CYPMBProgressHUD.h"
#import "C_MacroDefine.h"
@interface CYPToastView ()
@property (nonatomic ,strong)CYPMBProgressHUD *hubTips;
@end
@implementation CYPToastView
+ (instancetype)showOnlyMessagePVAddedTo:(UIView *)view
                                 message:(NSString *)message {
    CYPToastView *pView = [CYPToastView progressViewWithView:view];
    [pView creatOnlyMessageMBProgressHUDAddto:pView message:message];
    return pView;
}
+ (instancetype)showPVAddedTo:(UIView *)view
                        image:(UIImage *)image
                      message:(NSString *)message {
    CYPToastView *pView = [CYPToastView progressViewWithView:view];
    [pView creatStateMBProgressHUDAddto:pView message:message image:image];
    return pView;
}
+ (instancetype)showSuccessPVAddedTo:(UIView *)view
                             message:(NSString *)message {
    CYPToastView *pView = [CYPToastView progressViewWithView:view];
    [pView creatStateMBProgressHUDAddto:pView message:message image:[[UIImage imageNamed:@"common_icon_toastsuccess"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    return pView;
    
}
+ (instancetype)showErrorPVAddedTo:(UIView *)view
                             message:(NSString *)message {
    CYPToastView *pView = [CYPToastView progressViewWithView:view];
    [pView creatStateMBProgressHUDAddto:pView message:message image:[[UIImage imageNamed:@"common_icon_toastFail"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    return pView;
    
}
+ (instancetype)showProgressPVAddedTo:(UIView *)view
                           message:(NSString *)message {
    CYPToastView *pView = [CYPToastView progressViewWithView:view];
    [pView creatMBProgressHUDAddto:pView message:message image:[[UIImage imageNamed:@"loading"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    return pView;
    
}
+ (instancetype)showOnlyMessageNotDismissPVAddedTo:(UIView *)view
                                           message:(NSString *)message {
    CYPToastView *pView = [CYPToastView progressViewWithView:view];
    pView.hubTips =  [pView creatOnlyMessageNotDismissMBProgressHUDAddto:pView message:message];
    return pView;
    
}
- (CYPMBProgressHUD *)creatOnlyMessageNotDismissMBProgressHUDAddto:(UIView *)pView message:(NSString *)message {
    

    CYPMBProgressHUD *hud = [CYPMBProgressHUD showHUDAddedTo:pView animated:YES];
    // Set the text mode to show only text.
    hud.mode = CYPMBProgressHUDModeText;
    hud.bezelView.backgroundColor = UIColorRGBA(0x000000,0.75);
    hud.contentColor = UIColorRGB(0xFFFFFF);
    hud.label.font = [UIFont systemFontOfSize:(14)];
    hud.label.numberOfLines = 0;
    hud.margin = 16;
    hud.marginTop = 12;
    hud.maxSize = CGSizeMake(172, 0);
    hud.label.text = [NSString stringWithFormat:@"%@",message];;
//    [hud hideAnimated:YES afterDelay:delayt];
//    DefineWeakSelf;
//    hud.completionBlock = ^{
//        [weakSelf dismiss];
//    };
    return hud;
}
- (CYPMBProgressHUD *)creatMBProgressHUDAddto:(UIView *)pView message:(NSString *)message image:(UIImage *)image {
    CYPMBProgressHUD *hud = [CYPMBProgressHUD showHUDAddedTo:pView animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = CYPMBProgressHUDModeRotationView;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    hud.margin = 24;
    hud.marginTop = 24;
    hud.label.font = [UIFont systemFontOfSize:(14)];
    hud.label.numberOfLines = 0;
    hud.maxSize = CGSizeMake(172, 300);
    // Optional label text.
    hud.label.text = [NSString stringWithFormat:@"%@",message];
    hud.bezelView.backgroundColor = UIColorRGBA(0x000000, 0.75);
    hud.contentColor = UIColorRGB(0xFFFFFF);
    DefineWeakSelf;
    hud.completionBlock = ^{
        [weakSelf dismiss];
    };
    return hud;
}
- (CYPMBProgressHUD *)creatStateMBProgressHUDAddto:(UIView *)pView message:(NSString *)message image:(UIImage *)image {

    CYPMBProgressHUD *hud = [CYPMBProgressHUD showHUDAddedTo:pView animated:YES];
  
    // Set the custom view mode to show any view.
    hud.mode = CYPMBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    hud.margin = 24;
    hud.marginTop = 24;
    hud.label.font = [UIFont systemFontOfSize:(14)];
    hud.maxSize = CGSizeMake(172, 300);
    hud.label.numberOfLines = 0;
    // Optional label text.
    hud.label.text = [NSString stringWithFormat:@"%@",message?message:@""];
    NSTimeInterval delayt = 1.5f;
    if ([message isKindOfClass:[NSString class]]) {
        if ( message.length>8) {
            delayt = 3.0f;
        }
    }
    hud.bezelView.backgroundColor = UIColorRGBA(0x000000, 0.75);
    hud.contentColor = UIColorRGB(0xFFFFFF);
    [hud hideAnimated:YES afterDelay:delayt];
    DefineWeakSelf;
    hud.completionBlock = ^{
        [weakSelf dismiss];
    };
    return hud;
}
- (CYPMBProgressHUD *)creatOnlyMessageMBProgressHUDAddto:(UIView *)pView message:(NSString *)message {
  
    NSTimeInterval delayt = 1.5f;
    if ([message isKindOfClass:[NSString class]]) {
        if ( message.length>8) {
            delayt = 3.0f;
        }
    }
    CYPMBProgressHUD *hud = [CYPMBProgressHUD showHUDAddedTo:pView animated:YES];
    // Set the text mode to show only text.
    hud.mode = CYPMBProgressHUDModeText;
    hud.bezelView.backgroundColor = UIColorRGBA(0x000000,0.75);
    hud.contentColor = UIColorRGB(0xFFFFFF);
    hud.label.font = [UIFont systemFontOfSize:(14)];
    hud.label.numberOfLines = 0;
    hud.margin = 16;
    hud.marginTop = 12;
    hud.maxSize = CGSizeMake(172, 0);
    hud.label.text = [NSString stringWithFormat:@"%@",message];;
    [hud hideAnimated:YES afterDelay:delayt];
    DefineWeakSelf;
    hud.completionBlock = ^{
        [weakSelf dismiss];
    };
    return hud;
}
- (void)chengeText:(NSString *)text {
    self.hubTips.label.text = text;
}
- (void)hideAfterDelay:(NSTimeInterval)delay {
    [self.hubTips hideAnimated:YES afterDelay:delay];
    DefineWeakSelf;
    self.hubTips.completionBlock = ^{
        [weakSelf dismiss];
    };
}
+ (CYPToastView *)progressViewWithView:(UIView*)view {
    
    CYPToastView *pView = [[CYPToastView alloc] initWithFrame:view.bounds];
    pView.backgroundColor = [UIColor clearColor];
    pView.userInteractionEnabled = NO;
    
    [view addSubview:pView];
    return pView;
}
- (void)dismiss {
    [CYPMBProgressHUD hideHUDForView:self animated:YES];
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
