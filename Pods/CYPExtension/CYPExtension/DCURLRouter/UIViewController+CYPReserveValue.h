//
//  UIViewController+CYPReserveValue.h
//  CarEasyBuy
//
//  Created by songhh on 2017/7/18.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CYPReverseBlock)(id reserveValue);

@interface UIViewController (CYPReserveValue)

@property (nonatomic,copy) CYPReverseBlock cyp_reserveValue;

@end
