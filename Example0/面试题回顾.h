
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

31.不手动指定autoreleasePool的情况下，一个autoreleasePool什么时候释放
1.所有的autorelease的对象，在出了作用域后，会被添加到最近创建的自动释放池中，并会在当前的RunLoop迭代结束时释放
2.从程序开始加载到加载完成是一个完整的事件循环，然后会停下来，等待用户交互，用户的每一次交互都会启动一次运行循环，来处理
用户所有的点击事件和触摸事件
3.viewDidLoad和viewWillAppear属于同一循环，ViewdidAppear时已经被释放了


32.BAD_ACCESS在什么时候会出现
1.野指针
2.死循环
3.访问一个已经释放了的对象的成员变量，或者发消息


33.苹果是如何实现autoreleasePool的


34.使用block什么时候会发生循环引用，如何结局？
一个对象强引用了block,block又强引用了这个对象，就会发生循环引用，使用__block或者__weak来修饰对象

35.在block内如何修改外部变量
__block,__block所起的作用就是标记某对象，把给对象的内存地址copy到堆上，然后再对其进行修改

36.使用系统的某些blockAPI时，是否需要考虑循环引用
一般不需要

37.GCD的队列（dispatch_queue_t）分哪两种类型
串行队列和并行队列

38.如何用GCD同步若干个异步调用？
dispatch_group_t

39.dispatch_barrier_async的作用是什么？
在并行队列中，为了保证某些任务的正常运行，需要等到一些任务完成后才能继续进行下去，使用
dispatch_barrier_async来等待之前任务完成，避免数据竞争等问题。


40.苹果为什么要废弃dispatch_get_current_queue()函数
dispatch_get_current_queuet容易造成死锁


41.以下代码执行结果如何
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}
发生主线程锁死

42.



#endif /* ______h */
/*
 1.tableView的优化
 2.Runtime
 3.HTTPS的加密过程
 4.weak底层原理
 5.两个独立的模块如何通信
 6.属性常用修饰词
 
 1.weak实现原理概括
 Runtime维护了一个weak表，用于存储指向某个对象的所有weak指针，weak变其实是一个hash表
 key是所指对象的地址，value是weak指针的地址数组，当对象的引用计数为0时，根据对象的地址，寻找到weak指针的数组，
 遍历数组，将其中的数据置为nil，然后把这个对象从weak表中删除，然后清理对象的记录
 
 
 2.tableView的优化
 1.正确的复用cell
 2.设计统一规格的cell
 3.提前计算并缓存好高度，因为heightForRowAtIndexPath是调用最频繁的方法
 4.遇到复杂界面时异步绘制
 5.减少子视图的层级关系
 6.尽量时所有的视图不透明化以及做切圆操作
 7.不要动态的add和remove，最好在初始化时加add，然后通过hidden来控制显示隐藏
 8.滑动时按需加载，这个在大量图片展示，网络加载的时候很管用
 9.使用调试工具分析问题
 
 3.Runtime
 1.消息发送机制和消息转发机制
 2.动态添加成员变量的时机
 3.为什么可以动态添加方法，而不可以动态添加成员变量
 4.category，extension的区别
 
 4.两个独立的模块如何通信
 URLRouter
 
 5.属性常用修饰词
 atomic/nonatomic
 strong/weak/copy/unsafe_unretained
 readonly/readwrite
 setter/getter
 
 6.HTTPS的加密过程
 1.客户端发起HTTPS连接请求，服务器返回证书（公钥）
 2.客户端产生随机对称秘钥
 3.使用公钥对对称秘钥加密
 4.发送加密后的秘钥（对称）给服务器
 5.服务器使用私钥进行解密，双方都拥有了对称秘钥
 6.双方通过堆成秘钥加密的密文通信
 
 
 
 */
