//
//  AppDelegate.h
//  Example0
//
//  Created by lmg on 2018/9/10.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ISIphoneXS ((AppDelegate *)[UIApplication sharedApplication].delegate).isIphonex




@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign) BOOL isIphonex;

@end

/*
 1.熟悉Objective-C
 1.了解Objective-C语言的起源
 2.在类的头文件中尽量少引入其他头文件
 3.多用字面量语法，少用与之等价的方法
 4.多用类型常量，少用#define预处理指令
 5.用枚举表示状态，选项，状态码
 
 
 2.对象，消息，运行期
 6.理解属性这一概念
 7.在对象内部尽量直接访问实例变量
 8.理解对象等同性这一概念
 9.以类族模式隐藏实现细节
 10.在既有类中使用关联对象存放自定义数据
 11.理解objc_msgSend的作用
 12.理解消息转发机制
 13.用“方法调配技术”调试黑盒方法
 14.理解类对象的用意
 
 
 3.接口与API设计
 15.用前缀避免命名空间冲突
 16.提供“全能初始化方法”
 17.实现description方法
 18.尽量使用不可变对象
 19.使用清晰而协调的命名方式
 20.为私有方法名加前缀
 21.理解Objective-C错误模型
 22.理解NSCopying协议
 
 
 4.协议与分类
 23.通过委托与数据源协议进行对象间通信
 24.将类的实现代码分散到便于管理的数个分类之中
 25.总是为第三方类的分类名称加前缀
 26.勿在分类中声明属性
 27.使用“class-continuationg”分类隐藏实现细节
 28.通过协议提供匿名对象
 
 
 5.内存管理
 29.理解引用计数
 30.以ARC简化引用计数
 31.在dealloc方法中只释放引用并解除监听
 32.编写“异常安全编码”时留意内存管理问题
 33.以弱引用避免保留环
 34.以“自动释放池快”降低内存峰值
 35.用”僵尸对象“调试内存管理问题
 36.不要使用retainCount
 
 
 6.快与大中枢调度
 37.理解快这一概念
 38.为常用的快类型创建typedef
 39.用handle快降低代码分散程度
 40.用快引用其所属对象时不要出现保留环
 41.多用派发队列，少用同步锁
 42.多用GCD，少用performSelector系列方法
 43.掌握GCD及操作队列的使用时机
 44.通过Dispatch group机制，根据系统资源状况来执行任务
 45.使用dispatch_once来执行只需运行一次的线程安全代码
 46.不要使用dispatch_get_current_queue
 
 
 7.系统框架
 47.熟悉系统框架
 48.多用快枚举，少用for循环
 49.对自定义其内存管理语义的collection使用无缝桥接
 50.构建缓存时选用NSCache而非NSDictionary
 51.精简initialize与load的实现代码
 52.别忘了NSTimer会保留其目标对象
 
 
 */
/*
 
 我们把频繁等待的线程称之为IO密集型线程，而把很少等待的线程称为CPU密集型线程
 在优先级调度的环境下，优先级的改变一般有三种方式：
 1.用户指定优先级
 2.根据进入等待的频繁程度提成或降低优先级，IO密集型线程总是比CPU密集型线程更容易得到优先级的提升
 3.长时间得不到执行而被提升优先级
 
 */
