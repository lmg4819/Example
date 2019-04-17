//
//  Capture30.m
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture30.h"

@implementation Capture30
/*
 retain  release autorelease dealloc
 alloc new copy mutablecopy:方法返回的对象归调用者所有
 
 
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.有ARC之后，程序员就无需担心内存管理问题了。使用ARC来编程，可省去类中的许多样板编码。
 2.ARC管理对象生命期的办法基本上就是：在合适的地方插入保留及释放操作。在ARC环境下，变量的内存管理语义可以通过修饰符指明，而原来则需要手工执行保留及释放方法。
 3.有方法所返回的对象，其内存管理语义总是通过方法名来体现。ARC将其确定为开发者必须遵守的规则。
 4.ARC只负责管理Objective-C对象的内存。尤其要注意，CoreFoundation对象不归ARC管理，开发者必须适时调用CFRetain/CFRelease.
 
 */
@end
