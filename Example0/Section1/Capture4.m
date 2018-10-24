
//
//  Capture4.m
//  Example0
//
//  Created by lmg on 2018/10/11.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture4.h"
#define ANIMATION_DURATION 0.3

NSString *const EOCStringConstant = @"EOCStringConstant";
static const NSTimeInterval kAnimationDuration = 0.3;

@implementation Capture4
/*
 类型常量为何同时要用static和const来声明：
 如果视图改变由const修饰符所声明的变量，那么编译器就会报错。而static修饰符则意味着该变量仅在定义该变量的
 编译单元中可见，是为了限定变量的作用域。实际上，如果一个变量既声明为static，又声明为const，那么编译器根本不会创建符号，而是会像#define预处理指令一样，把所有遇到的变量都替换为常值。不过这种方式定义的常量带有类型信息。
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.不要用预处理指令定义常量。这样定义出来的常量不含类型信息，编译器只是会在编译前据此执行查找和替换操作。这样即使有人重新定义了常量值，编译器也不会产生警告信息，这将导致应用程序中的常量值不一致。
 
 2.在实现文件中使用static const来定义“只在编译单元内可见的常量”。由于此类常量不在全局变量符号表中，所以无须为其名称加前缀。
 
 3.在头文件中使用external来声明全局常量，并在相关实现文件中定义其值。这种常量要出现在全局符号表中，所以其名称应加以区隔，通常用与之相关的类名做前缀。
 
 
 */
@end
