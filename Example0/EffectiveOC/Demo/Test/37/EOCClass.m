//
//  EOCClass.m
//  Example0
//
//  Created by lmg on 2018/10/18.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCClass.h"
#import <objc/runtime.h>

@implementation EOCClass

void PrintClassInfo(id obj)
{
    Class cls = object_getClass(obj);
    Class superCls = class_getSuperclass(cls);
    NSLog(@"class:%s----superClass:%s",class_getName(cls),class_getName(superCls));
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        void (^block)();
        int index = 0;
        if (index) {
            block = ^{
                NSLog(@"AAAAAAAA");
            };
        }else
        {
            block = ^{
                NSLog(@"BBBBBBBB");
            } ;
        }
        
       block();
        
        
       /*
        块内存
        
        void *                   isa
        int                      flags
        int                      reserved
        void(*)(void *, ...)     invoke
        struct *                 description
              捕获到的变量
        
        
        struct （块描述符）
        unsigned long int        reserved
        unsigned long int        size
        void(*)(void *,void *)   copy
        void(*)(void *,void *)   dispose
        
    在内存布局中，最重要的就是invoke变量，这是个函数指针，指向块的代码实现。
    description变量是指向结构体的指针，每个块中都包含此结构体，其中声明了块对象的总体大小，还声明了copy和dispose这两个辅助函数所对应的函数指针。辅助函数在拷贝及丢弃快对象时运行，其中会执行一些操作，比方说：前者要保留捕获的对象，而后者则将其释放。
        
    块还会把所捕获的所有变量都拷贝一份。这些拷贝放在description变量后面，捕获了多少个变量，就要占据多少内存空间，请注意，拷贝的并不是对象本身，而是指向这些对象的指针变量。invoke函数为何要把块对象作为参数传进来呢？原因就在于，执行块时，要从内存中把这些捕获到的变量读出来。
        
        
        
        
        
        
        
        */
    }
    return self;
}


@end
