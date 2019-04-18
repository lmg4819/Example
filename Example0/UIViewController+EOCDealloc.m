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

//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
//        Method swizzleMethod = class_getInstanceMethod(self, @selector(js_viewWillAppear:));
//        method_exchangeImplementations(originalMethod, swizzleMethod);
//        
//        
//        Method originalMethod1 = class_getInstanceMethod(self, @selector(viewDidDisappear:));
//        Method swizzleMethod1 = class_getInstanceMethod(self, @selector(js_viewDidDisappear:));
//        BOOL success = class_addMethod(self, @selector(viewDidDisappear:), method_getImplementation(swizzleMethod1), method_getTypeEncoding(swizzleMethod1));
//        if (success) {
//            class_replaceMethod(self, @selector(js_viewDidDisappear:), method_getImplementation(originalMethod1), method_getTypeEncoding(originalMethod1));
//        } else {
//            method_exchangeImplementations(originalMethod1, swizzleMethod1);
//        }
//       
//        
//        Method originalMethod2 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
//        Method swizzleMethod2 = class_getInstanceMethod(self, NSSelectorFromString(@"js_dealloc"));
//        method_exchangeImplementations(originalMethod2, swizzleMethod2);
//    });
//}
//
//- (void)js_dealloc
//{
//    if (![self isKindOfClass:[UINavigationController class]] && ![self isKindOfClass:[UITabBarController class]]) {
//        NSLog(@"----%@----%s",[self class],__func__);
//    }
//    [ self js_dealloc];
//}
//
//- (void)js_viewWillAppear:(BOOL)animated
//{
//    [self js_viewWillAppear:animated];
//    if (![self isKindOfClass:[UINavigationController class]] && ![self isKindOfClass:[UITabBarController class]]) {
//        NSLog(@"----%@----%s",[self class],__func__);
//    }
//
//}
//
//- (void)js_viewDidDisappear:(BOOL)animated
//{
//    [self js_viewDidDisappear:animated];
//    if (![self isKindOfClass:[UINavigationController class]] && ![self isKindOfClass:[UITabBarController class]]) {
//        NSLog(@"----%@----%s",[self class],__func__);
//    }
//}



@end
/*
 同步执行和异步执行的区别，是否等待队列的任务执行结束，以及是否具备开启新线程的能力。
 
 同步执行：不创建新线程，只能在现有线程执行任务
 异步执行：虽然具有开启新线程的能力，但是并不一定创建新线程，这和任务所指定的队列类型有关
 
 
 串行队列和并发队列，两者都符合先进先出的原则，两者的主要区别是，执行顺序不同，以及线程开启数不同。
 串行队列：队列中的任务一个接着一个，要等前一个任务完成，下一个任务才可以开始，只开启一个线程
 特殊的串行队列：主队列（只有一条线程，主线程）
 
 并行队列：队列中的任务可以同时进行，可以开启多个线程，并且同时执行任务
 全局队列：创建一条或者多条线程
 
 
 《并发队列的并发功能只有在异步函数下才有效》
 
 我们有两种队列（同步队列/异步队列），两种任务执行方式（同步执行/异步执行），就有了四种不同的组合方式
 
 
 1.同步执行+串行队列：不创建新队列，串行执行任务
 2.同步执行+主队列：主线程调用，死锁卡住不执行；其他线程调用，没有开启新线程，串行执行任务
 3.同步执行+并行队列：不创建新线程，串行执行任务
 4.异步执行+串行队列：创建一条新线程，串行执行任务
 5.异步执行+主队列：没有开启新线程，串行执行任务
 6.异步执行+并行队列：创建新线程，并发执行任务
 
 
 
 
 
 */
