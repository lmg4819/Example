
//
//  面试题回顾.h
//  Example0
//
//  Created by 罗孟歌 on 2019/4/16.
//  Copyright © 2019 lmg. All rights reserved.
//

#ifndef ______h
#define ______h

1.风格纠错题

2.什么时候使用weak，什么时候使用assign，有什么区别
修饰弱引用对象的时候用weak，修饰一般数据类型使用assign，都是简单的赋值操作，不保留对象，但是weak修饰的对象
被释放是，指针会自动置为nil。weak只能用来修饰对象，assign可以用来修饰一般数据类型（非对象）

3.怎么用copy关键字
1.NSString，NSArray，NSDictionary等经常使用copy修饰，因为它们有对应的可变类型NSMutableString，NSMutableArray，NSMutableDictionary
2.block经常用copy修饰

4.这个写法会出现什么问题@property （copy）NSMutableArray *array
此写法等同于NSMutableArray *temparray = [NSMutableArray array];
array = [temparray copy];
array为不可变对象，当对对象进行增删操作时会crash，应该用strong修饰，并在赋值时进行mutableCopy，最好再加上nonatomic

5.如何让自己的类拥有copy修饰符，如何重写copy关键字的setter方法
声明该类遵从NSCopying协议，并实现copyWithZone方法
-（void）setName:(NSString *)name
{
    _name = [name copy];
}

6.@property的本质是什么，ivar，get，set是如何生成并添加到这个类的
@property的本质是ivar+get+set
完成属性定义后，编译器编写访问这些属性所用的方法，此过程叫做自动合成。这个过程由编译器在编译期完成。此外，可以使用@synthesize来指定生成的成员变量名

7.@protocol和category中如何使用@property
·在@protocol中声明属性，只会生成对应的set，get方法，我们的目的是为了让遵从这个协议的对象能实现该属性
·在category中声明属性，也是只会生成对应的set，get方法，如果我们真的需要给category增加属性的实现，我们可以使用Runtime的两个函数来实现

8.runtime如何实现weak属性
weak此特质表明了一种非拥有关系
runtime如何实现weak的自动置空：
runtime对注册的类会进行布局，对于weak对象会放入一个hash表中。用weak所指向的对象的内存地址作为key，当此对象的引用计数为0时，对象会dealloc，假如weak指向的地址为a，
那么就以a为key，找到所有以a为键的对象，从而设置为nil。

9.@property都有哪些修饰符
atomic/nonatomic
strong/weak/assign/copy/unsafe_unretainde
readonly/readwrite
setter/getter


10.weak属性需要在dealloc中置为nil吗
不需要，在属性所指向的对象被销毁时，属性值也会被置为nil

11.@synthesize和@dynamic有什么不同
使用@synthesizer，你可以自定义属性对应的成员变量名
使用@dynamic可以禁止编译器自动合成属性


12.ARC下，不显式的指定属性关键字时，默认的属性有哪些
strong，atomic，assign,readwrite

13.NSString用copy修饰而不用strong修饰的原因
NSString拥有子类NSMutableString，指向NSString的指针可以指向NSMutableString，当使用strong修饰时，指向的可能是一个可变字符串，
如果我们在后面修改了这个字符串，可能会出现意想不到的意外。使用copy修饰时，会生成一个不可变的副本

14.@synthesize合成实例变量的规则是什么，加入property名为foo，已经存在了_foo的实例变量，还会自动合成新变量吗
默认为属性值加下划线，如果指定了新的则用指定的名字作为属性的实例变量，不会再合成了


15.在有了自动合成属性实例变量以后，@synthesize还有哪些使用场景
1.在protocol中声明的属性
2.在category中声明的属性
3.用@dynamic
4.同时重写了set和get方法
5，重写了只读属性的get方法时
这些情况下都需要你使用@synthesize手动合成ivar，另外还可以改变属性实例变量名

16.objc中向一个nil对象发送消息会发生什么
nil对象的isa指针会返回0，不会产生任何错误

17.objc中向一个对象发送消息[obj foo]和objc_msgsend()函数之间有什么关系
该方法编译时候就是objc_msgsend()函数调用

18.什么时候会报unrecognizer selector错误
走完消息传递的流程和消息转发的流程都找不到对应的方法时就会报这个错误

消息传递的过程：
1.根据对象的isa指针找到对象所属的类，在类的方法缓存中寻找SEL，如果找到就去实现，找不到走下一步
2.在类的方法列表中找，找到了就去实现，并把方法加入到该类的方法缓存中去，找不到走下一步
3.在类的父类方法列表中找，一直到NSObject类为止，如果能找到就去实现，找不到就走消息转发的流程

消息转发的流程：
1.动态方法加载objc运行时会调用resolveInstanceMethod或者resolveClassMethod让你动态添加方法
2.forwardingTargetForSelector返回备援接受者
3.走完整的消息转发流程，首先会调用methodSignatureForSelector获取方法的参数和返回值类型，如果该方法返回nil，
那么程序会调用doesNotRecognizeSelector,如果返回了NSMethodSignature，runtime就会创建一个函数签名并调用forwardInvocation，
如果forwardInvocation返回nil，这是也会调用doesNotRecognizeSelector

19.一个objc对象如何进行内存布局

isa指针
根类的实例变量
...
父类的实例变量
类的实例变量


20.一个objc对象的isa指针指向什么，起什么作用
指向对象的类，从而找到类的方法

21.下面的代码输出什么
@implementation Son : Father
- (id)init
{
self = [super init];
if (self) {
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@", NSStringFromClass([super class]));
}
return self;
}
@end
Son Son


22.runtime如何通过selector找到对应的IMP实现
每一个类对象中都有一个方法列表，方法列表记载着方法的名称，实现，以及参数和返回值，
selector的本质就是方法名，通过这个名称在方法列表中就可以找到对应的方法实现


23.使用runtime associate关联的对象，需要在主对象dealloc的时候释放吗
不需要


24.OC的类方法和实例方法本质上有什么区别和联系
1.类方法是属于类对象的/实例方法是属于实例对象的
2.类方法只能通过类对象调用/实例方法只能通过实例对象调用
3.类方法中的self是类对象/实例方法中的self是实例对象
4.类方法可以调用其他的类方法/实例方法中可以访问成员变量
5.类方法中不能访问成员变量/实例方法中直接调用实例方法
6.类方法中不能直接调用对象方法/实例方法中也可以调用类方法(通过类名)


25.objc_msgForward()是做什么用的，直接调用它会发生什么
objc_msgForward是做消息转发的，当向一个对象发送消息，这个对象并没有实现的时候，_objc_msgForward会
尝试做消息转发，一旦调用了这个函数，会跳过消息传递的过程，直接走消息转发，及时实现了方法也不行
什么时候会使用objc_msgForward方法
1.你想获取某方法对应的方法签名时
2.JSPatch 就是直接调用_objc_msgForward来实现其核心功能的
3.同时 RAC(ReactiveCocoa) 源码中也用到了该方法


26.能都向编译后得到的类中增加实例变量，能否向运行时动态添加的类中增加实例变量，为什么
不能，能
原因，编译后的类注册在Runtime中，类的实例变量链表和实例变量的内存大小都是确定的
运行时创建的类可以通过class_addIvar增加实例变量，但是必须要在objc_allocateClassPair和objc_registerClassPair之间

27.RunLoop和线程之间有什么关系
1.RunLoop和线程是一一对应的，RunLoop是线程的基础架构部分，有一个全局字典存储了RunLoop，以线程为key，而
value为对应的RunLoop
2.主线程的RunLoop默认是启动的
3.子线程的RunLoop默认是不启动的，当你获取的时候会自动创建，并存储字典，当线程被销毁的时候，RunLoop也会被销毁
4.CFRunLoopGetCurrent来获取当前线程的Runloop，CFRunLoopGetMain来获取主线程的RunLoop

28.RunLoop的mode作用是什么
mode主要是用来指定事件在运行循环中的优先级，分为
NSDefaultRunLoopMode：默认优先级
UITrackingRunLoopMode，ScrollView滑动时
UIInitializationRunLoopMode，应用启动时
NSRunLoopCommonModes：前两个的集合，是一种标记
苹果公开提供的mode有两个：NSDefaultRunLoopMode，NSRunLoopCommonModes

29.以scheduledTimerWithTimeInterval的方式触发的NSTimer在滑动页面的列表时，Timer会暂停回调，为什么
RunLoop只能运行在一种mode下，scheduledTimerWithTimeInterval创建的Timer默认会添加在NSDefaultRunLoopMode
中，当UIScrollView滑动时，当前mode被切换成UITrackingRunLoopMode，此时RunLoop会停下重新启动，无法再执行NSTimer，
可以将NSTimer添加到NSRunLoopCommonModes解决这个问题

30.猜想RunLoop内部是如何实现的
function (){
    do{
        var message = get_next_message
        process_message(messgae)
    }while(message != quit)
}

31.objc通过什么机制来进行内存管理
ARC（自动引用计数），通过retainCount来决定对象是否应该被释放，每次RunLoop的时候，都会检查对象的retainCount,当对象的引用计数为0时，调用dealloc方法释放对象。


32.ARC通过什么方式帮助开发者管理内存




#endif /* ______h */
