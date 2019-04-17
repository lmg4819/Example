//
//  UIViewController+EOCDealloc.m
//  Example0
//
//  Created by lmg on 2019/4/12.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "UIViewController+EOCDealloc.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIViewController (EOCDealloc)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method swizzleMethod = class_getInstanceMethod(self, @selector(js_viewWillAppear:));
        method_exchangeImplementations(originalMethod, swizzleMethod);
        
        
        Method originalMethod1 = class_getInstanceMethod(self, @selector(viewDidDisappear:));
        Method swizzleMethod1 = class_getInstanceMethod(self, @selector(js_viewDidDisappear:));
        BOOL success = class_addMethod(self, @selector(viewDidDisappear:), method_getImplementation(swizzleMethod1), method_getTypeEncoding(swizzleMethod1));
        if (success) {
            class_replaceMethod(self, @selector(js_viewDidDisappear:), method_getImplementation(originalMethod1), method_getTypeEncoding(originalMethod1));
        } else {
            method_exchangeImplementations(originalMethod1, swizzleMethod1);
        }
       
        
        Method originalMethod2 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
        Method swizzleMethod2 = class_getInstanceMethod(self, NSSelectorFromString(@"js_dealloc"));
        method_exchangeImplementations(originalMethod2, swizzleMethod2);
    });
}

- (void)js_dealloc
{
    if (![self isKindOfClass:[UINavigationController class]] && ![self isKindOfClass:[UITabBarController class]]) {
        NSLog(@"----%@----%s",[self class],__func__);
    }
    [ self js_dealloc];
}

- (void)js_viewWillAppear:(BOOL)animated
{
    [self js_viewWillAppear:animated];
    if (![self isKindOfClass:[UINavigationController class]] && ![self isKindOfClass:[UITabBarController class]]) {
        NSLog(@"----%@----%s",[self class],__func__);
    }

}

- (void)js_viewDidDisappear:(BOOL)animated
{
    [self js_viewDidDisappear:animated];
    if (![self isKindOfClass:[UINavigationController class]] && ![self isKindOfClass:[UITabBarController class]]) {
        NSLog(@"----%@----%s",[self class],__func__);
    }
}



@end
