//
//  CYPBaseScrollView.m
//  CarEasyBuy
//
//  Created by wlj on 2017/5/9.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYPBaseScrollView.h"

@implementation CYPBaseScrollView

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([self panBack:gestureRecognizer]) {
        return NO;
    }
    return YES;
    
}

- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state || UIGestureRecognizerStatePossible == state) {
            CGPoint location = [gestureRecognizer locationInView:self];
            if (point.x > 0 && location.x < 100 && self.contentOffset.x <= 0) {
                return YES;
            }
        }
    }
    return NO;
}

@end
