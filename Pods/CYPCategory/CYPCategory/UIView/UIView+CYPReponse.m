//
//  UIView+Common.m
//  CarEasyBuy
//
//  Created by 马敬龙 on 16/6/15.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import "UIView+CYPReponse.h"

@implementation UIView (CYPReponse)

//获取上一级控制器
- (UIViewController *)firstReponseViewController {
    
    //通过响应者链，取得此视图所在的视图控制器
    UIResponder *next = self.nextResponder;
    do {
        
        //判断响应者对象是否是视图控制器类型
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    }while(next != nil);
    
    return nil;
}

- (UINavigationController *)cyp_responeNavigationController
{
    return [self firstReponseViewController].navigationController;
}

@end
