//
//  UIView+Common.h
//  CarEasyBuy
//
//  Created by 马敬龙 on 16/6/15.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CYPReponse)

/**
 *  获取视图的第一相应的控制器
 *
 *  @return 返回控制器
 */
- (UIViewController *)firstReponseViewController;


- (UINavigationController *)cyp_responeNavigationController;

@end
