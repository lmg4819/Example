//
//  CYPToastView.h
//  CarEasyBuy
//
//  Created by cheyipai.com on 2018/8/3.
//  Copyright © 2018年 北京巅峰科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYPToastView : UIView
/**
 * 只显示文字的提示框 自动消失
 * view      在View上显示提示框
 * message   提示语
 */
+ (instancetype)showOnlyMessagePVAddedTo:(UIView *)view
                                 message:(NSString *)message;
/**
 * 只显示文字的提示框 不自动消失，需调用dismiss方法
 * view      在View上显示提示框
 * message   提示语
 */
+ (instancetype)showOnlyMessageNotDismissPVAddedTo:(UIView *)view
                                           message:(NSString *)message;
- (void)chengeText:(NSString *)text;
- (void)hideAfterDelay:(NSTimeInterval)delay;
/**
 *操作成功提示框
 * view      在View上显示提示框
 * message   提示语
 */
+ (instancetype)showSuccessPVAddedTo:(UIView *)view
                             message:(NSString *)message;
/**
 *馈操作失败提示框
 * view      在View上显示提示框
 * message   提示语
 */
+ (instancetype)showErrorPVAddedTo:(UIView *)view
                           message:(NSString *)message;
/**
 *过程中提示框
 * view      在View上显示提示框
 * message   提示语
 */
+ (instancetype)showProgressPVAddedTo:(UIView *)view
                              message:(NSString *)message;

/**
 *提示框，图片自行选择
 * view      在View上显示提示框
 * image     图片
 * message   提示语
 */
+ (instancetype)showPVAddedTo:(UIView *)view
                        image:(UIImage *)image
                      message:(NSString *)message;

/**
 *消失
 */
- (void)dismiss;

@end
