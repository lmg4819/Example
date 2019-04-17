//
//  Capture6.m
//  Example0
//
//  Created by lmg on 2018/10/11.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture6.h"

@implementation Capture6
/*
 原子性：
 atomic(默认) nonatomic
 
 atomic和nonatomic的区别
 1.atomic和nonatomic用来决定编译器生成的setter和getter是否为原子操作。
 2.atomic会对setter和getter方法加锁，所说的线程安全只是保证了getter和setter方法的线程安全，并不能保证整个对象是线程安全的
 3.nonatomic返回你的对象可能不是完整的value。因此多线程的环境下原子操作是有必要的，否则有可能会引起错误的结果，但是仅仅使用atomic并不会使得对象线程安全，我们还要为对象线程提供lock来确保线程的安全。
 4.nonatomic的速度要比atomic的快
 5.atomic与nonatomic的本质区别其实也就是在setter方法上的操作不同
 
 
 
 读写权限：
 readwrite(默认) readonly
 
 
 内存管理语义：
 assign(默认，基本数据类型)
 strong(默认,对象)
 weak
 unsafe_unretained
 copy
 
 方法名：
 setter getter
 
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.使用@property来定义对象中所封装的数据。
 2.通过“特质”来指定存储数据所需的正确语义。
 3.在设置属性所对应的实例变量时，一定要遵从该属性所声明的语义。
 4.开发ios程序时应该使用nonatomic属性，因为atomic会严重影响性能。
 
 */
@end
