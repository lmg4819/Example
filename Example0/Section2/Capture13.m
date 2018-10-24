//
//  Capture13.m
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture13.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Capture13

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
        Method swappedMethod  = class_getInstanceMethod([NSString class], @selector(uppercaseString));
        
        method_exchangeImplementations(originalMethod, swappedMethod);
    });
}
/*
 id (*IMP) (id, SEL, ...)
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.在运行期，可以向类中新增或替换选择子所对应的方法实现。
 2.使用另一份实现来替换原有的方法实现，这道工序叫做方法调配，开发者常用此技术向原有实现中增加新功能。
 3.一般来说，只有调试程序的时候才需要在运行期修改方法实现，这种做法不易滥用。
 
 
 */
@end
