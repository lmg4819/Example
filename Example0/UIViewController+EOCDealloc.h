//
//  UIViewController+EOCDealloc.h
//  Example0
//
//  Created by lmg on 2019/4/12.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (EOCDealloc)

@end

NS_ASSUME_NONNULL_END


/*
 1.The app register for push notifications,The OS asks APNS for a device token
 2.The app receives the device token
 3.The app send the token to your server
 4.When something interesting happens,your server sends a push notification to the APNS erver
 5.APNS server sends the push notification to your app.
 */

 /*
 UIView与CALayer
 UIView继承于UIResponder,(UIResponder继承于NSObject)
 CALayer继承于NSObject
 区别在于UIResponder这一层，UIView可以响应事件，而Layer不可以
 UIView对于绘图和动画都是layer完成的，UIView只是呈现Layer和处理交互响应事件
 
 */

/*
 多线程知识：
 1.同步执行+串行队列：不创建新线程，串行执行任务
 2.同步执行+主队列：在主队列中执行，崩溃，在其他线程执行，不创建新线程，串行执行任务
 3.同步执行+并行队列：不创建新线程，串行执行任务
 4.异步执行+串行队列：创建一条新线程，串行执行任务
 5.异步执行+主队列：不创建新线程，串行执行任务
 6.异步执行+并行队列：创建新线程，并发执行任务（真正的并行）
 */

/*
 NSOperationQueue与GCD的区别：
 1.任务之间添加依赖
 2.使用KVO监听
 3.可以取消
 4.任务设置优先级
 5.GCD更底层，执行速度更快一些
 6.GCD是底层C语言的API，NSOperationQueue是OC对象
 7.GCD拥有dispatch_once和dispatch_after函数
 8.NSOperationQueue可以设置最大并发数
 9.我们可以对NSOperation进行继承，可以添加更多自定制的功能。
 
 */

/*
 常见的内存泄露的几种情况：
 
 
 
 */

/*
 SDWebImage的加载逻辑：
 1根据URL查看是否内存中是否有图片缓存，如果有的话就回调block将图片返回
 2如果内存中没有，就去异步查找磁盘中是否有图片，如果从磁盘中读取到图片，将图片添加到内存缓存中，回调block将图片返回
 3内存和磁盘中都没有图片缓存，创建网络请求下载图片
 4图片下载完成后，数据完成后先做图片解码操作，将图片添加到内存缓存和磁盘缓存，回调block将图片返回，图片数据写入磁盘缓存中是异步操作
 */


/*
 原子性：
 atomic
 nonatomic iOS上会影响性能，默认为atomic，但是推荐使用nonatoic
 
 设置器语义：
 assign:默认设置，执行简单的赋值操作
 retain:在赋值时，输入值会被发送一条保留消息，而上一个值会被发送一条释放消息
 copy:在赋值时，输入值会被发送一条新消息的副本，而上一条值会被发送一条释放消息
 strong:在ARC下，和retain相同
 weak:在ARC下，和assign特性类似，但如果引用对象被释放了，属性的值会被设置为nil
 
 
 可读写性：
 readwrite：默认属性，必须实现getter和setter方法
 readonly：只读，必须实现getter方法
 
 方法名称：
 setter：将setter方法设置为新设置器的方法
 getter：将getter方法设置为新读取器的方法
 
 */

/*
 
 */

 /*
 设计模式的六大原则：开闭原则是目标，里氏代换原则是基础，依赖倒转原则是手段
 1.开闭原则
 对扩展开放，对修改封闭，我们需要使用接口和抽象化
 2.里氏代换原则
 基类出现的地方，子类一定可以出现，里氏代换原则是对实现抽象化的具体步骤的实现，也是继承复用的基石
 3.依赖倒转原则
 依赖于抽象，而不依赖于具体，面相接口编程
 4.接口隔离原则
 降低类之间的耦合
 5.迪米特原则（最少知道原则）
 一个实体应当尽量少的与其他实体之间发生相互作用，使得系统功能模块相对独立
 6.合成复用原则
 原则是尽量使用合成/聚合的方式，而不是使用继承
 
 iOS中常用的设计模式：
 观察者模式
 单例模式
 工厂模式
 策略模式
 适配器模式
 代理模式
 组合模式:
 中介者模式：URLRooter的实现
 
 
 
 */

//  您好，我叫罗孟歌，16年毕业与东北石油大学信息与计算科学专业，从15年8月份开始接触iOS开发，最开始在哈尔滨一家公司实习，16年初来到
//  北京开始工作，第一家公司我待了两年半，因为公司比较小，很快遇到了瓶颈期，所以去年6月我跳槽到了现在这家公司，在车易拍目前负责SDK的开发
//  ，我个人比较喜欢研究技术，除了平常的开发工作之外，我非常喜欢解决bug还有一些技术难题。
//
//
//  离职原因：
//  公司职级晋升体系不完善，被收购以后管理有些混乱，长期不涨工资
//
//  你对加班怎么看：
//  我对加班没有什么意见，也不反对，我目前单身，空闲时间在家我基本也就是看书刷剧之类的，
//  我对996也没什么反对的，其实只要薪资到位，我觉得加班可以接受。
//
//
//  你还有什么问题要问我的吗；
//  公司的上下班时间，加班情况，公司的职级晋升体系等


 

