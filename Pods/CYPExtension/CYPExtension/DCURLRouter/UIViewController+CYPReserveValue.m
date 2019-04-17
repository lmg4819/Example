//
//  UIViewController+CYPReserveValue.m
//  CarEasyBuy
//
//  Created by songhh on 2017/7/18.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import "UIViewController+CYPReserveValue.h"
#import <objc/message.h>

static char *cypreverseBlockKey = "cypreverseBlockKey";

@implementation UIViewController (CYPReserveValue)

-(CYPReverseBlock)cyp_reserveValue
{
    return objc_getAssociatedObject(self, cypreverseBlockKey);
}

-(void)setCyp_reserveValue:(CYPReverseBlock)cyp_reserveValue
{
    objc_setAssociatedObject(self, cypreverseBlockKey, cyp_reserveValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
