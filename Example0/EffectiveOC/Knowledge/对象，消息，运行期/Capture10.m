//
//  Capture10.m
//  Example0
//
//  Created by lmg on 2018/10/12.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture10.h"
#import <objc/runtime.h>

@implementation Capture10

-(instancetype)init
{
    self = [super init];
    if (self) {
        /*
         OBJC_ASSOCIATION_ASSIGN             assign
         OBJC_ASSOCIATION_RETAIN_NONATOMIC   retain nonatomic
         OBJC_ASSOCIATION_COPY_NONATOMIC     copy  nonatomic
         OBJC_ASSOCIATION_RETAIN             retain
         OBJC_ASSOCIATION_COPY               copy
         */
       
    }
    return self;
}
/*
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.可以通过关联对象机制来把两个对象连起来。
 2.定义关联对象时可以指定内存管理语义，用以模仿定义属性时所采用的拥有关系和非拥有关系
 3.只有在其他做法不可行时才应选用关联对象，因为这种做法通常会引入难以解决的bug
 
 */
@end
