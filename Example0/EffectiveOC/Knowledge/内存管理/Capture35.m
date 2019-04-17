//
//  Capture35.m
//  Example0
//
//  Created by lmg on 2018/10/18.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture35.h"
#import <objc/runtime.h>

@implementation Capture35
/*
 NSZombieEnabled:
 NSZombieEnabled变量用来调试与内存相关的问题，跟踪对象的释放过程。启用了NSZombieEnabled，它会用一个僵尸来替换默认的dealloc实现，也就是在引用计数降为0时，该僵尸实现会将该对象装换为僵尸对象。僵尸对象的作用是在你向它发送消息时，它会显示一段日志并自动跳入调试器。启用NSZombieEnabled而不是让程序直接崩溃掉时，一个错误的内存访问将会变成一条无法识别的消息发送给僵尸对象。僵尸对象会显示接受到消息，然后跳入调试器，这样你就可以查看问题到底处在哪里。
 为什么不默认开启NSZombieEnabled：
 因为一旦开启，每次通过指针访问对象的时候，都回去检查指针指向的对象是否为僵尸对象。所以会影响程序的执行效率，所以关闭。
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.系统在回收对象时，可以不将其真的回收，而将其转化为僵尸对象。通过环境变量NSZombieEnabled可以开启此功能。
 2.系统会修改对象的isa指针，使其指向特殊的僵尸类，从而使该对象变为僵尸对象。僵尸类能够响应所有的选择子，响应方式为：打印一条包含消息内容及其接收者的消息，然后终止应用程序。
 
 
 
 */

/*
-(void)dealloc
{
    //obtain the class of the object being deallocated
    Class cls = object_getClass(self);
    
    //get the class name
    const char *className = class_getName(cls);
    
    //Prepend _NSZombie_ to the class name
    const char *zombieClassName = "_NSZombie_" + className;
    
    //see if the specific zombie class exists
    Class zombieClass = class_lookupClass(zombieClassName);
    
    //if the specific zombie class doesn't exists, then it need to be created
    if (!zombieClass) {
        
        //obtain the template zombie class called _NSZombie_
        Class baseZombieCls = class_lookupClass("_NSZombie_");
        
        //duplicate the base zombie class,where the new class's name is the prepended string from above
        zombieClass = objc_duplicateClass(baseZombieCls, zombieClassName, 0);
        
    }

    //perform normal destruction of the object being deallocated
    objc_destructInstance(self);
    
    //set the class of the object being deallocated to the zombie class
    object_setClass(self, zombieClass);
    
    //the class of self is now _NSZombie_OriginalClass;
}
*/
@end
