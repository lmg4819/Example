//
//  Capture1.m
//  Example0
//
//  Created by lmg on 2018/10/11.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture1.h"

@implementation Capture1
/*
 函数调用和消息结构的区别：
 使用消息结构的语言，运行时所应执行的代码由运行环境来决定；而是用函数调用的语言，则由编译器来决定
 
 
 Objective-C的运行期组件的作用：
 Objective-C的重要工作都由运行期组件而非编译器来完成。使用Objective-C的面相对象所需的全部数据结构
 及函数都在运行期组件里面。举例来说，运行期组件中含有全部内存管理方法。运行期组件本质上就是一种与开发者
 所编代码相链接的动态库，其代码能把开发者编写的所有程序粘和起来。这样的话，只需更新运行期组件，即可提升
 应用程序性能，而无需重新编译应用程序代码。
 
 
 Objective-C将堆内存管理抽象出来了，不需要用malloc及free来分配或者释放对象所占内存，Objective-C运行期环境将这部分工作抽象为一套内存管理架构，叫做引用计数。
 
 Objective-C为何会使用结构体
 与创建结构体相比，创建对象还需要额外开销，例如分配及释放堆内存等，如果只需保存int，float,double,char等非对象类型，那么通常使用CGRect这种结构体就可以了
 
 
 */
@end
