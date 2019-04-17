//
//  面试题总结.h
//  Example0
//
//  Created by 罗孟歌 on 2019/4/17.
//  Copyright © 2019 lmg. All rights reserved.
//

#ifndef ______h
#define ______h
1.设计模式是什么，你知道哪些设计模式，并简要概述
设计模式是一种编码经验，就是用比较成熟的逻辑去处理某一种类型的事情
iOS中常用的设计模式：
单利模式：通知中心，文件管理器，NSUserDefault
观察者模式：KVO，通知
委托模式：代理
中介者模式：URLRouter
工厂模式：UIButton
MVC模式：
MVVM模式：

2.MVC与MVVM的区别
MVC是Model View Controller
MVVM是Model View（View+Controller）VM（Controller中的业务逻辑和页面展示逻辑），是对Massive MVC的一种优化


3.#import和#include有什么区别
#import是OC导入头文件的关键字，#include是C/C++导入头文件的关键字
#import可以防止重复导入头文件
@class向前声明，告诉编译器某个类的声明，只有到了执行时，才会去查看类的实现文件，可以解决头文件的相互包含
#import<>用来包含系统头文件，#import“”用来导入用户头文件

4.frame和bounds的区别
frame是在父View中的相对坐标，bounds是自身的坐标

5.Objective-C的类可以多重继承么？可以实现多个接口么？Category是什么？重写一个类的方法用继承好还是分类好？为什么？
不可以，使用协议，分类，分类好，用分类去重写类的方法，仅对本category有效，不会影响本类与其他类的关系

6、@property 的本质是什么？ivar、getter、setter 是如何生成并添加到这个类中的
ivar+getter+setter
编译器在编译器编写这些访问方法和生成对应的实例变量

7.@property中有哪些属性关键字？/ @property 后面可以有哪些修饰符？
1.原子性--- nonatomic 特质
2.读/写权限---readwrite(读写)、readonly (只读)
3.内存管理语义---assign、strong、 weak、unsafe_unretained、copy
4.方法名---getter= 、setter=
5.nonnull,nullable

8.属性关键字 readwrite，readonly，assign，retain，copy，nonatomic 各是什么作用，在那种情况下用？
1.readwrite可读可写，会自动生成setter和getter方法
2.readonly只读，只会生成getter方法
3.assign,赋值用于基本数据类型
4.string，持有，强引用
5.weak，弱引用，非拥有关系，用于对象，对象被销毁后，会自动置为nil
6.copy，复制
7.nonatomic，atomic和nonatomic的区别在于，系统自动生成的getter/setter方法不一样，对于atomic的属性，
系统生成的set/get方法会保证set、get操作的完整性，而nonatomic就没有这个保证了，所以nonatomic的运行速度更快，
不过atomic不能保证线程安全
8.atomic

9.什么情况使用 weak 关键字，相比 assign 有什么不同？
weak是用来解决循环引用的，assing可以用于普通数据类型，weak只能用于OC对象，
weak指向的对象销毁时，会自动置为nil

10.怎么用 copy 关键字？
NSString、NSArray、NSDictionary 等等经常使用copy关键字，是因为他们有对应的可变类型：NSMutableString、NSMutableArray、NSMutableDictionary；
block 也经常使用 copy 关键字

11.用@property声明的 NSString / NSArray / NSDictionary 经常使用 copy 关键字，为什么？如果改用strong关键字，可能造成什么问题？
使用copy的目的是为了防止把可变类型的对象赋值给不可变类型的对象时，可变类型的值发生改变会无意间篡改不可变对象的值


12.浅拷贝和深拷贝的区别？
深拷贝拷贝对象
浅拷贝拷贝指针


13.系统对象的 copy 与 mutableCopy 方法
copy返回的是不可变对象
mutableCopy返回的是可变对象类型
只有对不可变的对象进行copy才是浅拷贝，其他都是深拷贝

14.这个写法会出什么问题：@property (nonatomic, copy) NSMutableArray *arr;
应该用strong来修饰，并在赋值时对对象进行mutableCopy

15.如何让自己的类用 copy 修饰符？如何重写带 copy 关键字的 setter？
使自己的类遵从NSCopying协议，并实现copyWithZone方法


16.@synthesize 和 @dynamic 分别有什么作用？
@synthesize自动合成，@dynamic告诉编译器不自动生成，由用户手动实现


17.常见的 Objective-C 的数据类型有那些，和C的基本数据类型有什么区别？如：NSInteger和int
Objective-C的数据类型有NSString，NSNumber，NSArray，NSMutableArray，NSData等等，这些都是class，创建后便是对象，而C语言的基本数据类型int，只是一定字节的内存空间，用于存放数值;NSInteger是基本数据类型，并不是NSNumber的子类，当然也不是NSObject的子类。NSInteger是基本数据类型Int或者Long的别名(NSInteger的定义typedef long NSInteger)，它的区别在于，NSInteger会根据系统是32位还是64位来决定是本身是int还是long。

18.id 声明的对象有什么特性？
id声明的对象具有运行时的特性，即可以指向任何类型的OC对象

19.Objective-C 如何对内存管理的，说说你的看法和解决方法
1.ARC
2.MRR/MRC
3.自动释放池，自动释放池受RunLoop影响

20.Objective-C 中创建线程的方法是什么？如果在主线程中执行代码，方法是什么？如果想延时执行代码、方法又是什么？

21.Category（类别）、 Extension（扩展）和继承的区别
区别：
1.分类有名字，扩展没有名字，扩展是匿名的分类
2.分类只能声明方法。类扩展可以扩展属性，成员变量和方法
3.继承可以增加删除修改方法，并且可以增加属性

22.我们说的OC是动态运行时语言是什么意思？
主要是将数据类型的确定有编译器，推到了运行时，直到运行时才去决定一个对象的类别，以及调用该类别对象对象指定方法。


23.为什么我们常见的delegate属性都用是week而不是retain/strong？
避免循环引用


24.什么时候用delegate，什么时候用Notification？
delegate1对1，notification1对多


25.什么是 KVO 和 KVC？
KVC编制编码模式，提供了一种通过字符串间接访问对象的方式
KVO键值观察模式，KVO只能被KVC触发


26.KVC的底层实现？
1.当一个对象调用setValue方法时，检查是否存在对应的key的set方法，如果存在就去实现
2.如果set方法不存在，就会查找与Key同名并且带下划线的成员变量，如果有，则直接给成员变量赋值
3.如果没有找到_key，就会查找isKey等相同名称的属性，如果有就直接辅助
4.如果还没有找到，则调用valueForUndefinedKey方法抛出异常


27.KVO的底层实现？
如果一个对象A被注册为被观察者，在运行时会动态生成一个派生类，名为NSKeyValueObserver_A,并重写该类被观察属性的set方法
- （void）setName：（NSString *）name{
    [self willChangeValueForKey:];
    _name = name;
    [self didChangeValueForKey:];
}

28.ViewController生命周期
1.initWithCoder
2.awakeFrameNib
3.loadView
4.Viewdidload
5.viewWillAppear
6.updateViewConstraints
7.viewWillLayoutSubViews
8.viewDidLayoutSubViews
9.viewDidAppear
10.viewWillDisappear
11.viewDidDisappear

29.方法和选择器有何不同？
选择器是方法的名字，方法是一个组合体，包含了名字和实现


30.你是否接触过OC中的反射机制？简单聊一下概念和使用
class反射
SEL的反射

31.调用方法有两种方式：
1.[obj func];
2.[obj performSelector];
3.objc_msgSend;

32.如何对iOS设备进行性能测试？
instrument-->Time Profile


33.开发项目时你是怎么检查内存泄露？
1.静态分析
2.instruments-->leaks
3.腾讯的MLeaksFinder


34.什么是懒加载？
懒加载就是只在用到的时候才去初始化。也可以理解成延时加载。


35.类变量的 @public，@protected，@private，@package 声明各有什么含义？
@protected，默认，该类和子类都可以访问
@private，只能在该类访问
@public，如何地方都能访问
@package ，本包内可以访问，跨包不可以


36.什么是谓词？
谓词就是通过NSPredicate给定的逻辑条件作为约束条件,完成对数据的筛选


37.isa指针问题
指向Class的指针


38.如何访问并修改一个类的私有属性？
1.KVC
2.通过Runtime访问并修改私有属性

39.一个objc对象的isa的指针指向什么？有什么作用？
指向它的类对象，从而找到对象上的方法


40.isKindOfClass、isMemberOfClass、selector作用分别是什么
isKindOfClass：作用是某个对象属于某个类型或者继承自某类型。
isMemberOfClass：某个对象确切属于某个类型。



41.delegate 和 notification 的区别
1. 二者都用于传递消息，不同之处主要在于一个是一对一的，另一个是一对多的。
2.delegate需要两者之间建立关系，不然没法调用代理的方法，notification不需要两者之间建立关系


42.什么是block？
闭包，包含其他函数局部变量的匿名函数

43.BAD_ACCESS在什么情况下出现？
原因是访问了野指针，比如访问已经释放对象的成员变量，或者发消息，死循环等


44.lldb（gdb）常用的控制台调试命令
po


45.你一般是怎么用Instruments的？
1.Time Profiler: 性能分析
2.Zombies：检查是否访问了僵尸对象
3.Allocations：用来检查内存
4.Leaks：检查内存，看是否有内存泄露

46.iOS中常用的数据存储方式有哪些？
NSUserDefault,KeyChain,File,DB
File:Plist,NSKeyedArchive
DB:sqlite,FMDB,CoreData


47.iOS的沙盒目录结构是怎样的？
1.Documents 存储用户数据，数据库
2.Library  Preferences：程序的偏好设置 Caches：存储文件
3.tmp  临时文件



48.iOS多线程技术有哪几种方式？
NSThread,GCD,NSOperationQueue,pthread


49.GCD 与 NSOperation 的区别：

50.如何用GCD同步若干个异步调用？（如根据若干个url异步加载多张图片，然后在都下载完成后合成一张整图）
使用dispatch_group 和dispatch_group_notify

51.dispatch_barrier_async（栅栏函数）的作用是什么？
1.在它前面的任务需要执行完成才能执行他，后面的任务需要等它执行完后才能开始
2.避免数据竞争


52.什么是 RunLoop


53.说说你对 runtime 的理解


54.Runtime实现的机制是什么，怎么用，一般用于干嘛？


55.什么是 Method Swizzle（黑魔法），什么情况下会使用？


56._objc_msgForward 函数是做什么的，直接调用它将会发生什么？


57.什么是 TCP / UDP ?


58.通信底层原理（OSI七层模型）
物理层，数据链路层，网络层，传输层，会话层，表示层，应用层


59.介绍一下XMPP？


60.OC中创建线程的方法是什么？如果在主线程中执行代码，方法是什么？


61.tableView的重用机制？
UITableView通过重用机制来节省内存，为每一个单元格指定一个重用标识符，即指定了单元格的种类，当单元格滑出屏幕时，
系统会把这个单元格添加到重用对列中，等待被重用，当有新单元格从屏幕外划入屏幕时，从重用对列中找看有没有可重用的单元格
，如果有，就拿出来用，如果没有就创建一个来使用


62.在手势对象基础类UIGestureRecognizer的常用子类手势类型中哪两个手势发生后，响应只会执行一次？
tap和swipe


63.如何高性能的给 UIImageView 加个圆角
使用绘图技术



64.HTTP协议中 POST 方法和 GET 方法有那些区别?


65.请简单的介绍下APNS发送系统消息的机制



66. ios开发逆向传值的几种方法整理
1.代理
2.block
3.通知
4.单利
5.KVO



67.浅谈iOS开发中方法延迟执行的几种方式
1.performSelector
2.NSTimer
3.GCD
4.NSThread线程的sleep


68.您是否做过一部的网络处理和通讯方面的工作？如果有，能具体介绍一下实现策略么?
1.使用NSOperation发送一部网络请求，NSOperationQueue管理线程数目和优先级，底层用NSUrlSession

69.你使用过Objective-C的运行时编程（Runtime Programming）么？如果使用过，你用它做了什么？你还能记得你所使用的相关的头文件或者某些方法的名称吗？
#import<objc/runtime.h>
#import<objc/messahe.h>

70.Core开头的系列的内容。是否使用过CoreAnimation和CoreGraphics。UI框架和CA，CG框架的联系是什么？
分别用CA和CG做过些什么动画或者图像上的内容。（有需要的话还可以涉及Quartz的一些内容）
UI框架的底层有CoreAnimation，CoreAnimation的底层有CoreGraphics。

71.是否使用过CoreText或者CoreImage等？如果使用过，请谈谈你使用CoreText或者CoreImage的体验。
CoreText可以解决复杂文字内容排版问题。CoreImage可以处理图片，为其添加各种效果

72.自动释放池是什么,如何工作



73.你用过NSOperationQueue么？如果用过或者了解的话，你为什么要使用NSOperationQueue，
实现了什么？请描述它和G.C.D的区别和类似的地方（提示：可以从两者的实现机制和适用范围来描述）。


74。对于Objective-C，你认为它最大的优点和最大的不足是什么？对于不足之处，现在有没有可用的方法绕过这些不足来实现需求。
如果可以的话，你有没有考虑或者实践过重新实现OC的一些功能，如果有，具体会如何做？

75。你实现过一个框架或者库以供别人使用么？如果有，请谈一谈构建框架或者库时候的经验；如果没有，请设想和设计框架的public的API，并指出大概需要如何做、需要注意一些什么方面，来使别人容易地使用你的框架。


76.AFNetworking 底层原理分析

77.描述下SDWebImage里面给UIImageView加载图片的逻辑

78.不用中间变量,用两种方法交换A和B的值


79.求最大公约数

80.模拟栈操作

81.排序算法

82.折半查找


83.在项目什么时候选择使用GCD，什么时候选择NSOperation?

84.KVO，NSNotification，delegate及block区别

85.NSTimer创建后，会在哪个线程运行
用scheduledTimerWithTimeInterval创建的，在哪个线程创建就会被加入哪个线程的RunLoop中就运行在哪个线程
自己创建的Timer，加入到哪个线程的RunLoop中就运行在哪个线程。

86.id和NSObject＊的区别



87.static关键字的作用

https://blog.csdn.net/wujakf/article/details/80229148

#endif /* ______h */
